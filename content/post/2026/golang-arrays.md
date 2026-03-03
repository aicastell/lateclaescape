---
title: Arrays en Go
date: 2026-02-13
image: /img/posts/golang-arrays.webp
categories: [ "programming_language" ]
tags: [ "golang", "array", "zero_value" ]
draft: false
featured: true
---

# Introducción

En los artículos anteriores has aprendido a trabajar con los elementos más básicos del lenguaje. Has visto como declarar [variables con tipo](/post/2026/golang-typed-variables) y [constantes con tipo](/post/2026/golang-typed-const), y cómo Go utiliza los [tipos básicos primitivos](/post/2026/golang-data-types) para representar valores simples como números, textos o booleanos.

Hasta ahora, todo lo que has manejado han sido valores aislados: un número, una cadena, un booleano. Pero los programas reales rara vez trabajan con un único valor. ¿Cómo representamos una lista de temperaturas? ¿Una secuencia de puntuaciones? ¿Las coordenadas de un punto en el espacio?.

Cuando varios valores están relacionados entre sí, tiene sentido tratarlos como una única entidad. Para dar ese primer paso más allá de los valores simples, Go nos ofrece su estructura compuesta más básica: el **array**.

En este artículo veremos qué es un **array** en Go, cómo se declara, cómo se inicializa y por qué su diseño aparentemente rígido, es en realidad una decisión consciente orientada a la seguridad y la claridad.

# Qué es un array en Go

Un **array** es una colección de valores que cumple tres propiedades fundamentales:

- Ordenada: cada elemento tiene una posición bien definida (índices 0, 1, 2, ...).
- Fija: el compilador debe conocer el tamaño del **array** antes de que el programa se ejecute (su longitud se define en tiempo de compilación).
- Homogénea: todos sus elementos son del mismo tipo.

Hay un detalle clave que diferencia los **array** en Go de los **array** en otros lenguajes:

> La longitud del **array** forma parte de su tipo.

Este punto es central para entender el comportamiento de los **array** en Go y explica muchas de sus decisiones de diseño.

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

# Zero value de los array

Como ocurre con cualquier variable en Go, los **array** tienen un **zero value** bien definido y seguro. El **zero value** de un **array** es otro **array** del mismo tamaño en el que cada elemento contiene el **zero value** de su tipo.

Ejemplo:

```
var edades [3]int
```

En este caso, el tipo `int`, cuyo **zero value** es el 0. Por tanto, el contenido inicial del **array** es:

```
[0 0 0]
```

No hay memoria sin inicializar. No hay comportamiento indefinido. Solo valores válidos desde el primer momento. Este comportamiento es deliberado: Go prioriza que los datos siempre estén en un estado válido.

# Inicialización de los array

## Inicialización explícita

Puedes inicializar un **array** directamente en el momento de declararlo:

```
var edades = [3]int{20, 30, 40}
```

El **array** `edades` contiene tres valores y su longitud queda fijada para siempre. No podrá crecer ni reducirse.

## Inicialización implícita

Si no quieres escribir la longitud de forma explícita, puedes dejar que el compilador la infiera usando `...`:

```
edades := [...]int{20, 30, 40}
```

Go infiere que la longitud es 3 y crea un **array** de tipo `[3]int`. El tipo resultante sigue siendo un `[3]int`. La única diferencia es que delegas en el compilador el cálculo de la longitud.

# Acceso y modificación de elementos

Los elementos de un **array** se acceden por su índice, empezando siempre en cero.

Ejemplo:

```
var edades = [3]int{20, 30, 40}

fmt.Println(edades[0]) // 20
fmt.Println(edades[1]) // 30
fmt.Println(edades[2]) // 40
```

Cada posición del **array** es una variable del tipo declarado, por lo que también puedes modificar su valor:

```
edades[1] = 35
fmt.Println(edades) // [20 35 40]
```

# La longitud forma parte del tipo

Esta es la idea más importante y distintiva de los **array** en Go.

Considera este código:

```
var a [3]int
var b [4]int
```

Aunque ambos **array** `a` y `b` contienen enteros, sus tipos son distintos:

- `a` es de tipo `[3]int`
- `b` es de tipo `[4]int`

Por tanto, no puedes asignar uno al otro:

```
a = b // cannot use b (variable of type [4]int) as [3]int value in assignment
```

La longitud no es un detalle accesorio: forma parte de la definición del tipo y el compilador lo hace cumplir de forma estricta.

# Iterar arrays

La forma habitual de recorrer un array en Go es usar el bucle `for` junto con la palabra reservada `range`:

```
var a = [3]int{10, 20, 30}

for i := range a {
    fmt.Println(a[i])
}
```

Aquí:

- `range` recorre los índices válidos del array a (0, 1, 2).
- `i` representa el índice actual.
- el valor del elemento se obtiene accediendo a `a[i]`.

Este enfoque tiene varias ventajas:

- No necesitas conocer el tamaño del array
- Evita accesos fuera de rango
- El código es claro, explícito y seguro

# Asignación de arrays

Los **array** en Go son valores, igual que un `int` o un `string`.

Esto implica que cuando asignas un **array** a otro, se copia completo:

Ejemplo:

```
a := [3]int{1, 2, 3}
b := a

b[0] = 100
fmt.Println(a) // [1 2 3]
fmt.Println(b) // [100 2 3]
```

Aquí:

- `b := a` copia todo el array `a` sobre `b`.
- `a` y `b` son valores independientes.
- modificar uno no afecta al otro.

Este mismo principio se aplica cuando se usa `range` sobre un `array`: Go itera sobre una copia del array. En **array** pequeños este detalle no suele ser relevante, pero en **array** grandes puede tener impacto en rendimiento y diseño del código.

Esta es una de las razones por las que, en la práctica, se usan más los **slice**, que veremos en el próximo artículo.

# Cuándo usar los array

En Go, los **array** brillan en contextos donde:

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

En estos casos, el **array** no es solo un contenedor: describe la estructura del dato con precisión.

# Resumen mental

- Un **array** es una colección fija, ordenada y homogénea.
- Su longitud es parte del tipo y no puede cambiar.
- Todos sus elementos tienen un **zero value**.
- Se accede a sus elementos por índice numérico.
- Es ideal cuando el tamaño es conocido, pequeño y significativo.
- En el día a día se usan poco de forma directa, pero están presentes en muchas otras abstracciones clave del lenguaje.

# Conclusión

Los **array** en Go no están pensados para ser flexibles. Están pensados para ser seguros, explícitos y predecibles.

Al hacer que la longitud forme parte del tipo, Go elimina de raíz toda una clase de errores habituales en otros lenguajes: tamaños ambiguos, asignaciones silenciosas o desbordamientos difíciles de detectar. Si algo no encaja, el compilador lo señala antes de que el programa llegue siquiera a ejecutarse.

En el día a día, rara vez trabajarás directamente con **array**. Pero entenderlos es fundamental, porque constituyen la base sobre la que Go construye abstracciones más cómodas para manejar colecciones sin renunciar a la claridad ni a la seguridad del sistema de tipos.

En el próximo artículo daremos ese siguiente paso natural. Veremos cómo Go parte de esta solidez inicial para permitir trabajar con conjuntos de datos que pueden adaptarse al flujo del programa, crecer cuando es necesario y seguir siendo eficientes y previsibles.

Es en ese punto donde muchas decisiones de diseño del lenguaje empiezan a cobrar sentido. Y cuando las piezas encajan, Go empieza a brillar. Una vez comprendas el modelo que propone el lenguaje para manejar colecciones, no querrás volver atrás.

¿Has aprendido algo leyendo este artículo? Únete al [canal de Telegram](https://t.me/lateclaescape), y pregúntame cualquier duda que te quede pendiente. Allí respondo personalmente a todas tus dudas, sugerencias y comentarios.

Nos vemos en el próximo artículo.

Pulso la tecla `ESC:wq!`
