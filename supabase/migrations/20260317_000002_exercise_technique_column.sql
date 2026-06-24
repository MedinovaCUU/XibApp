-- Split technique label from exercise title.
-- Table: public.exercise_detail_v1

begin;

alter table if exists public.exercise_detail_v1
  add column if not exists technique text;

-- Backfill current records where name stores variants like:
-- "Elevaciones laterales con mancuernas - Tecnica base"
-- Result:
-- name = "Elevaciones laterales con mancuernas"
-- technique = "Tecnica base"
update public.exercise_detail_v1
set
  technique = case
    when coalesce(technique, '') = '' and position(' - ' in name) > 0
      then nullif(trim(substring(name from position(' - ' in name) + 3)), '')
    else technique
  end,
  name = case
    when position(' - ' in name) > 0
      then trim(split_part(name, ' - ', 1))
    else name
  end
where position(' - ' in name) > 0;

commit;
