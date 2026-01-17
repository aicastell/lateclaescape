---
title: Variables en Go
date: 2026-01-14
image: /img/posts/golang-variables.webp
categories: [ "programming_language" ]
tags: [ "golang", "variables" ]
draft: false
featured: true
---

# Introducción

Para programar en Go con soltura es imprescindible entender uno de los conceptos fundamentales del lenguaje: las variables.

En este artículo veremos qué es una variable en Go, cómo se declara, cuándo usar cada forma de declaración y por qué su alcance (o ámbito) es tan importante. El objetivo no es profundizar aún en los distintos tipos de datos del lenguaje, sino entender cómo Go gestiona las variables como concepto fundamental.

# Variables en Go

Una variable en Go es un nombre simbólico que representa un valor en memoria. Ese valor puede leerse, modificarse o compartirse entre distintas partes del programa mientras se ejecuta.

Toda variable tiene 4 propiedades fundamentales que la definen por completo:

- Un nombre
- El tipo de dato que puede almacenar
- El valor concreto que contiene en cada momento
- El ámbito en el que existe

Entender estos cuatro elementos permite razonar correctamente sobre cualquier variable, independientemente del tipo de dato concreto que maneje.

## El nombre

El nombre de una variable es la etiqueta que te permite referenciar esa variable en tu código: *edad*, *usuarioActual*, *configDB*, etc.

En Go, los nombres:

- Son sensibles a mayúsculas y minúsculas (Edad != edad).
- Deben comenzar con una letra o guión bajo.
- No pueden empezar con un número, aunque pueden contener números en posiciones posteriores al primer carácter.
- Comunican intención: un buen nombre hace que el código se lea mejor.

## El tipo de dato

Toda variable en Go está asociada, desde el momento en que se declara, a un tipo de dato. Ese tipo determina qué información puede contener la variable y qué operaciones son válidas sobre ella. Una vez declarada, Go garantiza que el tipo es inmutable (no puede cambiar nunca).

Este artículo no trata los distintos tipos de datos disponibles en Go ni sus particularidades. Lo importante, por ahora, es entender que existen, que el lenguaje los controla de forma estricta y que forman parte esencial del diseño de las variables. Los veremos en profundidad en artículos posteriores.

## El valor

Cada variable en Go tiene un valor desde el mismo instante en que se declara. Ese valor puede proceder de dos situaciones distintas:

- Un valor que asignas explícitamente en el momento de la declaración.
- Un valor por defecto que Go asigna automáticamente cuando no se indica ninguno.

En ambos casos, la variable es completamente válida y puede usarse inmediatamente.

Una de las decisiones de diseño más importantes de Go es que no existen variables "sin inicializar". El lenguaje garantiza que toda variable tiene siempre un valor coherente desde el primer momento, incluso aunque el programador no haya asignado uno explícitamente.

Esto elimina una de las fuentes más comunes de errores en otros lenguajes: el acceso a variables en estados indefinidos. En Go, ese problema simplemente no existe.

# Declaración de variables

En Go existen dos formas principales de declarar variables:

- Usando la palabra clave var
- Usando la declaración corta :=

Ambas hacen lo mismo a nivel conceptual, pero se usan en contextos distintos.

## Declaración con var

La forma más explícita de declarar una variable es usando `var`.

```
var edad = 30
```

Aquí estás diciendo explícitamente:

- El nombre de la variable es `edad`.
- Su valor inicial es `30`.

A partir de ese valor inicial, Go determina internamente el tipo de dato y lo asocia a la variable desde ese mismo momento. No es necesario indicar nada más para que la variable sea plenamente funcional.

Este estilo es habitual cuando:

- Declaras variables a nivel de paquete
- Quieres separar declaración e inicialización
- Buscas máxima claridad estructural

También puedes declarar una variable sin asignarle un valor explícito:

```
var contador int
```

Aunque aquí aparece información adicional sobre el tipo del dato (un número entero), no es necesario comprender aún su significado concreto. Aquí lo relevante es que, gracias a este tipo, Go puede asignar automáticamente un valor inicial y garantizar que la variable sea válida desde el mismo instante que se declara.

## Declaración con :=

La declaración corta es la forma más común de declarar variables dentro de funciones.

```
total := 100
```

Conceptualmente, esta forma equivale a una declaración con `var` más una inicialización explícita, con la diferencia de que es más concisa y solo puede usarse dentro de bloques de código.

La variable queda creada con un tipo de dato asociado y lista para su uso inmediato. El mecanismo exacto por el que Go determina ese tipo lo veremos más adelante.

## Diferencia entre = y :=

Esta es una de las confusiones más comunes al empezar en Go.

- := declara e inicializa
- = asigna a una variable ya existente

Ejemplo correcto:

```
x := 10   // declaración
x = 20    // asignación
```

Ejemplo incorrecto:

```
x := 10
x := 20  // ERROR: x ya existe
```

## Declaración múltiple de variables

Go permite declarar varias variables en una sola línea.

Con var:

```
var name, city = "Ana", "Madrid"
```

Con :=

```
x, y := 10, 20
```

Esto es muy común cuando una función devuelve varios valores, tal y como veremos en artículos posteriores.

## El ámbito (scope)

El ámbito (o *scope*) define en qué parte del código una variable es visible y utilizable. Fuera de ese ámbito, la variable simplemente no existe.

En Go, el ámbito se rige por una regla sencilla pero estricta: una variable declarada dentro de un bloque delimitado por llaves {} solo existe dentro de ese bloque y en cualquier bloque anidado dentro de él.

Una variable declarada en un bloque solo es accesible desde ese bloque:

```
if true {
    x := 10
    fmt.Println(x)
}
// x no existe aquí
```

Una variable declarada dentro de una función vive en el bloque de esa función.

```
func example() {
    y := 20
    fmt.Println(y)
}
// y no existe fuera
```

Las variables declaradas fuera de cualquier bloque de función (es decir, a nivel de paquete), tienen un ámbito que abarca todo el paquete, e incluso pueden ser visibles desde otros paquetes si su nombre comienza con mayúscula y el paquete es importado.

```
package main

var version = "1.0.0"

func main() {
    fmt.Println(version)
}
```

Estos ejemplos han usado estructuras que veremos en artículos posteriores. Céntrate en observar dónde la variable existe y dónde no.

Esta disciplina garantiza que cada variable exista únicamente donde se necesita, lo que reduce el riesgo de usos accidentales, evita efectos secundarios y hace que el código sea más fácil de entender, probar y mantener.

# Conclusión

Las variables en Go son simples, explícitas y seguras por diseño. No se trata de limitaciones, sino de intencionalidad: el lenguaje te obliga a ser claro sobre qué datos manejas, cuándo existen y dónde pueden usarse.

En este artículo has visto cómo declarar variables, cómo se inicializan automáticamente y cómo su ámbito define su ciclo de vida. Aún no hemos entrado en los tipos de datos concretos que pueden almacenar, pero ya tienes el modelo mental necesario para entenderlos cuando llegue el momento.

El siguiente paso natural es explorar qué tipos de datos ofrece Go y cómo el lenguaje los utiliza para mantener la seguridad y la claridad del código.

¿Te ha servido este contenido? Únete al [canal de Telegram](https://t.me/lateclaescape), es totalmente gratuito y allí encontrarás una comunidad de usuarios expertos en la materia que pueden ayudarte a resolver todas tus dudas.

¡Nos vemos en el próximo artículo!

Pulso la tecla `ESC:wq!`
