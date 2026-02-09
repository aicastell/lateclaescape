---
title: Selección múltiple switch en Go
date: 2026-01-31
image: /img/posts/golang-flow-control-switch.webp
categories: [ "programming_language" ]
tags: [ "golang", "switch", "flow_control" ]
draft: false
featured: true
---

# Introducción

En los artículos anteriores has entendido cómo Go estructura el código mediante bloques de instrucciones y cómo expresa condiciones estrictamente booleanas. También has aprendido a combinar ambos conceptos mediante la sentencia `if`, que permite ejecutar bloques de código en función de una condición.

Sin embargo, no todas las decisiones tienen la misma forma. En muchos casos, un programa necesita elegir entre varios caminos posibles basándose en un mismo valor o en un conjunto ordenado de condiciones relacionadas. Para estos escenarios, Go ofrece la sentencia `switch`.

`switch` no introduce un modelo de control de flujo nuevo. Al contrario, es una extensión natural de lo que ya conoces. Sigue basándose en condiciones, bloques y evaluación secuencial, pero permite expresar decisiones múltiples de forma más clara, segura y legible que largas cadenas de `else` + `if`.

En este artículo aprenderás cómo funciona `switch` en Go, cuándo usarlo y por qué su diseño evita errores comunes presentes en otros lenguajes.

# La sentencia switch

Cuando varias decisiones dependen de un mismo valor o de condiciones relacionadas entre sí, Go proporciona el `switch`, una estructura de control más expresiva que `if`.

Existen dos variantes claramente diferenciadas:

- El `switch` con expresión.
- El `switch` sin expresión.

Vemos cada una por separado:

## El `switch` con expresión

La forma más habitual de `switch` evalúa una expresión y la compara con distintos valores posibles.

```
switch expresion {
case valor1:
    // bloque
case valor2:
    // bloque
default:
    // bloque si ningún caso coincide
}
```

Aquí:

- La expresión del `switch` se evalúa una sola vez.
- Cada `case` debe contener valores comparables con esa expresión.
- La comparación es estrictamente equivalente a `expresion == valor`.

Ejemplo:

```
dia := "lunes"

switch dia {
case "lunes":
    fmt.Println("Inicio de semana")
case "viernes":
    fmt.Println("Fin de semana cerca")
default:
    fmt.Println("Día intermedio")
}
```

En este ejemplo:

- La expresión del `switch` es `dia`.
- Al entrar en el `switch`, esa expresión se evalúa una sola vez y produce un valor (en este caso, `lunes`).
- Go compara ese valor con cada `case`, utilizando internamente el operador `==`.
- Go evalúa los `case` uno por uno, en el orden en que aparecen en el código.
- Al encontrar una coincidencia, Go ejecuta su bloque y deja de evaluar el resto de casos.
- Tras ejecutar ese bloque, el `switch` finaliza automáticamente (no es necesario `break`).
- Si ningún `case` coincide, se ejecuta el bloque `default` (si existe).
- El bloque `default` es opcional, pero recomendable para cubrir situaciones no previstas.

En los `switch` con expresión, los valores del `case` deben ser valores comparables mediante `==` con la expresión del `switch`.

```
nota := 7
switch nota {
case nota >= 5:   // Error: cannot convert nota >= 5 (untyped bool value) to type int
    fmt.Println("Aprobado")
}
```

Este ejemplo no compila porque:

- La expresión del `switch` es `nota`, cuyo tipo es `int`.
- El valor del `case` es `nota >= 5`, cuyo tipo es `bool`.
- En Go no se puede comparar un `int` con un `bool`.

Cada `case` puede definir una lista de valores válidos, separados por comas. El `case` se considera coincidente si la expresión del `switch` es igual a cualquiera de esos valores.

```
dia := "sábado"

switch dia {
case "sábado", "domingo":
    fmt.Println("Fin de semana")
case "lunes", "martes", "miércoles", "jueves", "viernes":
    fmt.Println("Día laboral")
}
```

La ejecución ocurre así:

- La expresión del `switch` es `dia`.
- Al entrar en el `switch`, Go evalúa la expresión una sola vez y obtiene su valor actual (`sábado`).
- Go comienza a evaluar los `case` en el orden en que aparecen en el código.
- En el primer `case`, Go compara el valor de `dia` con cada uno de los valores listados (`sábado` y `domingo`).
- Si el valor de `dia` es igual (==) a cualquiera de ellos, el `case` se considera coincidente.
- Si el primer `case` no coincide, Go pasa al siguiente `case` y repite el mismo proceso de comparación con todos sus valores.
- Al encontrar una coincidencia, Go ejecuta el bloque asociado a ese `case` .
- Finaliza inmediatamente el `switch` (no hay caída automática al siguiente `case`).
- Si ningún `case` coincide, no se ejecuta ningún bloque (o se ejecutaría `default`, si estuviera presente).

Este mecanismo evita duplicar código y deja clara la relación entre los distintos valores del `case` y el comportamiento asociado.

Cuando los `case` son expresiones constantes, Go detecta valores duplicados en tiempo de compilación:

```
switch dia {
case "lunes":
    fmt.Println("Inicio de semana")
case "lunes": // Error: duplicate case "lunes" in switch
    fmt.Println("Otra cosa")
}
```

El compilador detecta esta duplicidad y da un error.

Sin embargo, si los valores de los `case` no son constantes, Go no puede evaluarlos durante la compilación, por lo que no detecta duplicidad aunque en tiempo de ejecución sean iguales:

```
x := 3
y := 3

switch 3 {
case x:   // OK: x es una variable, no una constant expression
case y:   // OK: y también es variable
}
```

Este código compila sin errores. Pero en ejecución solo se ejecuta el primer `case` que coincide (el del caso `x`).

## El `switch` sin expresión

Cada `case` es una condición booleana, y el `switch` se comporta como una cadena ordenada de condiciones. Es una de las características mas potentes del `switch` en Go.

```
switch {
case condicion1:
    // bloque
case condicion2:
    // bloque
default:
    // bloque
}
```

Aquí:

- Cada `case` debe ser una expresión booleana.
- Go evalúa los `case` en orden, y ejecuta el primero que resulte `true`.

Ejemplo:

```
nota := 8

switch {
case nota >= 9:
    fmt.Println("Sobresaliente")
case nota >= 7:
    fmt.Println("Notable")
case nota >= 5:
    fmt.Println("Aprobado")
default:
    fmt.Println("Suspenso")
}
```

En este ejemplo:

- El `switch` no define ninguna expresión explícita, se ejecuta siempre.
- Al entrar en el `switch`, Go comienza a evaluar los `case` en el orden en que aparecen.
- Cada `case` contiene una expresión booleana completa, que se evalúa de forma independiente.
- Go evalúa la condición del primer `case` y si es `true`, se ejecuta su bloque asociado y finaliza (no es necesario `break`).
- Si la condición es `false`, Go continúa con el siguiente `case`.
- Si ningún `case` se evalúa como `true`, se ejecuta el bloque `default` (si existe).
- El bloque `default` es opcional, pero recomendable para cubrir situaciones no previstas.

Este patrón es una alternativa clara y legible a cadenas largas de `else if`.

# Inicialización en la sentencia `switch`

Al igual que ocurre con `if`, Go permite declarar e inicializar variables locales directamente en la sentencia `switch`. Esta inicialización forma parte de la propia estructura de control y no depende del tipo de `switch` que se utilice.

Forma general:

```
switch [inicialización]; [expresión] {
case valor1:
    // código
case valor2:
    // código
default:
    // código
}
```

Aquí:

- La inicialización es opcional.
- La variable inicializada (cuando se usa) existe únicamente dentro del bloque del switch y deja de existir al salir de él.
- El `;` solo aparece si hay inicialización.
- Si hay inicialización, esta va siempre antes del `;`.
- La expresión es opcional.
- La expresión, si existe, va siempre después del `;`.

Vemos los distintos casos posibles:

## Sin inicialización, con expresión

```
switch dia {
case "lunes":
    ...
}
```

Aquí:

- No hay `;`
- `dia` es la expresión

## Con inicialización, con expresión

```
switch dia := "lunes"; dia {
case "lunes":
    ...
}
```

Aquí:

- Hay inicialización, por tanto hay `;`
- La expresión va después del `;`

## Sin inicialización, sin expresión

```
switch {
case true:
    ...
}
```

Aquí:

- No hay inicialización, por tanto no hay `;`
- No hay expresión
- Cada `case` es una condición booleana

## Con inicialización, sin expresión

```
switch n := 7; {
case n > 0:
    ...
}
```

Aquí:

- Hay inicialización, por tanto hay `;`
- No hay expresión
- Cada `case` debe ser una condición booleana

# fallthrough: uso explícito (y excepcional)

En Go no existe caída automática entre casos. Si necesitas que un caso continúe ejecutando el bloque siguiente, debes indicarlo explícitamente con `fallthrough`.

Ejemplo:

```
switch n := 2; n {
case 1:
    fmt.Println("uno")
case 2:
    fmt.Println("dos")
    fallthrough
case 3:
    fmt.Println("tres")
}
```

Salida:

```
dos
tres
```
Advertencia importante:

- `fallthrough` no evalúa la condición del siguiente `case`
- Ejecuta el bloque directamente

Su uso es poco común y suele indicar un mal diseño. En código Go real, se utiliza de forma muy puntual y siempre con intención clara.

# Resumen mental

- `switch` es una evolución natural de `if`
- Evalúa una expresión o una serie de condiciones
- Solo se ejecuta un `case`
- No hay caída implícita entre casos
- `fallthrough` es explícito y excepcional
- Permite inicialización local
- Mejora la legibilidad en decisiones complejas

# Conclusión

El control de flujo en Go no pretende ser ingenioso, sino predecible, legible y seguro. La sentencia `switch` refuerza esta filosofía permitiendo expresar decisiones complejas sin introducir ambigüedades ni comportamientos implícitos.

Con `if` y `switch`, Go proporciona exactamente las herramientas necesarias para razonar sobre cualquier decisión de un programa, manteniendo siempre una relación clara entre condiciones y bloques de instrucciones.

En el próximo artículo daremos el siguiente paso natural, y veremos estructuras de repetición, es decir, los bucles `for`.

Si has llegado hasta aquí y este artículo te ha gustado, te has quedado con alguna duda, o simplemente te apetece debatir sobre el aprendizaje de Go, pásate por el [canal de Telegram](https://t.me/lateclaescape). Allí nos hemos juntado unos cuantos a los que nos apasiona esto de desarrollar software. Compartimos dudas, aprendemos trucos, comentamos proyectos reales y nos echamos una mano siempre que hace falta. Es un espacio abierto, gratuito y con muy buen ambiente.

¡Nos vemos en el próximo artículo!

Pulso la tecla `ESC:wq!`
