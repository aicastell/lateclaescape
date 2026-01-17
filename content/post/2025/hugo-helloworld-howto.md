---
title: Hugo Helloworld
date: 2025-08-20
image: /img/posts/hugo-helloworld-howto.webp
categories: [ "framework" ]
tags: [ "hugo", "howto", "helloworld" ]
draft: false
featured: true
---

# Introducción

[Hugo](/post/2025/framework-hugo) es un generador de sitios web estáticos extremadamente rápido: puede crear un sitio completo en cuestión de décimas de segundo. Además, es flexible y modular, permitiendo personalizar desde el contenido hasta el diseño y la lógica de plantillas.

El artículo anterior sobre Hugo explica [cómo instalar Hugo](/post/2025/hugo-install-howto) en tu ordenador. Si todavía no lo tienes instalado, empieza por hacerlo antes de continuar leyendo este artículo.

Este artículo avanza en esta serie de artículos sobre Hugo, explicando paso a paso como utilizar este framework para crear y visualizar tu primer website.

## Crear el website

Para iniciar un nuevo proyecto en Hugo llamado *MyWebsite*, abre una terminal y ejecuta el siguiente comando:

```
$ hugo new site MyWebsite
```

Este comando genera una estructura de directorios con el siguiente contenido:

```
$ tree MyWebsite/
MyWebsite/
├── archetypes
│   └── default.md
├── assets
├── content
├── data
├── hugo.toml
├── i18n
├── layouts
├── static
└── themes
```

Explico brevemente lo que significa cada directorio, sin entrar en muchos detalles.

- archetypes/ directorio que almacena plantillas para nuevos contenidos.
- assets/ directorio que almacena recursos procesables (CSS, JS, imágenes optimizadas).
- content/ directorio que almacena archivos de contenido en formato Markdown u otros.
- data/ directorio que almacena ficheros de datos (YAML, JSON, TOML) accesibles desde las plantillas.
- hugo.toml fichero principal de configuración del sitio.
- i18n/ directorio que almacena traducciones para contenido multi-lenguaje
- layouts/ directorio que almacena plantillas HTML personalizadas.
- static/ directorio que almacena archivos estáticos que se copian tal cual al sitio final (imágenes, fuentes, etc.).
- themes/ directorio que almacena temas instalados para definir el diseño del sitio.

En artículos posteriores se explicarán más detalles sobre cada uno de estos directorios. Este artículo se centra en explicar lo mínimo y necesario para que aprendas a crear tu primera página web con Hugo.

# Elegir tema

En el contexto del framework Hugo, un tema es un conjunto estructurado de archivos que definen cómo se transforman los contenidos escritos en markdown en páginas HTML completas.

Al crear un nuevo sitio con Hugo, no se incluye un tema por defecto. Esto significa que Hugo no sabrá como transformar los archivos markdown en HTML. Por eso, el primer paso tras crear un sitio con Hugo es elegir su tema y posteriormente instalarlo dentro de la carpeta themes/ del proyecto.

En este ejemplo vamos a usar *Ananke*, un tema popular y sencillo, disponible públicamente en GitHub. Para usar *ananke* en Hugo, sigue estos pasos:

Primero, entra dentro de la carpeta del proyecto que acabas de crear:

```
$ cd MyWebsite
```

Inicializa un repositorio Git:

```
$ git init
```

Luego añade *ananke* como un submódulo de git:

```
$ git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
```

Esto descargará el tema *ananke* dentro del directorio themes/ananke.

Ahora necesitas indicarle a Hugo que el nuevo sitio que acabas de crear utilizará este tema. Para ello, abre el archivo hugo.toml y añade el siguiente contenido:

```
theme = "ananke"
```

Esto es todo lo que Hugo necesita para saber el tema del nuevo sitio web que que acabas de crear. A partir de ahora, Hugo ya sabe las plantillas que debe usar para renderizar correctamente el contenido, porque el tema define los layouts por defecto.

# Crea tu primera pagina

Para crear la primera pagina web de tu sitio web, ejecuta el siguiente comando:

```
$ hugo new posts/my-first-post.md
```

Este comando genera un archivo content/posts/my-first-post.md en formato Markdown con una cabecera inicial conocida como [Front Matter](https://gohugo.io/content-management/front-matter/) (cabecera de metadatos) en formato TOML.

Usa este comando para visualizar el contenido del archivo generado:

```
$ cat content/posts/my-first-post.md
+++
date = '2025-08-11T11:40:12+02:00'
draft = true
title = 'My First Post'
+++
```

Fíjate que la página tiene un titulo (title), una fecha de creación (date) y un modo borrador (draft) que puede estar a true o a false. Luego hablaré sobre este modo borrador.

# Edita el contenido

Edita el fichero, y añade este contenido:

```
$ vi content/posts/my-first-post.md
+++
date = '2025-08-11T11:40:12+02:00'
draft = true
title = 'My First Post'
+++

Hola mundo, este es mi primer proyecto en Hugo.
Pulso la tecla ESC, :wq!
```

Graba los cambios y sal del fichero.

# Servidor web local

Hugo es capaz de correr un servidor web local para mostrarte el contenido de tu sitio web. Puedes arrancarlo de esta manera:

```
$ hugo server
```

Cuando Hugo crea una nueva página web, la crea en modo borrador (draft = true). En este modo, el servidor web de Hugo mantiene la web oculta, es decir, no forma parte de la web que publica. Si quieres que el servidor web muestre también los borradores (draft = true), añade la opción -D al final:

```
$ hugo server -D
```

Ahora abre tu navegador web favorito y haz que apunte a esta URL local, en el puerto 1313:

```
http://localhost:1313
```

Veras tu primer web-site desarrollado con Hugo usando el tema *ananke*.

![Hugo helloworld first website](/img/hugo-helloworld-first-website.webp)

# Despedida

En este artículo hemos creado un sitio básico con Hugo, instalado un tema y puesto en marcha un servidor local para verlo en acción. Esto es solo el comienzo: en los próximos artículos aprenderás a organizar el contenido como un profesional, personalizar el diseño de tu sitio y automatizar el despliegue para producción.

Además, prepararé una guía específica sobre Markdown, el lenguaje que hace que escribir en Hugo sea rápido y limpio. Si esta herramienta te ha sorprendido por su velocidad y simplicidad, espera a ver todo lo que puedes hacer con ella.

¿Estas listo para llevar tu web al siguiente nivel? ¡Nos vemos en la próxima entrega!

Pulso la tecla `ESC:wq!`
