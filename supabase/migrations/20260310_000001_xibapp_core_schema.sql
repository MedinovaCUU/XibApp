-- XibApp initial schema (Supabase / Postgres)
-- Project ref: gayjoopqsluogmphzmbp
-- NOTE:
-- 1) This migration includes permissive RLS policies for development.
-- 2) Replace those policies before production.

begin;

create extension if not exists pgcrypto;

-- Shared trigger for updated_at.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- =====================================================
-- Accounts
-- =====================================================

create table if not exists public.app_accounts (
  id uuid primary key default gen_random_uuid(),
  full_name text not null check (length(trim(full_name)) > 0),
  email text not null,
  phone text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists app_accounts_email_lower_uidx
  on public.app_accounts (lower(email));

drop trigger if exists trg_app_accounts_updated_at on public.app_accounts;
create trigger trg_app_accounts_updated_at
before update on public.app_accounts
for each row execute function public.set_updated_at();

-- =====================================================
-- Challenges + Event registrations
-- =====================================================

create table if not exists public.challenges (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  subtitle text not null,
  details text not null,
  -- Must match app raw values from ChallengeType.
  type text not null check (type in ('Promoción', 'Evento', 'Reto')),
  image_url text,
  cta_title text,
  is_featured boolean not null default false,
  featured_promotion text,
  event_start_date timestamptz,
  event_end_date timestamptz,
  event_location text,
  event_total_spots integer check (event_total_spots is null or event_total_spots > 0),
  deep_link text,
  tags text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint challenges_event_dates_chk
    check (event_end_date is null or (event_start_date is not null and event_end_date >= event_start_date))
);

create index if not exists challenges_type_idx on public.challenges (type);
create index if not exists challenges_is_featured_idx on public.challenges (is_featured);
create index if not exists challenges_event_start_date_idx on public.challenges (event_start_date);
create index if not exists challenges_tags_gin_idx on public.challenges using gin (tags);

drop trigger if exists trg_challenges_updated_at on public.challenges;
create trigger trg_challenges_updated_at
before update on public.challenges
for each row execute function public.set_updated_at();

create table if not exists public.event_registrations (
  id uuid primary key default gen_random_uuid(),
  challenge_id uuid not null references public.challenges(id) on delete cascade,
  account_id uuid not null references public.app_accounts(id) on delete cascade,
  account_name text not null,
  account_email text not null,
  created_at timestamptz not null default now(),
  unique (challenge_id, account_id)
);

create index if not exists event_registrations_challenge_idx
  on public.event_registrations (challenge_id, created_at desc);
create index if not exists event_registrations_account_idx
  on public.event_registrations (account_id, created_at desc);

-- Atomic event reservation (capacity + duplicate guards).
create or replace function public.reserve_event_spot(
  p_challenge_id uuid,
  p_account_id uuid,
  p_account_name text,
  p_account_email text
)
returns public.event_registrations
language plpgsql
security definer
set search_path = public
as $$
declare
  v_challenge public.challenges%rowtype;
  v_occupied integer;
  v_registration public.event_registrations%rowtype;
begin
  select *
  into v_challenge
  from public.challenges
  where id = p_challenge_id
  for update;

  if not found then
    raise exception 'CHALLENGE_NOT_FOUND';
  end if;

  if v_challenge.type <> 'Evento' then
    raise exception 'NOT_EVENT_CHALLENGE';
  end if;

  select count(*)
  into v_occupied
  from public.event_registrations
  where challenge_id = p_challenge_id;

  if v_challenge.event_total_spots is not null and v_occupied >= v_challenge.event_total_spots then
    raise exception 'EVENT_FULL';
  end if;

  insert into public.event_registrations (
    challenge_id,
    account_id,
    account_name,
    account_email
  ) values (
    p_challenge_id,
    p_account_id,
    p_account_name,
    p_account_email
  )
  on conflict (challenge_id, account_id) do nothing
  returning * into v_registration;

  if v_registration.id is null then
    raise exception 'ALREADY_REGISTERED';
  end if;

  return v_registration;
end;
$$;

create or replace function public.cancel_event_spot(
  p_challenge_id uuid,
  p_account_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.event_registrations
  where challenge_id = p_challenge_id
    and account_id = p_account_id;
end;
$$;

-- =====================================================
-- Exercises (current table consumed by app)
-- =====================================================

create table if not exists public.exercise_detail_v1 (
  id text primary key,
  slug text not null unique,
  name text not null,
  primary_media_url text,
  media_type text check (media_type in ('image', 'video')),
  similar_names text[] not null default '{}',
  instructions text[] not null default '{}',
  -- Arrays of objects expected by app:
  -- muscles: [{id, name, image_url}]
  -- equipment: [{id, name, icon_url}]
  muscles jsonb not null default '[]'::jsonb,
  equipment jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists exercise_detail_v1_slug_idx
  on public.exercise_detail_v1 (slug);

drop trigger if exists trg_exercise_detail_v1_updated_at on public.exercise_detail_v1;
create trigger trg_exercise_detail_v1_updated_at
before update on public.exercise_detail_v1
for each row execute function public.set_updated_at();

-- =====================================================
-- Nutrition
-- =====================================================

create table if not exists public.nutrition_recipes (
  id text primary key,
  title text not null,
  subtitle text not null,
  meal_type text not null check (meal_type in ('Desayuno', 'Comida', 'Colación', 'Cena')),
  prep_minutes integer not null default 0 check (prep_minutes >= 0),
  servings integer not null default 1 check (servings > 0),
  calories integer not null default 0 check (calories >= 0),
  protein integer not null default 0 check (protein >= 0),
  carbs integer not null default 0 check (carbs >= 0),
  fats integer not null default 0 check (fats >= 0),
  ingredients text[] not null default '{}',
  steps text[] not null default '{}',
  tags text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists nutrition_recipes_meal_type_idx
  on public.nutrition_recipes (meal_type);
create index if not exists nutrition_recipes_tags_gin_idx
  on public.nutrition_recipes using gin (tags);

drop trigger if exists trg_nutrition_recipes_updated_at on public.nutrition_recipes;
create trigger trg_nutrition_recipes_updated_at
before update on public.nutrition_recipes
for each row execute function public.set_updated_at();

create table if not exists public.nutrition_recipe_completions (
  id uuid primary key default gen_random_uuid(),
  account_id uuid not null references public.app_accounts(id) on delete cascade,
  recipe_id text not null references public.nutrition_recipes(id) on delete cascade,
  completed_on date not null default current_date,
  created_at timestamptz not null default now(),
  unique (account_id, recipe_id, completed_on)
);

create index if not exists nutrition_recipe_completions_account_day_idx
  on public.nutrition_recipe_completions (account_id, completed_on desc);

create table if not exists public.nutrition_recipe_favorites (
  id uuid primary key default gen_random_uuid(),
  account_id uuid not null references public.app_accounts(id) on delete cascade,
  recipe_id text not null references public.nutrition_recipes(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (account_id, recipe_id)
);

create index if not exists nutrition_recipe_favorites_account_idx
  on public.nutrition_recipe_favorites (account_id, created_at desc);

-- =====================================================
-- Routines + History
-- =====================================================

create table if not exists public.routines (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  muscle_group text not null check (muscle_group in ('Pecho', 'Espalda', 'Piernas', 'Hombros', 'Brazos', 'Core')),
  estimated_minutes integer not null default 0 check (estimated_minutes >= 0),
  difficulty text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists routines_muscle_group_idx
  on public.routines (muscle_group);

drop trigger if exists trg_routines_updated_at on public.routines;
create trigger trg_routines_updated_at
before update on public.routines
for each row execute function public.set_updated_at();

create table if not exists public.routine_exercises (
  id uuid primary key default gen_random_uuid(),
  routine_id uuid not null references public.routines(id) on delete cascade,
  name text not null,
  sets integer not null default 0 check (sets >= 0),
  reps integer not null default 0 check (reps >= 0),
  suggested_weight text not null,
  muscle_group text not null check (muscle_group in ('Pecho', 'Espalda', 'Piernas', 'Hombros', 'Brazos', 'Core')),
  notes text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create index if not exists routine_exercises_routine_sort_idx
  on public.routine_exercises (routine_id, sort_order, created_at);

create table if not exists public.completed_workouts (
  id uuid primary key default gen_random_uuid(),
  account_id uuid not null references public.app_accounts(id) on delete cascade,
  routine_id uuid references public.routines(id) on delete set null,
  muscle_group text not null check (muscle_group in ('Pecho', 'Espalda', 'Piernas', 'Hombros', 'Brazos', 'Core')),
  completed_at timestamptz not null default now()
);

create index if not exists completed_workouts_account_completed_idx
  on public.completed_workouts (account_id, completed_at desc);
create index if not exists completed_workouts_group_idx
  on public.completed_workouts (muscle_group, completed_at desc);

-- =====================================================
-- Development seed for Challenges
-- =====================================================

insert into public.challenges (
  id, title, subtitle, details, type, image_url, cta_title, is_featured, featured_promotion,
  event_start_date, event_end_date, event_location, event_total_spots, deep_link, tags
)
values
(
  '1f3a9f4d-4c4a-4ef2-be95-5b28a31b4e01',
  'Reto 30 Días Core',
  'Fortalece tu abdomen con rutinas guiadas diarias.',
  'Completa una sesión diaria de core durante 30 días para mejorar estabilidad y fuerza.',
  'Reto',
  'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1470&auto=format&fit=crop',
  'Unirme',
  true,
  null,
  null,
  null,
  null,
  null,
  null,
  array['Core', 'Disciplina', '30 días']
),
(
  'e8d60e3e-e2a0-4f8b-ae04-926f76558c62',
  '2x1 en Membresía Premium',
  'Activa tu plan anual hoy y obtén 2 meses gratis.',
  'Promoción válida por tiempo limitado para nuevos usuarios en plan anual.',
  'Promoción',
  'https://images.unsplash.com/photo-1734668485909-ab22515ba84f?q=80&w=1470&auto=format&fit=crop',
  'Aprovechar',
  true,
  '2x1',
  null,
  null,
  null,
  null,
  null,
  array['Oferta', 'Premium']
),
(
  'b6ed8a20-2fe8-4a34-9e8c-e5d6e0796ba9',
  'Meetup de la Comunidad',
  'Entrena con nosotros este sábado en el parque.',
  'Sesión abierta para la comunidad XibApp, con dinámica guiada y networking.',
  'Evento',
  'https://images.unsplash.com/photo-1554284126-aa88f22d8b74?q=80&w=1594&auto=format&fit=crop',
  'Ver detalles',
  false,
  null,
  now() + interval '3 day',
  now() + interval '3 day 90 minute',
  'CDMX',
  120,
  null,
  array['Comunidad', 'Outdoor']
)
on conflict (id) do update
set
  title = excluded.title,
  subtitle = excluded.subtitle,
  details = excluded.details,
  type = excluded.type,
  image_url = excluded.image_url,
  cta_title = excluded.cta_title,
  is_featured = excluded.is_featured,
  featured_promotion = excluded.featured_promotion,
  event_start_date = excluded.event_start_date,
  event_end_date = excluded.event_end_date,
  event_location = excluded.event_location,
  event_total_spots = excluded.event_total_spots,
  deep_link = excluded.deep_link,
  tags = excluded.tags,
  updated_at = now();

-- =====================================================
-- Row Level Security (development-friendly)
-- =====================================================

alter table public.app_accounts enable row level security;
alter table public.challenges enable row level security;
alter table public.event_registrations enable row level security;
alter table public.exercise_detail_v1 enable row level security;
alter table public.nutrition_recipes enable row level security;
alter table public.nutrition_recipe_completions enable row level security;
alter table public.nutrition_recipe_favorites enable row level security;
alter table public.routines enable row level security;
alter table public.routine_exercises enable row level security;
alter table public.completed_workouts enable row level security;

-- Public read policies for catalog/content tables.
drop policy if exists "Public read challenges" on public.challenges;
create policy "Public read challenges"
  on public.challenges for select
  using (true);

drop policy if exists "Public read exercise_detail_v1" on public.exercise_detail_v1;
create policy "Public read exercise_detail_v1"
  on public.exercise_detail_v1 for select
  using (true);

drop policy if exists "Public read nutrition_recipes" on public.nutrition_recipes;
create policy "Public read nutrition_recipes"
  on public.nutrition_recipes for select
  using (true);

drop policy if exists "Public read routines" on public.routines;
create policy "Public read routines"
  on public.routines for select
  using (true);

drop policy if exists "Public read routine_exercises" on public.routine_exercises;
create policy "Public read routine_exercises"
  on public.routine_exercises for select
  using (true);

-- Development policies (replace before production).
drop policy if exists "Dev full access app_accounts" on public.app_accounts;
create policy "Dev full access app_accounts"
  on public.app_accounts for all
  using (true)
  with check (true);

drop policy if exists "Dev full access event_registrations" on public.event_registrations;
create policy "Dev full access event_registrations"
  on public.event_registrations for all
  using (true)
  with check (true);

drop policy if exists "Dev full access nutrition_recipe_completions" on public.nutrition_recipe_completions;
create policy "Dev full access nutrition_recipe_completions"
  on public.nutrition_recipe_completions for all
  using (true)
  with check (true);

drop policy if exists "Dev full access nutrition_recipe_favorites" on public.nutrition_recipe_favorites;
create policy "Dev full access nutrition_recipe_favorites"
  on public.nutrition_recipe_favorites for all
  using (true)
  with check (true);

drop policy if exists "Dev full access completed_workouts" on public.completed_workouts;
create policy "Dev full access completed_workouts"
  on public.completed_workouts for all
  using (true)
  with check (true);

commit;
