# Supabase setup (XibApp)

## Migration file
- `supabase/migrations/20260310_000001_xibapp_core_schema.sql`
- `supabase/migrations/20260317_000002_exercise_technique_column.sql`
- `supabase/migrations/20260825_000003_daily_motivation_phrases.sql`

## How to apply in project `gayjoopqsluogmphzmbp`
1. Open Supabase dashboard for your project.
2. Go to `SQL Editor`.
3. Paste and run migrations in order.

## What it creates
- Accounts: `app_accounts`
- Challenges: `challenges`
- Event reservations: `event_registrations`
- Exercises: `exercise_detail_v1`
- Nutrition: `nutrition_recipes`, `nutrition_recipe_completions`, `nutrition_recipe_favorites`
- Routines: `routines`, `routine_exercises`, `completed_workouts`
- Daily motivation: `daily_motivation_phrases`
- Helpers: triggers (`updated_at`) + functions (`reserve_event_spot`, `cancel_event_spot`)
- RLS policies (development-friendly, permissive for user data)

## Important
- The migration intentionally uses permissive policies for fast development.
- Before production, replace `Dev full access ...` policies with authenticated user policies.
