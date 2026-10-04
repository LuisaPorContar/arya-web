-- Arya Web: catálogo público conectado a la app.
-- Pegar completo en Supabase > SQL Editor y presionar Run. Se puede correr más de una vez.
--
-- Qué hace:
--   1. Crea la función catalogo_web(), que la página web puede leer sin iniciar sesión.
--      Devuelve SOLO id, nombre, foto y fecha de cada producto. El precio nunca sale de la base de datos.
--   2. Permite que la web vea las fotos de los productos del catálogo.
--      Los comprobantes de pago y cualquier otro archivo siguen siendo privados.

-- ---------- 1. Catálogo sin precio ----------
create or replace function public.catalogo_web()
returns table (id text, nombre text, foto text, creado bigint)
language sql
stable
security definer
set search_path = public
as $$
  select p.id, p.nombre, p.foto, p.creado
  from public.productos p
  order by p.creado desc;
$$;

revoke all on function public.catalogo_web() from public;
grant execute on function public.catalogo_web() to anon, authenticated;

-- ---------- 2. Fotos del catálogo visibles en la web ----------
create or replace function public.es_foto_catalogo(ruta text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (select 1 from public.productos where foto = ruta);
$$;

revoke all on function public.es_foto_catalogo(text) from public;
grant execute on function public.es_foto_catalogo(text) to anon, authenticated;

drop policy if exists "catalogo_fotos_publicas" on storage.objects;
create policy "catalogo_fotos_publicas" on storage.objects for select to anon
  using (bucket_id = 'archivos' and public.es_foto_catalogo(name));
