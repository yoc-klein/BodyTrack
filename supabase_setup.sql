-- =============================================
-- BODYTRACK - Run this in Supabase SQL Editor
-- =============================================

-- 1. WEIGHT ENTRIES
create table if not exists weight_entries (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  date date not null,
  weight numeric(5,2) not null,
  bmi numeric(4,1) not null,
  note text,
  created_at timestamptz default now(),
  unique(user_id, date)
);
alter table weight_entries enable row level security;
create policy "own_weight" on weight_entries for all using (auth.uid() = user_id);

-- 2. USER SETTINGS
create table if not exists user_settings (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade not null unique,
  height numeric(5,1),
  age integer,
  gender text,
  goal_weight numeric(5,2),
  goal_date date,
  lang text default 'en',
  daily_calorie_goal integer default 2000,
  updated_at timestamptz default now()
);
alter table user_settings enable row level security;
create policy "own_settings" on user_settings for all using (auth.uid() = user_id);

-- 3. FOOD LOGS
create table if not exists food_logs (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  date date not null default current_date,
  meal_type text not null check (meal_type in ('Breakfast','Lunch','Dinner','Snack')),
  dish_name text not null,
  calories integer not null,
  protein_g numeric(6,1) default 0,
  carbs_g numeric(6,1) default 0,
  fat_g numeric(6,1) default 0,
  fiber_g numeric(6,1) default 0,
  created_at timestamptz default now()
);
alter table food_logs enable row level security;
create policy "own_food_logs" on food_logs for all using (auth.uid() = user_id);

-- 4. SAVED MENUS
create table if not exists saved_menus (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  name text not null,
  goal text,
  calories_per_day integer,
  diet_type text,
  menu_data jsonb not null,
  created_at timestamptz default now()
);
alter table saved_menus enable row level security;
create policy "own_menus" on saved_menus for all using (auth.uid() = user_id);

-- 5. INDEXES
create index if not exists idx_weight_user_date on weight_entries(user_id, date desc);
create index if not exists idx_food_user_date on food_logs(user_id, date desc);
create index if not exists idx_menus_user on saved_menus(user_id, created_at desc);
