---
title: Hugo Markdown Guide
date: 2025-09-02
image: /img/posts/hugo-markdown-guide.webp
categories: [ "framework" ]
tags: [ "hugo", "howto", "markdown" ]
draft: false
featured: true
---

# Guía de Markdown en Hugo

Cuando creas un sitio web, lo más importante es el contenido. Sin contenido, cualquier diseño o funcionalidad pierde sentido. Por eso, el primer paso para construir un buen proyecto es aprender a generar información clara y bien organizada.

Durante mucho tiempo, la forma más común de redactar contenido para la web fue utilizando HTML. Sin embargo, escribir directamente en HTML implica lidiar con una sintaxis compleja y rodear cada fragmento de texto con múltiples etiquetas. Esto hace que el documento sea menos legible y más difícil de mantener.

Para simplificar este proceso, hoy en día se emplea Markdown, un lenguaje de texto plano con un formato ligero y fácil de aprender, diseñado para aplicar estilo y estructura al contenido sin complicaciones, manteniendo la escritura limpia y legible.

Hugo, el generador de sitios estáticos del que estamos hablando, adopta Markdown como formato estándar para crear los artículos. Con Markdown puedes concentrarte en lo importante: escribir buen contenido, mientras Hugo se encarga de transformarlo en HTML y aplicarle el diseño correspondiente.

En este artículo descubrirás qué es Markdown y cómo utilizarlo en Hugo para redactar artículos bien organizados y atractivos. Aprenderás su sintaxis básica y algunos consejos prácticos para incorporarlo a tu flujo de trabajo.

# ¿Qué es Markdown?

Markdown es un lenguaje de marcado ligero que permite dar formato al texto de manera clara y sencilla. A diferencia del HTML, que utiliza etiquetas complejas, Markdown emplea una sintaxis mínima y fácil de aprender. Gracias a su simplicidad, el contenido en Markdown resulta legible incluso en su forma original, sin necesidad de procesarlo.

Una de sus principales ventajas es que el texto escrito en Markdown es limpio, portable y fácil de reutilizar. Esto significa que puedes compartirlo con otras personas sin convertirlo previamente a otro formato y sin riesgo de perder calidad.

Cuando trabajas con Hugo, los archivos en Markdown son la base del contenido. Tú escribes el artículo en texto plano con esta sintaxis ligera y Hugo se encarga de interpretarlo, generando automáticamente el código HTML necesario y aplicando el diseño definido por tu tema. De esta forma, tú te concentras en redactar contenido claro y bien estructurado, mientras Hugo se ocupa de la presentación.

Markdown no es exclusivo de Hugo. Es un estándar ampliamente adoptado, puedes reutilizar el mismo archivo en otras plataformas como Github, o exportarlo fácilmente a diferentes formatos como PDF o Word. Esto convierte a Markdown en una herramienta versátil y eficiente para la creación de contenido, no solo en proyectos web, sino también en cualquier entorno que requiera textos bien formateados.

# Los elementos de Markdown

Para empezar a escribir con Markdown, debes conocer sus elementos principales. A continuación de presento los mas importantes:

## Encabezados

Los encabezados se crean con el símbolo #. Puedes usar hasta 6 niveles:

{{< highlight markdown >}}
# Encabezado 1
## Encabezado 2
### Encabezado 3
#### Encabezado 4
##### Encabezado 5
###### Encabezado 6
{{< /highlight >}}

Y se ven así:

# Encabezado 1
## Encabezado 2
### Encabezado 3
#### Encabezado 4
##### Encabezado 5
###### Encabezado 6

## Párrafos y Saltos de Línea

Un párrafo se crea escribiendo texto normal. Para un salto de línea, añade dos espacios al final de la línea o deja una línea en blanco.

{{< highlight markdown >}}
Este es un párrafo.

Este es otro párrafo.
{{< /highlight >}}

Y se ven así:

Este es un párrafo.

Este es otro párrafo.

## Texto en Negrita, Cursiva y Tachado

Para usar negrita, cursiva o tachado, debes poner esto:

{{< highlight markdown >}}
**Esto es negrita**

*Esto es cursiva*

~~Esto es tachado~~
{{< /highlight >}}

Y se ven así:

**Esto es negrita**.

*Esto es cursiva*.

~~Esto es tachado~~.

## Listas

Hay dos tipos de listas: listas ordenadas y listas no ordenadas.

### Listas no ordenadas

Debes definirlas de esta manera:

{{< highlight markdown >}}
- Elemento 1
- Elemento 2
  - Sub-elemento
{{< /highlight >}}

Y se ven así:

- Elemento 1
- Elemento 2
  - Sub-elemento

### Listas ordenadas

Debes definirlas de esta manera:

{{< highlight markdown >}}
1. Primer item
2. Segundo item
   1. Sub Item
{{< /highlight >}}

Y se ven así:

1. Primer item
2. Segundo item
   1. Sub Item

## Enlaces

Debes definirlos así:

{{< highlight markdown >}}
Pulsa en [LaTeclaESC](https://www.lateclaescape.com)
{{< /highlight >}}

Y se verán de esta manera:

Pulsa en [LaTeclaESC](https://www.lateclaescape.com)

## Imágenes y recursos locales

En Hugo, las imágenes suelen colocarse en la carpeta static/ o en la carpeta assets/. Luego se insertan en Markdown como:

{{< highlight markdown >}}
![Logo de Golang](/img/golang-logo.webp)
{{< /highlight >}}

Y se ven de esta manera:

![Logo de Golang](/img/golang-logo.webp)

### Figura con leyenda

Puedes poner una figura con leyenda:

{{</* figure src="/img/hugo-logo.webp" title="Logo de Hugo" */>}}

Y veras esto:

{{< figure src="/img/hugo-logo.webp" title="Logo de Hugo" >}}

## Citas

Para citar texto, usa > al inicio:

{{< highlight markdown >}}
> Esto es una cita inspiradora de un personaje muy importante.
{{< /highlight >}}

Y se verá de esta manera:

> Esto es una cita inspiradora de un personaje muy importante.

## Código y Bloques de Código

Esto es un bloque de código

{{< highlight markdown >}}
```
for (int i=0; i < 10; i++) {
    printf("La variable i vale %d\n", i);
}
```
{{< /highlight >}}

Y se ve de esta manera:

```
for (int i=0; i < 10; i++) {
    printf("La variable i vale %d\n", i);
}
```

## Tablas

Las tablas se codifican siguiendo esta estructura:

{{< highlight markdown >}}
| Producto | Precio | Stock |
|----------|--------|-------|
| Hugo     | 0 €    | Sí    |
| Theme    | 0 €    | Sí    |
| Hosting  | 5 €    | No    |
{{< /highlight >}}

Y se ven renderizadas de esta manera:

| Producto | Precio | Stock |
|----------|--------|-------|
| Hugo     | 0 €    | Sí    |
| Theme    | 0 €    | Sí    |
| Hosting  | 5 €    | No    |

## Shortcodes en Hugo

Además de Markdown puro, Hugo ofrece shortcodes para añadir funcionalidades extra:

### Youtube

Para agregar un enlace de Youtube para un vídeo que tiene esta URL: https://www.youtube.com/watch?v=uTRGfX2vZ_A, en tu documento Markdown, puedes poner esto:

{{</* youtube uTRGfX2vZ_A */>}}

donde "uTRGfX2vZ_A" es el ID del vídeo de youtube, y verás el contenido enlazado dentro de tu página web:

{{< youtube uTRGfX2vZ_A >}}

## Separadores

Para crear una línea horizontal, puedes poner esto:

{{< highlight markdown >}}
---
{{< /highlight >}}

Y lo verás es esta linea:

---

# Conclusión

Markdown es un lenguaje sencillo pero muy potente. Dominarlo te permitirá crear artículos claros y bien estructurados. Y con los shortcodes de Hugo, podrás enriquecer fácilmente tu contenido con elementos dinámicos y vistosos.

Te animo a que prepares tu primer artículo en Markdown para practicar.

En el próximo artículo veremos cómo dar el siguiente paso: crear un tema básico para tu nuevo sitio web. Será la base sobre la que podrás construir un website a tu medida.

Pulso la tecla ESC, dos puntos wq!

