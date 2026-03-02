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

Go no elimina los arrays. Los mantiene como bloque básico y sobre ellos construye la estructura de datos que realmente se usa en el día a día: los **slices**.

En este artículo vas a entender qué es un **slice**, cómo se crea, cómo se utiliza y qué consecuencias tiene su diseño interno (memoria compartida, rendimiento y efectos colaterales).

# El problema de los arrays

Recuerda el ejemplo que vimos en el articulo sobre arrays:

```
var a [3]int
var b [4]int

a = b // Error: cannot use b (variable of type [4]int) as [3]int value in assignment
```

Los **array** tienen limitaciones claras:

- Su tamaño es fijo y no puede cambiar (ni crecer ni reducirse).
- La longitud forma parte del tipo (por tanto, dos **array** de distinto tamaño no son compatibles).

La mayoría de programas necesitan listas que crecen o se construyen progresivamente. Para eso, Go introduce los **slices**.

# Qué es un slice

Un **slice** es una forma flexible de trabajar con una secuencia contigua de elementos del mismo tipo.

De manera intuitiva puede verse como un "array dinámico": una estructura que puedes recortar, extender y reorganizar. Pero esta definición es muy informal. Para usar slices correctamente -y evitar errores sutiles relacionados con memoria compartida- es esencial entender que un **slice** no es el almacenamiento de los datos. Es un descriptor que define qué parte de un almacenamiento subyacente (conocido como **backing array**) estás viendo.

El **slice** no contiene los elementos. Lo que contiene es información suficiente para:

- Determinar dónde empieza la región visible.
- Saber cuántos elementos son accesibles.
- Conocer cuánto puede crecer dentro de ese mismo almacenamiento.

En otras palabras, un slice no es una colección independiente de valores, sino una ventana dinámica sobre una zona concreta de memoria. Comprender esta distinción es lo que permite razonar correctamente sobre comportamiento, efectos colaterales y crecimiento posterior.

# Crear un slice

Un **slice** puede crearse aplicando la sintaxis de slicing a un **array** o a otro **slice**. La regla general es esta:

```
slice := x[inicio:fin]
```

Donde `x` puede ser:

- un array
- un slice

Y donde:

- Se incluye el elemento `inicio`.
- Se excluye el elemento `fin`.
- Si no pones `inicio`, se asume que `inicio` vale 0.
- Si no pones `fin`, se asume el `fin` toma como valor la longitud del **array**.

Lo importante aquí es conceptual. Esta sintaxis no crea datos nuevos. Crea un **slice** que actúa como vista sobre una parte de `x`.

Dado este array:

```
arr := [10]int{0,10,20,30,40,50,60,70,80,90}
```

Veamos algunos ejemplos:

## Ejemplo 1

Creamos un **slice** `s` que apunta a los elementos 3, 4, 5, y 6 del **array**:

```
s := arr[3:7]
fmt.Println(s)
[30 40 50 60]
```

Fíjate que:

- `s` incluye el índice 3 del array.
- `s` excluye el índice 7 del array.

## Ejemplo 2

Creamos un **slice** `s2` con los 5 primeros elementos:

```
s2 := arr[:5]
fmt.Println(s2)
[0 10 20 30 40]
```

## Ejemplo 3

Creamos un **slice** `s3` desde el índice 5 hasta el final:

```
s3 := arr[5:]
fmt.Println(s3)
[50 60 70 80 90]
```

## Ejemplo 4

Creamos un **slice** `s4` con todo el array como slice:

```
s4 := arr[:]
fmt.Println(s4)
[0 10 20 30 40 50 60 70 80 90]
```

Hasta aquí, lo único que necesitas interiorizar es esto:

- `arr` contiene los datos.
- `s`, `s2`, `s3`, `s4` son distintas vistas.
- Si modificas elementos visibles desde una vista, estás modificando el mismo almacenamiento.

Ahora sí: vamos a explicar por qué ocurre eso y cómo razonarlo correctamente.

# Anatomía interna

En Go, un **slice** es una estructura ligera que describe una ventana sobre un **backing array**. No almacena los datos: describe qué porción del **array** es visible y cuánto puede crecer dentro de ese mismo almacenamiento.

Esta estructura esta compuesta por tres elementos:

- Puntero al primer elemento visible del **backing array**.
- Longitud (len): número de elementos accesibles desde ese puntero.
- Capacidad (cap): cuántos elementos caben desde ese puntero hasta el final del **backing array** (antes de necesitar otro **backing array**).

## El backing array

El **backing array** es el **array** donde se guardan los datos. En el ejemplo anterior, `arr` es el **backing array**.

La idea clave es que cada **slice** es una vista sobre una porción del **backing array**.

## Puntero al primer elemento

El **slice** guarda un puntero al primer elemento visible dentro del **backing array**.

En nuestro ejemplo, el **slice** `s` comienza en la posición `arr[3]` del **backing array**. Por eso esta condición devuelve `true`:

```
fmt.Println(s[0] == arr[3])
true
```

Y por eso, modificar el **slice** en realidad modifica el **backing array**:

```
s[0] = 99
fmt.Println(arr)
// [0 10 20 99 40 50 60 70 80 90]
```

Acabas de entender que `s[0]` es en realidad `arr[3]`.

## La longitud (len)

La longitud indica cuántos elementos son visibles a través del **slice**. Se calcula con la función `len()`:

```
fmt.Println(len(s))
4
```

Estos son los 4 elementos visibles:

```
[99 40 50 60]
```

Los índices válidos de `s` son 0, 1, 2 y 3 (de 0 a len(s)-1).

## La capacidad (cap)

La capacidad indica cuántos elementos caben desde el inicio del **slice** hasta el último elemento del **backing array**. Se calcula con la función `cap()`:

```
fmt.Println(cap(s))
7
```

En nuestro ejemplo, el **slice** empieza en el índice 3 del backing array, y termina en el índice 9 del backing array. Desde el índice 3 hasta el final del array (índice 9) hay en total 7 posiciones posibles.

# Representación conceptual

Tras el cambio s[0] = 99, la situación se entiende de esta manera:

```
backing array: [0 10 20 99 40 50 60 70 80 90]
                        ↑           ↑
                   inicio           fin

Slice s = [99 40 50 60]

len(s) = 4
cap(s) = 7
```

## Consecuencias del diseño

Este modelo explica varias propiedades clave:

- El tamaño no forma parte del tipo: []int es el mismo tipo tenga 3 o 300 elementos.
- Varios **slices** pueden compartir el mismo **backing array**.
- Modificar un **slice** puede afectar a otros que compartan memoria.
- Copiar un **slice** no copia los datos, solo copia los tres campos de la estructura.
- Puede crecer dinámicamente mediante `append()`, reutilizando capacidad o realocando si es necesario.

Entender esta anatomía es fundamental para razonar correctamente sobre memoria, rendimiento y efectos colaterales en Go.

# Añadir elementos

La forma estándar de añadir elementos a un **slice** es mediante la función `append()`.

Partimos de un slice que todavía tiene espacio disponible:

```
arr := [10]int{0, 10, 20, 30, 40, 50, 60, 70, 80, 90}
s := arr[:5]   // [0 10 20 30 40]
```

En este momento:

```
len(s) = 5
cap(s) = 10
```

El **slice** expone 5 elementos, pero su **backing array** tiene 10 posiciones desde el inicio de `s`, así que puede crecer 5 más sin realocar.

## Añadir un elemento

Para añadir un nuevo elemento a un **slice** se utiliza la función `append()` de esta manera:

```
s = append(s, 100)
fmt.Println(s)
```

Resultado:

```
[0 10 20 30 40 100]
```

Ahora:

```
len(s) = 6
cap(s) = 10
```

El nuevo elemento se ha añadido en el mismo **backing array**. No ha sido necesario reservar memoria adicional.

## Añadiendo varios elementos

Para añadir varios elementos a un **slice** se utiliza la función `append()` de esta manera:

```
s = append(s, 200, 300)
fmt.Println(s)
```

Resultado:

```
[0 10 20 30 40 100 200 300]
```

Mientras exista capacidad disponible, `append()` simplemente utiliza el espacio libre. La operación es muy eficiente, no necesita reservar memoria adicional.

## Cuando el slice se queda sin espacio

Si añades mas elementos de los que caben en `cap`, Go necesitará un **backing array** nuevo:

```
s = append(s, 400, 500, 600)
fmt.Println(s)
[0 10 20 30 40 100 200 300 400 500 600]
```

En este momento Go:

- crea un nuevo **backing array** con mayor capacidad
- copia los elementos existentes
- hace que `s` apunte a ese nuevo **backing array**

Este proceso se denomina reasignación de memoria (en ingles, *reallocation*).

El cambio es transparente en el código, pero crucial para entender efectos colaterales con otros slices.

# Slices que comparten memoria

Cuando `append()` realoca, solo el **slice** resultante cambia de **backing array**. Los demás **slices** siguen apuntando al original.

```
arr := [4]int{1, 2, 3, 4}

a := arr[:2]   // [1 2], cap=4
b := arr[1:3]  // [2 3], cap=3 (mismo backing array)

a = append(a, 99, 88, 77) // fuerza crecimiento (no cabe en cap=4)

fmt.Println("a:", a) // apunta al nuevo array
fmt.Println("b:", b) // sigue apuntando al array original
fmt.Println("arr:", arr)
```

El resultado es este:

```
a: [1 2 99 88 77]
b: [2 3]
arr: [1 2 3 4]
```

Aquí:

- `a` apunta al nuevo **backing array**. Ya no comparte **backing array** con `b`/`arr`.
- `b` y `arr` siguen compartiendo el **backing array** original.

Este comportamiento permite que **slices** crezcan dinámicamente sin romper a otros, pero también explica por qué a veces hay bugs cuando no hay realocación y `append()` pisa memoria compartida. Esto ocurre cuando aún hay capacidad disponible y `append()` reutiliza el mismo **backing array**.

# Uso eficiente de la memoria

Cuando creas un **slice** por slicing, Go no copia los elementos. El **slice** simplemente apunta a la zona de memoria del **backing array**. Esto tiene ventajas importantes:

- Evita copias de memoria innecesarias
- Mejora el rendimiento
- Reduce el consumo de memoria
- Permite crear sub-vistas de grandes estructuras de datos

Por ejemplo, puedes procesar una parte de un archivo o de una imagen sin duplicar memoria.

## Reservar capacidad

Cuando sabes que un **slice** va a crecer, es buena práctica reservar capacidad por adelantado usando la función `make()`, para reducir realocaciones:

Esta función tiene tres parámetros:

- El tipo de **slice** (`[]int`).
- La longitud inicial (`len`)
- La capacidad (opcional). Si no lo pones, toma el valor de `len`.

Ejemplo:

```
s1 := make([]int, 0, 100)     // len=0, cap=100 (ideal para ir añadiendo)
s2 := make([]int, 5)          // len=5, cap=5   (5 ceros)
s3 := make([]int, 3, 10)      // len=3, cap=10
```

Esto no cambia el comportamiento del **slice**, pero si puede mejorar el rendimiento de la aplicación al evitar crear arrays nuevos de forma innecesaria.

# Copiar un slice

La forma estándar de copiar elementos desde un **slice** origen hacia un **slice** destino es mediante la función `copy()`. Esta función es especialmente útil cuando necesitas una copia independiente para evitar efectos colaterales derivados de que varios slices compartan el mismo **backing array**.

```
n := copy(dst, src)
```

Esta función copia elementos desde `src` a `dst` y devuelve cuántos elementos ha copiado.

Reglas importantes:

- Copia hasta el mínimo entre `len(dst)` y `len(src)`.
- Copia elementos en orden (como un "memcpy" conceptual a nivel de elementos).
- No cambia ni len ni cap de ninguno de los slices.
- Solo copia los elementos visibles (la parte accesible por len).

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

Los valores 30 y 40 no se copian porque dst no tiene espacio para más elementos.

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

# Iterar un slice

La forma habitual de recorrer un **slice** es usando el bucle `for` junto con la palabra clave `range`.

Ejemplo básico:

```
for i := range s {
    fmt.Println(s[i])
}
```

En este patrón:

- `range` recorre los índices válidos del slice `s`.
- `i` es el índice actual.
- el valor actual se obtiene accediendo a `s[i]`.

Este enfoque es claro, seguro y no depende del tamaño del **slice**.

Más adelante veremos que `range` puede proporcionar más información en cada iteración, pero por ahora esta forma encaja perfectamente con lo aprendido hasta este punto.

# Guía rápida para usar slice o array

En la práctica, mas del 90% de las colecciones en Go son **slices**. Los **array** son una elección consciente y poco frecuente.

En caso de duda, la siguiente tabla debería aclararte cuando usar cada uno:

| Caso de uso | Recomendación |
|-------------|---------------|
| Tamaño conocido y fijo en tiempo de compilación | Array [n]T |
| Tamaño es parte de la semántica (matriz 3×3, clave fija) | Array |
| Colecciones dinámicas, listas, colas, etc. | Slice []T |
| Paso de colecciones a funciones (casi siempre) | Slice |
| Código real del día a día | Casi siempre slice |

# Resumen mental

- Un **slice** es la forma estándar de trabajar con colecciones en Go
- Tiene len (elementos visibles) y cap (espacio disponible).
- `append()` hace crecer el **slice** (y puede realocar).
- make() permite optimizar evitando realocaciones.
- Modificar un **slice** puede afectar otros que compartan el **backing array**.
- Los **slices** son la herramienta estándar para colecciones en Go.
- cap(s) - len(s) indica cuántos elementos puedes añadir antes de que se produzca una realocación.

# Conclusión

Go mantiene los **array** como bloques simples, estrictos y predecibles.

Sobre ellos construye los **slices**: una abstracción flexible, eficiente y segura que se adapta al flujo real de los programas sin ocultar lo que ocurre por debajo.

Entender bien los **slices** (y especialmente la relación entre longitud, capacidad y **backing array**) es uno de los pasos más importantes para escribir código Go idiomático.

Con esto dominado, el siguiente paso natural son los **maps**.

¡Nos vemos en el próximo artículo!

Pulso la tecla `ESC:wq!`
