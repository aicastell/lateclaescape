---
title: Arrays en Go
date: 2026-01-20
image: /img/posts/golang-arrays.webp
categories: [ "programming_language" ]
tags: [ "golang", "array", "zero_value" ]
draft: false
featured: true
---

# Introducción

En los artículos anteriores has aprendido a trabajar con los elementos más básicos del lenguaje. Has visto como declarar [variables con tipo](/post/2026/golang-typed-variables) y [constantes con tipo](/post/2026/golang-typed-const), y cómo Go utiliza los [tipos básicos primitivos](/post/2026/golang-data-types) para representar valores simples como números, textos o booleanos.

Hasta ahora, todo lo que has manejado han sido valores aislados: un número, una cadena, un booleano. Pero los programas reales rara vez trabajan con un único valor. ¿Cómo representamos una lista de temperaturas? ¿Una secuencia de puntuaciones? ¿Las coordenadas de un punto en el espacio?.

Para dar ese primer paso más allá de los valores simples, Go nos ofrece su estructura compuesta más básica: el **array**.

En este artículo veremos qué es un **array** en Go, cómo se declara, cómo se inicializa y por qué su diseño aparentemente rígido, es en realidad una decisión consciente orientada a la seguridad y la claridad.

En este artículo descubrirás qué es un array, cómo se declara, cómo se inicializa y por qué su diseño tan estricto es una ventaja, y no una limitación.

# Qué es un array en Go

Un array es una colección de valores que cumple tres propiedades fundamentales:

- Ordenada: cada elemento tiene una posición bien definida (índices 0, 1, 2, ...).
- Fija: su longitud se define en tiempo de compilación y no puede cambiar.
- Homogénea: todos sus elementos son del mismo tipo.

Y hay un detalle clave que diferencia a Go de muchos otros lenguajes:

> La longitud del array forma parte de su tipo.

Este punto es central para entender el comportamiento de los arrays en Go y explica muchas de sus decisiones de diseño.

## Declaración de un array

La sintaxis general es:

```
var nombre [longitud]tipo
```

Ejemplo:

```
var edades [3]int
```

Aquí estamos declarando una variable llamada `edades` cuyo tipo es `[3]int`. Eso significa que puede contener exactamente tres valores de tipo `int`. Ni dos. Ni cuatro. Exactamente tres.

# Zero value de los arrays

Como ocurre con cualquier variable en Go, los arrays tienen un **zero value** bien definido y seguro.

El **zero value** de un array es otro array del mismo tamaño en el que cada elemento contiene el **zero value** de su tipo.

Ejemplo:

```
var edades [3]int
```

Cada uno de sus elementos toma el **zero value** de su tipo. En este caso, el tipo `int`, cuyo **zero value** es el 0. Por tanto, el contenido inicial del array es:

```
[0 0 0]
```

No hay memoria sin inicializar. No hay comportamiento indefinido. Solo valores válidos desde el primer momento.

# Inicialización de arrays

## Inicialización explicita

Puedes inicializar un array directamente en el momento de declararlo:

```
var edades = [3]int{20, 30, 40}
```

El array `edades` contiene tres valores y su longitud queda fijada para siempre. No podrá crecer ni reducirse.

## Inicialización implícita

Si no quieres escribir la longitud de forma explícita, puedes dejar que el compilador la infiera usando `...`:

```
edades := [...]int{20, 30, 40}
```

Go infiere que la longitud es 3 y crea un array de tipo `[3]int`. El resultado final es exactamente el mismo que en el caso anterior; solo cambia la forma de escribirlo.

# Acceso y modificación de elementos

Los elementos de un array se acceden por su índice, empezando siempre en cero.

Ejemplo:

```
var edades = [3]int{20, 30, 40}

fmt.Println(edades[0]) // 20
fmt.Println(edades[1]) // 30
fmt.Println(edades[2]) // 40
```

Cada posición del array es una variable del tipo declarado, por lo que también puedes modificar su valor:

```
edades[1] = 35
fmt.Println(edades) // [20 35 40]
```

# La longitud forma parte del tipo

Esta es la idea más importante y distintiva de los arrays en Go.

Considera este código:

```
var a [3]int
var b [4]int
```

Aunque ambos arrays `a` y `b` contienen enteros, sus tipos son distintos:

- `a` es de tipo `[3]int`
- `b` es de tipo `[4]int`

Por tanto, no puedes asignar uno al otro:

```
a = b // cannot use b (variable of type [4]int) as [3]int value in assignment
```

Go no permite esta operación porque los tipos no coinciden exactamente. La longitud no es un detalle accesorio: forma parte de la definición del tipo.

# Cuándo usar arrays

En Go, los arrays brillan en contextos donde:

- El tamaño es fijo y conocido en tiempo de compilación
- El número de elementos es pequeño y significativo
- El tamaño forma parte del **significado** del dato

Ejemplos reales:

```
var pointXY [2]float64
var colorRGB [3]byte
var weekDays [7]string
var matrix [3][3]int
```

En estos casos, el array no es solo un contenedor: describe la estructura del dato con precisión.

En la práctica diaria, sin embargo, los arrays se usan poco de forma directa. Go ofrece estructuras más flexibles para trabajar con colecciones variables, construidas precisamente sobre esta base.

# Resumen mental

- Un array es una colección fija, ordenada y homogénea.
- Su longitud es parte del tipo y no puede cambiar.
- Todos sus elementos tienen un **zero value**.
- Se accede a sus elementos por índice numérico.
- Es ideal cuando el tamaño es conocido, pequeño y significativo.
- En el día a día se usan poco.

# Conclusión

Los arrays en Go no están pensados para ser flexibles. Están pensados para ser seguros, explícitos y predecibles.

Al hacer que la longitud forme parte del tipo, Go elimina de raíz toda una clase de errores habituales en otros lenguajes: tamaños ambiguos, asignaciones silenciosas o desbordamientos difíciles de detectar. Si algo no encaja, el compilador lo señala antes de que el programa llegue siquiera a ejecutarse.

Aunque en el día a día rara vez trabajarás directamente con arrays, entenderlos es fundamental. Constituyen la base sobre la que Go construye formas más cómodas y expresivas de manejar colecciones, sin renunciar a la seguridad ni a la claridad del sistema de tipos.

En el próximo artículo daremos ese siguiente paso natural. Veremos cómo Go parte de esta solidez inicial para permitir trabajar con conjuntos de datos que pueden adaptarse al flujo del programa, crecer cuando es necesario y seguir siendo eficientes y previsibles.

Es en ese punto donde muchas decisiones de diseño del lenguaje empiezan a cobrar sentido. Y cuando las piezas encajan, Go empieza a mostrar todo su potencial. Una vez comprendas el modelo que propone el lenguaje para manejar colecciones, no querrás volver atrás.

¿Has aprendido algo leyendo este artículo? Únete al [canal de Telegram](https://t.me/lateclaescape) del blog, y pregúntame cualquier duda que te quede pendiente. Allí respondo personalmente a todas tus preguntas.

Nos vemos en el próximo articulo.

Pulso la tecla ESC:wq!


