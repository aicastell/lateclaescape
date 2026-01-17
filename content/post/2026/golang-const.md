---
title: Constantes en Go
date: 2026-01-16
image: /img/posts/golang-const.webp
categories: [ "programming_language" ]
tags: [ "golang", "packages" ]
draft: false
featured: true
---

# Introducción

En el artículo anterior vimos qué son las [variables en Go](/post/2026/golang-variables).

Sin embargo, en un programa en Go, no todos los valores deben ser variables. Para representar valores fijos, inmutables y conocidos de antemano, Go introduce el concepto de *constantes*.

Las constantes en Go no son simplemente "variables que no cambian". Tienen reglas, propiedades y capacidades propias que las hacen especialmente potentes y expresivas.

En este artículo veremos qué son las constantes en Go, cómo se declaran y en qué situaciones aportan claridad y seguridad al código.

# Constantes en Go

Una constante es un identificador cuyo valor:

- Se fija en el momento de la compilación.
- No puede modificarse en ningún punto del programa.
- Representa un valor literal, no un espacio de memoria mutable.

Las constantes se declaran igual que las variables, pero usando la palabra reservada `const` en lugar de `var`.

Ejemplo mínimo:

```
const pi = 3.14159
```

A diferencia de una variable, `pi` no es un contenedor cuyo contenido pueda cambiar. Es simplemente un nombre asociado a un valor constante.

# Diferencias entre variables y constantes

La diferencia no es solo semántica, es conceptual y técnica:

| Variables (var) | Constantes (const) |
|-----------------|--------------------|
| Pueden cambiar  | No pueden cambiar |
| Ocupan memoria | No necesariamente ocupan memoria |
| El valor puede cambiar en ejecución | El valor se fija en compilación |

El comportamiento de las constantes en Go se vuelve aún más interesante cuando entran en juego los tipos de datos. No todas las constantes se comportan igual en ese aspecto, y esa diferencia es intencionada. Más adelante dedicaremos un artículo específico a explicar cómo y cuándo una constante queda tipada, y por qué este diseño es clave en el lenguaje.

# Las constantes son inmutables

Intentar cambiar el valor de una constante provoca un error de compilación.

```
const year = 2025
year = 2026 // ERROR
```

El compilador devuelve:

```
cannot assign to year (neither addressable nor a map index expression)
```

Si cambiamos `const` por `var`, el código vuelve a ser válido:

```
var year int = 2025
year = 2026
```

Esto refuerza la idea central:

- Una constante no es una variable “especial”.
- Es un concepto distinto con reglas propias.

# Bloques de constantes

Go permite agrupar constantes relacionadas:

```
const (
    StatusOK    = 200
    StatusError = 500
    StatusAuth  = 401
)
```

Esto mejora legibilidad, cohesión y mantenimiento.

# Cuándo usar constantes

Usa constantes cuando:

- El valor no debe cambiar
- Representa una verdad del dominio
- Mejora la legibilidad del código
- Evita "números mágicos"
- Debe ser evaluado en compilación

No uses constantes cuando:

- El valor depende del estado del programa
- Necesitas mutabilidad
- El valor se construye dinámicamente

# Resumen mental

- Las constantes no son variables inmutables: son valores de compilación.
- Se declaran con const.
- Deben inicializarse al declararse.
- Hacen el código más seguro, expresivo y mantenible.

# Conclusión

Las constantes son una de las piezas más elegantes del diseño de Go: sencillas por fuera, pero con una semántica muy cuidada por dentro.

Con variables y constantes ya dominadas, ahora sí estás preparado para entender los tipos de datos sin atajos ni confusiones.

En el próximo artículo entraremos de lleno en el sistema de tipos de Go: qué tipos existen, cómo se comportan y por qué su diseño es una de las razones del éxito del lenguaje.

¡Nos vemos en el próximo artículo!.

Pulso la tecla `ESC:wq!`
