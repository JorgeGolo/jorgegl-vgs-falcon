# Prueba técnica PHP Developer — Parte 2: Prestashop (tema Falcon)

## 📋 Descripción

Maquetación y desarrollo a medida sobre **Prestashop 8.2**, usando el framework de tema **[Falcon](https://github.com/Oksydan/falcon)** (Smarty + SCSS + Webpack).

Alcance de esta prueba (según enunciado):

- Página de Categoría: listado de productos + tarjeta de producto (responsive).
- Ficha de Producto: galería de imágenes + información + "Añadir al carrito" (funcional, incluyendo combinaciones talla/color si aplica).
- **No incluye maquetación de Home.**

## 🧰 Stack y requisitos para el desarrollo

| Herramienta          | Versión usada  | Notas                                                                               |
| -------------------- | -------------- | ----------------------------------------------------------------------------------- |
| Prestashop           | 8.2.7          | Última build estable de la rama 8.2 (obligatorio 8.x, prohibido PS9)                |
| PHP                  | 8.1            | Versión mínima soportada por Falcon v3.1.x / PS 8.2. Configurado por-sitio en Herd. |
| Node.js              | ≥ 15           | Requerido por Falcon v3.1.x (ver tabla de compatibilidad del propio tema)           |
| MySQL/MariaDB        | 8.0            | Vía DBngin                                                                          |
| Tema base            | Falcon v3.1.x  | https://github.com/Oksydan/falcon                                                   |
| Plantillas           | Smarty (.tpl)  | —                                                                                   |
| Estilos              | SCSS (Webpack) | Evitar `!important`                                                                 |
| Control de versiones | Git            | Repo público, solo carpeta del tema                                                 |

### Módulos Falcon requeridos

- `is_imageslider`
- `is_searchbar`
- `is_shoppingcart`
- `is_themecore`

### Módulos opcionales

- `is_favoriteproducts`
  > ⚠️ Los módulos se descargan como **release** (zip) desde GitHub, no clonando el repo — si se clona hay que ejecutar `composer install` manualmente.

## Breve guía del uso de este repositorio

1. Clonar en /themes
2. Ejecutar en la terminal

- npm install: instala dependecias
- npm run project-init: Configurar el tema falcon para el sitio
- npm run build: build de producción

## 🖥️ Entorno local: por qué Herd

Para el entorno de desarrollo autoalojado se ha optado por **[Herd](https://herd.laravel.com/)** en lugar de otras alternativas (XAMPP, Docker, MAMP, Valet, etc.), principalmente por:

- **Gestión de versiones de PHP por sitio**: Herd permite asignar una versión de PHP distinta a cada sitio local de forma individual desde su propia interfaz, sin tener que tocar la configuración global del sistema ni depender de `phpbrew`/`update-alternatives`. Esto es especialmente relevante en esta prueba porque **Prestashop 8.2 y el tema Falcon requieren PHP 8.1**, mientras que otros proyectos en la misma máquina (incluida la parte 1 de WordPress) pueden usar versiones distintas sin conflicto.
- **Cero fricción de configuración**: crea el vhost local (necesario para Falcon, que requiere un dominio tipo `nombre.test`) de forma automática al detectar la carpeta del proyecto, sin editar manualmente `hosts` ni la configuración del servidor web.
- **Ligereza**: al no depender de contenedores, el arranque y recarga del entorno es prácticamente instantáneo, lo cual agiliza el ciclo de compilación de assets (`npm run watch` / `npm run dev`) propio de Falcon.
  > Durante la instalación inicial el sitio quedó configurado por defecto con PHP 8.4, lo que generó _deprecation warnings_ del tipo `Implicitly marking parameter ... as nullable is deprecated` en el core de Prestashop/Smarty (no preparado para PHP 8.4). Se corrigió fijando la versión de PHP del sitio a **8.1** desde Herd (Sites → `nombre-del-sitio` → versión de PHP), que es la versión mínima soportada oficialmente por Falcon v3.1.x y por la que compatibiliza sin warnings con PS 8.2.

## ⚙️ Instalación local

```bash
# TODO: completar con los pasos reales una vez instalado, siguiendo el patrón:
# 1. Base de datos (nombre, usuario, host)
# 2. Instalación de Prestashop 8.2.7 (con datos de demo activados)
#    - Descarga de la versión desde: https://prestashop.es/versions/
#    - Se definió la variable de entorno OPENSSL_CONF vía PowerShell para eliminar
#      el error de instalación: "No se pueden generar claves privadas usando
#      openssl_pkey_new. Verifica la configuración de OpenSSL, especialmente la
#      ruta al archivo openssl.cafile."
#    - Se modificó el php.ini para eliminar el aviso: "Setting 'realpath_cache_size'
#      to e.g. '5242880' or '5M' in php.ini* may improve performance on Windows
#      significantly in some cases."
#    - Se revisaron y habilitaron en el php.ini las extensiones requeridas por
#      Prestashop (curl, gd, intl, mbstring, openssl, pdo_mysql, soap, zip, ...)
# 3. vhost / dominio local (Herd) — Falcon requiere vhost tipo falcon.test
# 4. Descarga e instalación del tema Falcon (zip release, no clonar)
# 5. Descarga e instalación de módulos requeridos (zip release)
# 6. Activar tema en BO: Diseño > Temas y Logo
```

## 🎨 Compilación de assets (Falcon)

```bash
cd themes/<nombre-tema>/_dev
npm install
npm run project-init   # genera .env y compila assets inicial
npm run build           # build de producción
npm run watch           # o npm run dev (webpack-dev-server) durante desarrollo
```

## 🧩 Decisiones técnicas

_TODO — se documentará según se vaya desarrollando, por ejemplo:_

- Justificación de plantillas modificadas (`category.tpl`, `product.tpl`, partials de la product card).
- Uso de variables Bootstrap/Falcon en vez de `!important`.
- Tratamiento de combinaciones de producto (JS nativo vs. lógica ya provista por `is_shoppingcart`).

- Estructura SCSS por componentes. Al maquetar la ficha de producto, se detectó que el tema ya organiza sus estilos en carpetas por componente, cada una con un \_index.scss que reexporta sus partials (p. ej. product-gallery/, product-variants/). Para mantener esa convención, la información propia del título de producto se ha añadido en una nueva carpeta product-info/, siguiendo el mismo patrón (\_index.scss + archivo(s) de propiedad), en vez de añadir el estilo como un bloque suelto en el archivo raíz.

## 🐛 Dificultades encontradas

Surgieron problemas típicos durante la instalación, todos resueltos:

1. **Extensiones nativas de Herd (Redis/MongoDB) como sospechosas de crash silencioso.** El `php.ini` de Herd trae por defecto extensiones para Redis y MongoDB, que no se usan en este proyecto. Se comentaron temporalmente para descartar incompatibilidades, ya que un HTTP 500 con `{"success":true,"message":""}` y sin log generado es típico de un crash de proceso (no de un error de PHP capturable).
2. **`error_log` con ruta relativa.** El `php.ini` traía `error_log = php_errors.log` sin ruta absoluta, por lo que el log no se generaba donde se esperaba. Se corrigió a una ruta absoluta (`error_log = "C:\Users\jorge\php_errors.log"`), lo cual permitió finalmente capturar el error real.
3. **Bug conocido del core de Prestashop 8.1.x en Windows: `Undefined constant "_DB_PREFIX_"` en `Configuration.php:175`.** Una vez visible el log, el error real durante el paso "Instalando tema" fue:
   ```
   PHP Fatal error: Uncaught Error: Undefined constant "_DB_PREFIX_" in classes\Configuration.php:175
   ```
   Se confirmó que es un **bug documentado del propio repositorio oficial de PrestaShop** ([issue #33717](https://github.com/PrestaShop/PrestaShop/issues/33717)), reportado repetidamente para instalaciones en Windows sobre PHP 8.x: código legado que trataba una constante no definida como si fuera un string (comportamiento válido en PHP 7, error fatal en PHP 8+). Es un fallo puntual de una petición interna del instalador (precompilación de Smarty) que no siempre bloquea el resto del proceso. Se resolvió reintentando la instalación (`?restart=true`), tras lo cual el proceso avanzó y completó correctamente.
4. **Sitio en modo "mantenimiento" tras la instalación.** Comportamiento por defecto de Prestashop tras un install nuevo, no un error. Se desactivó desde el BO (Preferencias > Mantenimiento) tras iniciar sesión y eliminar la carpeta `/install` (paso de seguridad obligatorio post-instalación).

## ✅ Checklist de entregables (según enunciado)

- [x] Repositorio Git público, solo carpeta del tema Falcon
- [ ] Página de Categoría maquetada y responsive
- [ ] Ficha de Producto maquetada (galería + info + add to cart funcional)
- [ ] Combinaciones de producto (si aplica) funcionando
- [ ] Vídeo demo (máx. 3 min): categoría → producto → añadir al carrito → responsive (inspector) → estructura de carpetas
- [ ] README.md con instrucciones de compilación y dificultades encontradas
