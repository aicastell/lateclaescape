---
title: Condiciones if else en Go
date: 2026-01-25
image: /img/posts/golang-flow-control-for.webp
categories: [ "programming_language" ]
tags: [ "golang", "if_else", "flow_control" ]
draft: false
featured: true
---

# Introducción

Hasta ahora hemos visto cómo un programa toma decisiones (if, switch). El siguiente paso natural es permitir que un programa repita acciones.

Repetir significa ejecutar un mismo bloque de código varias veces, mientras se cumpla una condición o hasta que ocurra un evento determinado.

En Go, toda repetición se expresa con una única estructura de control: `for` es el único bucle del lenguaje. No existen while, do-while ni foreach. Esta decisión no limita al lenguaje: al contrario, hace que el control de flujo sea uniforme, explícito y fácil de razonar.

# Idea fundamental

Un bucle for en Go define:

- Un punto de entrada
- Una condición de continuidad
- Un bloque de código que se repite
- Un punto claro de salida

Cada iteración del bucle ejecuta el bloque una vez, en orden secuencial.

# Forma general del for

La forma más conocida del `for` es la llamada forma clásica:

```
for inicialización; condición; post {
    // bloque que se repite
}
```

Cada una de las tres partes tiene un propósito claro:

- Inicialización: se ejecuta una sola vez, al entrar en el bucle.
- Condición: se evalúa antes de cada iteración. Debe ser una expresión booleana.
- Post: Se ejecuta al final de cada iteración, antes de volver a evaluar la condición.

Si la condición es false, el bucle termina.

Ejemplo básico

```
for i := 0; i < 3; i++ {
    fmt.Println(i)
}
```

Aquí:

- Se declara i y se inicializa a 0.
- Se evalúa la condición i < 3.
- Si es verdadera, se ejecuta el bloque.
- Se ejecuta i++.
- Se vuelve al paso 2.
- Cuando la condición es falsa, el bucle finaliza.

Salida:

```
0
1
2
```

# Bloques y ámbito en el for

El `for` introduce un nuevo bloque, igual que `if` y `switch`.

```
for i := 0; i < 3; i++ {
    fmt.Println(i)
}
```

Aspectos importantes:

- i solo existe dentro del bucle
- No es accesible fuera
- Esto refuerza el principio de ámbito mínimo, ya visto anteriormente

# El for como bucle condicional (estilo while)

En Go, la inicialización y el post son opcionales.

Si se omiten, el `for` se comporta como un `while` tradicional:

```
n := 3

for n > 0 {
    fmt.Println(n)
    n--
}
```

Aquí:

- No hay inicialización dentro del `for`
- La condición se evalúa antes de cada iteración
- El control del estado ocurre dentro del bloque

Este patrón es idiomático en Go.

# El bucle infinito

Si se omite también la condición, el for se convierte en un bucle infinito:

```
for {
    fmt.Println("Esto se repite indefinidamente")
}
```

Este tipo de bucle:

- No tiene condición de salida implícita
- Debe interrumpirse explícitamente

Lo veremos en detalle cuando hablemos de `break` y `continue`.

# Control explícito del bucle

Dentro de un for (entiendo que te refieres a dentro del bloque de instrucciones) pueden usarse dos instrucciones de control:

- break
- continue

## break

Finaliza el bucle inmediatamente:

```
for i := 0; i < 10; i++ {
    if i == 3 {
        break
    }
    fmt.Println(i)
}
```

Salida:

```
0
1
2
```

## continue

Salta a la siguiente iteración:

```
for i := 0; i < 5; i++ {
    if i == 2 {
        continue
    }
    fmt.Println(i)
}
```

Salida:

```
0
1
3
4
```

Ambas instrucciones hacen explícito el flujo de ejecución.

# Comparación conceptual con otros lenguajes

En muchos lenguajes existen múltiples bucles:

- for
- while
- do-while
- foreach

En Go:

- Todos esos comportamientos se expresan con `for`
- Cambia la forma, no el concepto
- El lector aprende una sola estructura, bien definida

Esto reduce ambigüedad y mejora la legibilidad del código.

# Idea clave

El `for` en Go no es una estructura "flexible" por accidente, sino por diseño:

- Una sola palabra clave
- Varias formas explícitas
- Sin comportamiento implícito
- Totalmente consistente con bloques y ámbito

# Resumen mental

- Go tiene un único bucle: for
- La condición siempre es booleana
- La inicialización y el post son opcionales
- El bucle introduce un nuevo ámbito
- break y continue controlan la ejecución
- No hay atajos ni formas ocultas

# Conclusión

Con for, Go completa su conjunto básico de control de flujo. Ya sabemos decidir (if, switch) y repetir (for).

El siguiente paso lógico es aplicar estas estructuras sobre conjuntos de datos, comenzando por los arrays, donde el bucle deja de ser un ejemplo artificial y pasa a ser una herramienta real.





Control de flujo en Go (IV): el bucle for

Hasta ahora hemos aprendido a tomar decisiones en Go: con if podemos ejecutar bloques de código según condiciones concretas, y con switch podemos manejar múltiples posibilidades de forma clara y ordenada.

El siguiente paso natural es repetir acciones, es decir, ejecutar un bloque de código varias veces mientras se cumpla una condición o hasta que ocurra un evento determinado.

En Go, toda repetición se realiza mediante una única estructura de control:

    for es el único bucle del lenguaje.

No existen while, do-while ni foreach. Esta simplificación hace que el control de flujo sea predecible, explícito y fácil de razonar, siguiendo la filosofía de diseño del lenguaje.
La idea fundamental del for

Un bucle for define:

    Un punto de entrada (opcional inicialización)

    Una condición de continuidad (obligatoria para detenerse)

    Un bloque de código que se repite

    Un punto de salida claro

Cada iteración del bucle ejecuta el bloque una sola vez, de forma secuencial, hasta que la condición se vuelve falsa o se rompe el bucle explícitamente.
Forma general

La forma más conocida del for es la llamada forma clásica:

for inicialización; condición; post {
    // código que se repite
}

    Inicialización: se ejecuta solo al entrar al bucle.

    Condición: se evalúa antes de cada iteración. Solo se admiten expresiones booleanas.

    Post: se ejecuta al final de cada iteración, antes de volver a evaluar la condición.

Si la condición es false, el bucle termina automáticamente.
Ejemplo básico

for i := 0; i < 3; i++ {
    fmt.Println(i)
}

Secuencia de ejecución:

    Se declara i y se inicializa a 0.

    Se evalúa la condición i < 3.

    Si es verdadera, se ejecuta el bloque.

    Se ejecuta i++.

    Se vuelve al paso 2.

    Cuando la condición es falsa, el bucle finaliza.

Salida:

0
1
2

Bloques y ámbito en el for

El for introduce un nuevo bloque:

for i := 0; i < 3; i++ {
    fmt.Println(i)
}

    La variable i solo existe dentro del bucle.

    Fuera del bloque no se puede acceder a i.

    Esto refuerza el principio de ámbito mínimo, consistente con lo visto en if y switch.

for como bucle condicional (estilo while)

Si se omite la inicialización y el post, el for se comporta como un while clásico:

n := 3

for n > 0 {
    fmt.Println(n)
    n--
}

    La condición n > 0 se evalúa antes de cada iteración.

    El control del estado ocurre dentro del bloque.

    Este patrón es idiomático y claro en Go.

Bucle infinito

Si se omite también la condición, el for se convierte en un bucle infinito:

for {
    fmt.Println("Esto se repite indefinidamente")
}

    No tiene condición de salida implícita.

    Se debe interrumpir explícitamente con break o mediante otras señales.

Control explícito del bucle

Go permite controlar la ejecución dentro de un for con instrucciones específicas:
break

Finaliza el bucle inmediatamente:

for i := 0; i < 10; i++ {
    if i == 3 {
        break
    }
    fmt.Println(i)
}

Salida:

0
1
2

continue

Salta a la siguiente iteración:

for i := 0; i < 5; i++ {
    if i == 2 {
        continue
    }
    fmt.Println(i)
}

Salida:

0
1
3
4

Estas instrucciones permiten un control explícito del flujo dentro del bloque, manteniendo siempre la claridad de la ejecución.
Comparación conceptual

En otros lenguajes existen múltiples bucles (for, while, do-while, foreach).

En Go:

    Todos estos comportamientos se expresan con un único for.

    La diferencia está en cómo se escriben la condición y la inicialización, no en la semántica.

    Esto reduce ambigüedades y facilita el razonamiento sobre el código.

Idea clave

El bucle for en Go es:

    Una estructura única y consistente

    Flexible en su forma

    Explícita en su condición y control

    Integrada con el modelo de bloques y ámbito

Resumen mental

    Go tiene un único bucle: for

    La condición siempre debe ser booleana

    Inicialización y post son opcionales

    Introduce un nuevo bloque y ámbito

    break y continue permiten control explícito

    No hay atajos ni comportamientos implícitos

Cierre y siguiente paso

Con for completamos la base del control de flujo en Go:

    if decide entre caminos

    switch gestiona múltiples alternativas

    for permite repetir bloques de manera clara y explícita

El siguiente paso natural es aplicar estas estructuras a datos reales, comenzando por arrays y slices. Allí el bucle for deja de ser un ejemplo teórico y se convierte en la herramienta fundamental para procesar colecciones.

Si quieres, puedo preparar directamente el artículo sobre arrays y slices, perfectamente conectado con este for, con ejemplos prácticos de iteración y acceso a elementos, para que la serie quede completamente coherente y pedagógica.

¿Quieres que haga eso a continuación?















1G
