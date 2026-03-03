---
title: Slices en Go
date: 2026-03-02
image: /img/posts/golang-slices.webp
categories: [ "programming_language" ]
tags: [ "golang", "variables", "backing_array", "garbage_collector" ]
draft: false
featured: true
---

# Introducción

En el artículo anterior vimos los [arrays en Go](/post/2026/golang-arrays): colecciones de tamaño fijo cuya longitud forma parte del tipo. Esa rigidez los hace seguros y predecibles, pero poco prácticos para la mayoría de situaciones reales, cuando necesitamos colecciones que crezcan, se reduzcan o se manipulen con flexibilidad.

Go no elimina los arrays. Los mantiene como bloque básico y sobre ellos construye la estructura que realmente se usa en el día a día: los **slices**.

En este artículo vas a entender qué es un **slice**, cómo se crea, cómo se utiliza y qué consecuencias tiene su diseño interno (memoria compartida, rendimiento y efectos colaterales).

# El problema de los arrays

Recuerda el ejemplo que vimos en el artículo sobre **arrays**:

```
var small [3]int
var big   [4]int

small = big // Error: cannot use big (variable of type [4]int) as [3]int value in assignment
```

Los **arrays** tienen limitaciones:

- Su tamaño es fijo y no puede cambiar (ni crecer ni reducirse).
- La longitud forma parte del tipo (por tanto, dos **arrays** de distinto tamaño no son compatibles).

La mayoría de programas necesitan listas que crecen o se construyen progresivamente. Para eso, Go introduce los **slices**.

# Qué es un slice

En Go, un **slice** es una estructura ligera que describe una vista dinámica sobre un array subyacente conocido como **backing array**. Esta estructura está compuesta por tres elementos:

- Puntero al primer elemento visible del **backing array**.
- Longitud (len): número de elementos accesibles desde ese puntero.
- Capacidad (cap): cuántos elementos caben desde ese puntero hasta el final del **backing array** (antes de necesitar otro **backing array**).

El **slice** no almacena los datos: describe qué porción del **backing array** es visible y cuánto puede crecer dentro de ese mismo almacenamiento.

Entender esto es clave para razonar correctamente sobre comportamiento, efectos colaterales y crecimiento posterior.

# Crear un slice

Un **slice** puede crearse aplicando la sintaxis de slicing a un **array** o a otro **slice**. La regla general es esta:

```
view := x[inicio:fin]
```

Donde `x` puede ser:

- un array
- un slice

Y donde:

- Se incluye el elemento `inicio`.
- Se excluye el elemento `fin`.
- Si no pones `inicio`, se asume que `inicio` vale 0.
- Si no pones `fin`, se asume que `fin` toma como valor la longitud del **array**.

Esta sintaxis no crea datos nuevos. Crea un **slice** llamado `vista` que actúa como vista sobre una parte de `x`.

Dado este **array**:

```
data := [10]int{0,10,20,30,40,50,60,70,80,90}
```

Veamos algunos ejemplos:

## Ejemplo 1

Creamos un **slice** `window` que apunta a los elementos 3, 4, 5, y 6 del **array**:

```
window := data[3:7]
fmt.Println(window)
[30 40 50 60]
```

Fíjate que:

- `window` incluye el índice 3 del array.
- `window` excluye el índice 7 del array.

## Ejemplo 2

Creamos un **slice** `head` con los 5 primeros elementos:

```
head := data[:5]
fmt.Println(head)
[0 10 20 30 40]
```

## Ejemplo 3

Creamos un **slice** `tail` desde el índice 5 hasta el final:

```
tail := data[5:]
fmt.Println(tail)
[50 60 70 80 90]
```

## Ejemplo 4

Creamos un **slice** `all` con todo el array como slice:

```
all := data[:]
fmt.Println(all)
[0 10 20 30 40 50 60 70 80 90]
```

Hasta aquí, lo único que necesitas interiorizar es esto:

- `data` contiene los datos.
- `window`, `head`, `tail`, `all` son distintas vistas.
- Si modificas elementos visibles desde una vista, estás modificando el mismo almacenamiento.

# Anatomía de un slice

Para entender por qué ocurre esto, necesitamos mirar su anatomía interna.

## El backing array

El **backing array** es el **array** donde se guardan los datos. En el ejemplo anterior, `data` es el **backing array**.

## Puntero al primer elemento

El **slice** guarda un puntero al primer elemento visible dentro del **backing array**.

Cuando modificas algún elemento del **slice**, en realidad estás modificando un componente del **backing array**. Considera este ejemplo:

```
alias := window

alias[0] = 99

fmt.Println("window:", window)
fmt.Println("alias:", alias)
fmt.Println("data:", data)
```

Resultado:

```
window: [99 40 50 60]
alias: [99 40 50 60]
data: [0 10 20 99 40 50 60 70 80 90]
```

¿Qué ha ocurrido?

- `window` y `alias` son dos variables de tipo slice distintas.
- Pero ambas contienen un puntero que apunta al mismo backing array.
- Al modificar `alias[0]`, estamos modificando el mismo almacenamiento que ve `window`.

## La longitud (len)

La longitud indica cuántos elementos son visibles a través del **slice**. Se calcula con la función `len()`:

```
fmt.Println(len(window))
4
```

Estos son los 4 elementos visibles:

```
[99 40 50 60]
```

Los índices válidos de `window` son 0, 1, 2 y 3 (de 0 a `len(window)-1`).

## La capacidad (cap)

La capacidad indica cuántos elementos caben desde el inicio del **slice** hasta el último elemento del **backing array**. Se calcula con la función `cap()`:

```
fmt.Println(cap(window))
7
```

En nuestro ejemplo, el **slice** empieza en el índice 3 del **backing array**, y termina en el índice 9. Desde el índice 3 hasta el final del array (índice 9) hay en total 7 posiciones posibles.

## Representación conceptual

La situación se entiende conceptualmente de esta manera:

```
backing array: [0 10 20 99 40 50 60 70 80 90]
                        ↑           ↑
                   inicio           fin

Slice window = [99 40 50 60]

len(window) = 4
cap(window) = 7
```

# Añadir elementos

La forma estándar de añadir elementos a un **slice** es mediante la función `append()`.

Partimos de un slice que todavía tiene espacio disponible:

```
buf := [10]int{0, 10, 20, 99, 40, 50, 60, 70, 80, 90}
items := buf[:5]   // [0 10 20 99 40]
```

En este momento:

```
len(items) = 5
cap(items) = 10
```

El **slice** expone 5 elementos, pero su **backing array** tiene 10 posiciones desde el inicio de `items`, así que puede crecer 5 más sin realocar.

## Añadir un elemento

Para añadir un nuevo elemento a un **slice** se utiliza la función `append()` de esta manera:

```
items = append(items, 100)
fmt.Println(items)
```

Resultado:

```
[0 10 20 99 40 100]
```

Ahora:

```
len(items) = 6
cap(items) = 10
```

El nuevo elemento se ha añadido en el mismo **backing array**. No ha sido necesario reservar memoria adicional.

## Añadiendo varios elementos

Para añadir varios elementos a un **slice** se utiliza la función `append()` de esta manera:

```
items = append(items, 200, 300)
fmt.Println(items)
```

Resultado:

```
[0 10 20 99 40 100 200 300]
```

Mientras exista capacidad disponible, `append()` simplemente utiliza el espacio libre. La operación es muy eficiente, no necesita reservar memoria adicional.

## Cuando el slice se queda sin espacio

Si añades más elementos de los que caben en `cap`, Go necesitará un **backing array** nuevo:

```
items = append(items, 400, 500, 600)
fmt.Println(items)
[0 10 20 99 40 100 200 300 400 500 600]
```

En este momento Go:

- crea un nuevo **backing array** con mayor capacidad
- copia los elementos existentes
- hace que `items` apunte a ese nuevo **backing array**

Este proceso se denomina reasignación de memoria (en inglés, *reallocation*).

El cambio es transparente en el código, pero crucial para entender efectos colaterales con otros slices.

# Slices que comparten memoria

Cuando `append()` realoca, el descriptor que devuelve pasa a apuntar a un **backing array** nuevo. Los demás **slices** siguen apuntando al original.

```
base := [4]int{1, 2, 3, 4}

left := base[:2]   // [1 2], cap=4
mid  := base[1:3]  // [2 3], cap=3 (mismo backing array)

left = append(left, 99, 88, 77) // fuerza crecimiento (no cabe en cap=4)

fmt.Println("left:", left) // apunta al nuevo array
fmt.Println("mid:", mid)   // sigue apuntando al array original
fmt.Println("base:", base)
```

El resultado es este:

```
left: [1 2 99 88 77]
mid: [2 3]
base: [1 2 3 4]
```

Aquí:

- `left` apunta al nuevo **backing array**. Ya no comparte **backing array** con `mid/base`.
- `mid` y `base` siguen compartiendo el **backing array** original.

Este comportamiento permite que **slices** crezcan dinámicamente sin romper a otros, pero también explica por qué a veces hay bugs cuando no hay realocación y `append()` pisa memoria compartida. Esto ocurre cuando aún hay capacidad disponible y `append()` reutiliza el mismo **backing array**.

## Reservar capacidad

Cuando sabes que un **slice** va a crecer, es buena práctica reservar capacidad por adelantado usando la función `make()`, para reducir realocaciones:

Esta función tiene tres parámetros:

- El tipo de **slice** (`[]int`).
- La longitud inicial (`len`)
- La capacidad (opcional). Si no lo pones, toma el valor de `len`.

Ejemplo:

```
items1 := make([]int, 0, 100)     // len=0, cap=100 (ideal para ir añadiendo)
items2 := make([]int, 5)          // len=5, cap=5   (5 ceros)
items3 := make([]int, 3, 10)      // len=3, cap=10
```

Esto no cambia el comportamiento del **slice**, pero si puede mejorar el rendimiento de la aplicación al evitar crear arrays nuevos de forma innecesaria.

# Copiar un slice

La forma estándar de copiar elementos desde un **slice** origen hacia un **slice** destino es mediante la función `copy()`.

```
n := copy(dst, src)
```

Esta función copia elementos desde `src` a `dst` y devuelve cuántos elementos ha copiado.

Reglas importantes:

- Copia hasta el mínimo entre `len(dst)` y `len(src)`.
- Copia elementos en orden (como un "memcpy" conceptual a nivel de elementos).
- No cambia ni len ni cap de ninguno de los slices.
- Solo copia los elementos visibles (la parte accesible por len).

Esta función es especialmente útil cuando necesitas una copia independiente para evitar efectos colaterales derivados de que varios slices compartan el mismo **backing array**.

## Copia independiente típica

Si quieres una copia completa e independiente de `src`, primero creas un `dst` con la misma longitud y luego copias:

```
src := []int{1, 2, 3}

dst := make([]int, len(src))
copy(dst, src)

dst[0] = 99
fmt.Println("src:", src) // src: [1 2 3]
fmt.Println("dst:", dst) // dst: [99 2 3]
```

Aquí `dst` tiene su propio **backing array**, así que no hay efectos colaterales.

## Copia parcial (cuando dst es más corto)

En este ejemplo estamos copiando un **slice** más grande (`src`) dentro de otro más pequeño (`dst`):

```
src := []int{10, 20, 30, 40}
dst := make([]int, 2)

n := copy(dst, src)
fmt.Println(n)   // 2
fmt.Println(dst) // [10 20]
```

Aquí:

- `src` tiene 4 elementos: [10 20 30 40]
- `dst` se crea con `make([]int, 2)`
- La operación `copy(dst, src)` copia elementos desde `src` hacia `dst`.

La regla fundamental de `copy()` es que se copian tantos elementos como el mínimo entre `len(dst)` y `len(src)`.

En este caso:

- len(src) = 4
- len(dst) = 2
- El mínimo es 2

Por eso:

- Solo se copian los dos primeros elementos.
- `n` vale 2 (número de elementos copiados).
- `dst` termina siendo [10 20].

Los valores 30 y 40 no se copian porque `dst` no tiene espacio para más elementos.

## Sobrescribir un slice existente

La función `copy(dst, src)` copia tantos elementos como pueda sin salirse de ninguno de los dos slices.

```
dst := []int{1, 1, 1, 1}
src := []int{9, 8}

copy(dst, src)
fmt.Println(dst) // [9 8 1 1]
```

Aquí:

- `dst` tiene 4 posiciones
- `src` tiene 2 posiciones
- `copy(dst, src)` empieza a copiar desde el índice 0 de ambos slices.

La copia se hace elemento a elemento:

```
dst[0] = src[0] → 9
dst[1] = src[1] → 8
```

En ese momento ya no hay más elementos en `src`. La copia se detiene. Solo se han reemplazado las dos primeras posiciones de `dst`. Las posiciones dst[2] y dst[3] no cambian porque `src` no tiene más elementos que copiar.

# Consecuencias del diseño

Este modelo explica varias propiedades clave:

- El tamaño no forma parte del tipo: []int es el mismo tipo tenga 3 o 300 elementos.
- Varios **slices** pueden compartir el mismo **backing array**.
- Modificar un **slice** puede afectar a otros que compartan memoria.
- Copiar un **slice** no copia los datos, solo copia los tres campos de la estructura.
- Puede crecer dinámicamente mediante `append()`, reutilizando capacidad o realocando si es necesario.

Entender esta anatomía es fundamental para razonar correctamente sobre memoria, rendimiento y efectos colaterales en Go.

# Iterar un slice

La forma habitual de recorrer un **slice** es usando el bucle `for` junto con la palabra clave `range`.

Ejemplo básico:

```
for i := range window {
    fmt.Println(window[i])
}
```

En este patrón:

- `range` recorre los índices válidos del **slice** `window`.
- `i` es el índice actual.
- el valor actual se obtiene accediendo a `window[i]`.

Este enfoque es claro, seguro y no depende del tamaño del **slice**.

Más adelante veremos que `range` puede proporcionar más información en cada iteración, pero por ahora esta forma encaja perfectamente con lo aprendido hasta este punto.

# Guía rápida para usar slice o array

En la práctica, más del 90% de las colecciones en Go son **slices**. Los **arrays** son una elección consciente y poco frecuente.

En caso de duda, la siguiente tabla debería aclararte cuando usar cada uno:

| Caso de uso | Recomendación |
|-------------|---------------|
| Tamaño conocido y fijo en tiempo de compilación | Array |
| Tamaño es parte de la semántica (matriz 3×3, clave fija) | Array |
| Colecciones dinámicas, listas, colas, etc. | Slice |
| Paso de colecciones a funciones (casi siempre) | Slice |
| Código real del día a día (casi siempre) | Slice |

# Resumen mental

- Los **slices** son la herramienta estándar para trabajar con colecciones en Go.
- Tienen len (elementos visibles) y cap (espacio disponible).
- `append()` hace crecer el **slice** (y puede realocar).
- `make()` permite optimizar evitando realocaciones.
- `copy()` copia elementos desde un slice origen hacia un slice destino ya existente.
- Modificar un **slice** puede afectar otros que compartan el **backing array**.
- `cap(s) - len(s)` indica cuántos elementos puedes añadir antes de que se produzca una realocación.

# Conclusión

Go mantiene los **arrays** como bloques simples, estrictos y predecibles.

Sobre ellos construye los **slices**: una abstracción flexible, eficiente y segura que se adapta al flujo real de los programas sin ocultar lo que ocurre por debajo.

Entender bien los **slices** (y especialmente la relación entre longitud, capacidad y **backing array**) es uno de los pasos más importantes para escribir código Go idiomático.

Con esto dominado, el siguiente paso natural son los **maps**.

¡Nos vemos en el próximo artículo!

Pulso la tecla `ESC:wq!`
