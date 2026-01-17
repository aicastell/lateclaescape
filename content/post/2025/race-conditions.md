---
title: Race conditions
date: 2025-03-05
image: /img/posts/race-condition.jpg
categories: [ "programación" ]
tags: [ "concurrencia", "race_condition" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/race-conditions.mp3" >}}

# Introducción

El término *race condition* o *condición de carrera* es probable que te haga pensar en la previsión meteorológica de la próxima carrera de Fernando Alonso. Pero no, hoy no he venido a hablar de Fórmula 1. Aunque seguramente tendría más seguidores si lo hiciera (sigo siendo demasiado optimista). En este articulo hablo sobre programación de software. Y más específicamente, sobre programación concurrente.

Las *race conditions* son un problema clásico al que nos enfrentamos los programadores informáticos. Se producen cuando dos o más procesos intentan modificar un recurso compartido al mismo tiempo sin una sincronización adecuada, lo que puede desencadenar comportamientos inesperados y errores dignos de un "en mi PC funciona". Lo peor de estos fallos es que suelen ser tan impredecibles como la estrategia de neumáticos en un Gran Premio: nadie sabe realmente qué va a pasar hasta que se estrellan.

Aunque parezcan un problema sencillo, las *race conditions* siguen siendo un desafío incluso para programadores experimentados. En este artículo te explico qué son, por qué ocurren y cómo evitarlas antes de que tu código se estrelle en la primera curva.

# El problema

En programación concurrente, una *race condition* ocurre cuando dos o más procesos o hilos intentan acceder al mismo recurso al mismo tiempo sin coordinación. Este recurso puede ser una variable, un archivo, una base de datos, un puerto, una cola de mensajes, una caché compartida, etc. Si ambos intentan leer y escribir simultáneamente sin un mecanismo de control, pueden generarse errores impredecibles, como datos corruptos o cálculos incorrectos.

Imagina dos procesos que comparten una variable compartida llamada *contador*. Ambos procesos acceden a esa variable compartida en modo R/W (lectura/escritura) o en modo W/W (escritura/escritura).

Supongamos que en un determinado momento, la variable *contador* vale 5. Dos procesos llamados P y C van a hacer un uso concurrente de la variable *contador*. El proceso P ejecuta una instrucción para incrementar en 1 el valor de *contador*:

```
// Proceso P
P. contador = contador + 1
```

Y el proceso C ejecuta una instrucción para decrementar en 1 el valor de *contador*:

```
// Proceso C
C. contador = contador - 1
```

Cualquiera pensaría que, al sumar uno y restar uno, la variable *contador* debería seguir siendo 5. Pero en programación concurrente, este resultado no está garantizado. Las *race conditions* pueden alterar el comportamiento esperado y generar valores incorrectos, como 4 o 6. ¿Cómo es posible?

Las instrucciones anteriores se traducen en ensamblador (el juego de instrucciones mas básico del procesador) de la siguiente manera:

```
// P. contador = contador + 1
P1. reg1 = contador;
P2. reg1 = reg1 + 1;
P3. contador = reg1;

// C. contador = contador - 1
C1. reg2 = contador;
C2. reg2 = reg2 - 1;
C3. contador = reg1;
```

La CPU garantiza que las instrucciones de cada proceso (P y C) se ejecutarán en secuencia, es decir, una detrás de la otra. Por tanto, P1 se ejecutará siempre antes que P2. Y P2 antes que P3. Y del mismo modo, C1 se ejecutará siempre antes que C2. Y C2 antes que C3.

Sin embargo, aunque se respete el orden de las instrucciones dentro de cada proceso, en **programación concurrente**, las instrucciones de ambos procesos P y C pueden entrar en la CPU intercaladas en cualquier orden. Por tanto, existen muchas secuencias de ejecución diferentes, y todas ellas son válidas. Pero algunas secuencias pueden generar resultados incorrectos, como veremos a continuación.

# Análisis de ejecuciones

Analicemos 3 ejecuciones concurrentes de los procesos P y C:

## Ejecución 1

La variable contador vale 5. Analiza la secuencia de instrucciones P1, P2, C1, C2, P3, C3:

```
P1. reg1 = contador;                // reg1 = 5
P2. reg1 = reg1 + 1;                // reg1 = 6
C1. reg2 = contador;                // reg2 = 5
C2. reg2 = reg2 - 1;                // reg2 = 4
P3. contador = reg1;                // contador = 6
C3. contador = reg2;                // contador = 4
```

Fíjate como la variable contador finaliza con valor 4, que es **incorrecto**.

## Ejecución 2

La variable contador vale 5. Analiza la secuencia de instrucciones P1, P2, C1, C2, C3, P3:

```
P1. reg1 = contador;                // reg1 = 5
P2. reg1 = reg1 + 1;                // reg1 = 6
C1. reg2 = contador;                // reg2 = 5
C2. reg2 = reg2 - 1;                // reg2 = 4
C3. contador = reg2;                // contador = 4
P3. contador = reg1;                // contador = 6
```

Fíjate como la variable contador finaliza ahora con el valor 6, que también es **incorrecto**.

## Ejecución 3

La variable contador vale 5. Analiza ahora la secuencia de instrucciones P1, P2, P3, C1, C2, C3:

```
P1. reg1 = contador;                // reg1 = 5
P2. reg1 = reg1 + 1;                // reg1 = 6
P3. contador = reg1;                // contador = 6
C1. reg2 = contador;                // reg2 = 6
C2. reg2 = reg2 - 1;                // reg2 = 5
C3. contador = reg2;                // contador = 5
```

Fíjate como la variable contador finaliza ahora con el valor 5, que es **correcto**.

Las ejecuciones incorrectas pueden provocar todo tipo de errores: desde un cajero automático que dispense dinero de más o de menos hasta fallos en un sistema de vuelo que pongan en riesgo la estabilidad de un avión comercial.

# Race condition en C

[Este código fuente](https://github.com/aicastell/ipc/blob/main/race_condition/race_cond.c) escrito en lenguaje C muestra dos hilos intentando incrementar de forma concurrente una misma variable compartida llamada *contador*:

El código anterior inicializa una variable global llamada *contador* con valor 0. Después, crea dos hilos. Cada uno de ellos incrementa 1000000 veces esa variable *contador*. A priori, el resultado final debería ser 2000000. El código parece sencillo y claro. Sin embargo, si ejecutamos este código varias veces, vamos a obtener distintos resultados para la variable *contador*, y ninguno es correcto:

```
$ ./race_cond
Valor final del contador: 1018089

$ ./race_cond
Valor final del contador: 1143169

$ ./race_cond
Valor final del contador: 1032188
```

¿Por que sucede esto? El código sufre una condicion de carrera de campeonato. La variable *contador* es un recurso compartido por ambos hilos, que estan realizando operaciones de escritura simultaneamente sobre dicha variable sin ningún mecanismo de coordinación.

# Solución

Es necesario implementar un mecanismo que asegure el acceso ordenado y exclusivo al recurso compartido. Es crucial que los procesos se coordinen entre sí mediante un mecanismo bien estructurado para evitar estos problemas. Existen varios mecanismos que podemos utilizar para la sincronización de hilos y procesos que intentan acceder de forma concurrente a los mismos datos o código en una aplicación:

- Mutex
- Semáforos
- Monitores
- Funciones atómicas
- Spinlocks

Cada uno de estos mecanismos ofrece una forma diferente de asegurar la correcta sincronización y evitar condiciones de carrera. La elección del más adecuado depende del contexto y los requisitos específicos de la aplicación. Iremos hablando sobre los distintos mecanismos en próximos artículos.

# Despedida

Las *race conditions* no son precisamente el tipo de carrera en la que nos gusta ver a Fernando Alonso, donde la habilidad y la estrategia marcan la diferencia. En el mundo de la ingeniería de software, las carreras no se ganan, se evitan. Porque al final, no importa si tienes el mejor código o el hardware más potente, si dos procesos pisan el acelerador al mismo tiempo sin coordinación, el resultado será más caótico que una salida en mojado. Así que recuerda: en la programación, como en la Fórmula 1, el control y la sincronización lo son todo.

Puedes comentar en el [canal de Telegram](https://t.me/lateclaescape) si te parece interesante este contenido. Son bienvenidas las criticas, sugerencias, dudas o comentarios de cualquier tipo relacionados con el articulo. ¡Nos vemos en la siguiente vuelta!

Pulso la tecla `ESC:wq!`
