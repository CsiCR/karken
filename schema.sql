-- Esquema básico para catálogo inmobiliario
create table if not exists public.properties (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  operation text not null check (operation in ('venta','alquiler')),
  type text not null check (type in ('casa','departamento','terreno','local','galpón','oficina','otro')),
  bedrooms int not null default 0,
  bathrooms int not null default 0,
  covered_m2 numeric(10,2),
  total_m2 numeric(10,2),
  price numeric(12,2),
  currency text not null default 'USD',
  city text not null default 'Pico Truncado',
  province text not null default 'Santa Cruz',
  address text,
  featured boolean not null default false,
  created_at timestamp with time zone default now()
);

create table if not exists public.property_images (
  id bigint generated always as identity primary key,
  property_id uuid references public.properties(id) on delete cascade,
  url text not null,
  is_cover boolean not null default false,
  created_at timestamp with time zone default now()
);

-- Vistas prácticas
create or replace view public.v_properties as
select p.*, (
  select url from public.property_images i
  where i.property_id = p.id and i.is_cover = true
  order by i.id asc limit 1
) as cover_url
from public.properties p;

-- Habilitar RLS (Row Level Security)
alter table public.properties enable row level security;
alter table public.property_images enable row level security;

-- Políticas para lectura pública (catálogo)
create policy "Public can read properties" on public.properties
  for select using (true);

create policy "Public can read property images" on public.property_images
  for select using (true);

-- (Opcional) Políticas de inserción/edición sólo para usuarios autenticados con rol 'editor'
-- Puedes ampliar con auth.uid() en una tabla de perfiles.