insert into public.properties (title, description, operation, type, bedrooms, bathrooms, total_m2, covered_m2, price, currency, city, province, address, featured)
values
('Casa de 2 dormitorios', 'Gran sala y comedor. 1 baño en suite.', 'venta', 'casa', 2, 2, 184, 140, 85000, 'USD', 'Pico Truncado', 'Santa Cruz', 'Barrio Centro', true),
('Depto céntrico 1D', 'Luminoso, ideal inversión.', 'alquiler', 'departamento', 1, 1, 45, 45, 180000, 'ARS', 'Pico Truncado', 'Santa Cruz', 'Av. San Martín 100', false);

-- Reemplaza con URLs reales de tu bucket
insert into public.property_images (property_id, url, is_cover)
select id, 'https://ubbzpmyuhcqkmlifbwub.supabase.co/storage/v1/object/public/properties/casa-2d.jpg', true from public.properties where title='Casa de 2 dormitorios';

insert into public.property_images (property_id, url, is_cover)
select id, 'https://ubbzpmyuhcqkmlifbwub.supabase.co/storage/v1/object/public/properties/depto-1d.jpg', true from public.properties where title='Depto céntrico 1D';