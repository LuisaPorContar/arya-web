# Arya Web: cómo ponerla en línea

La web lee los productos de la app Arya (mismo proyecto de Supabase). Cada producto que creas en la app aparece solo en la web, **sin precio**, con el botón **Pedir cotización** que abre WhatsApp (+57 310 746 0713). La web se actualiza sola cada minuto.

## 1. Conectar la web con la app (una sola vez)
1. Entra a https://supabase.com/dashboard y abre el proyecto de Arya.
2. Abre **SQL Editor > New query**.
3. Copia todo el contenido de `supabase/catalogo-web.sql`, pégalo y toca **Run**.
4. Debe aparecer "Success. No rows returned".

Esto permite que la web vea solo el nombre y la foto de cada producto. El precio, los clientes, las ventas, los abonos y los comprobantes siguen privados.

## 2. Publicar en Netlify
1. Entra a https://app.netlify.com/drop.
2. Arrastra la carpeta **Web Arya** completa.
3. Cambia el nombre del sitio en **Site configuration > Change site name** (por ejemplo `arya-personalshopper`).

## Cambiar datos
- WhatsApp: en `index.html`, busca `const WHATSAPP = '573107460713'`.
- Instagram: busca `aryamedellin` en `index.html`.
- Fotos: `img/melissa.jpg` y `img/logo-arya.png`.
