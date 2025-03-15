---
title: Los mutex
date: 2025-03-15
image: /img/posts/mutex.jpg
categories: [ "programación", "pthread" ]
tags: [ "concurrencia", "race condition", "mutex", "sección critica", "API" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/mutex.mp3" >}}

# Introducción

En un entorno de programación concurrente, varios hilos de ejecución pueden intentar acceder a un mismo recurso al mismo tiempo. Si este acceso concurrente no se controla de alguna manera, pueden ocurrir [condiciones de carrera](/post/2025/race-conditions), que tal y como analicé en un articulo anterior, pueden generar resultados inconsistentes e impredecibles.

Existen varios mecanismos para solucionar este problema. Uno de ellos son los **mutex**, mecanismo del que voy a hablar en este articulo.

# Mutual exclusion (mutex)

Un mutex es un mecanismo de sincronización utilizado en programación concurrente para evitar condiciones de carrera. Su propósito es garantizar que solo un hilo acceda a una **sección crítica** del código en un momento dado.

![Mutex access blocked](/img/mutex-accessing-blocked.webp)

¿Como funciona un mutex? Te pondré un ejemplo que vas a entender enseguida. Imagina un baño público con una sola puerta y un cerrojo. Si quieres usarlo, entras y cierras el cerrojo. Mientras estás dentro, nadie más puede entrar. Todo el mundo tiene que esperar. Cuando terminas, sales y dejas la puerta abierta para la siguiente persona.

En este ejemplo, las personas son los hilos de ejecución, y el baño es el recurso compartido. Como ves, el mutex asegura que solamente una persona acceda al baño, evitando conflictos cuando varios intentan usarlo simultáneamente.

# API de Mutex en C

El estándar POSIX Threads (pthreads) proporciona la API de mutex en C. Estas son sus funciones principales:

- pthread_mutex_init()
- pthread_mutex_lock()
- pthread_mutex_trylock()
- pthread_mutex_unlock()
- pthread_mutex_destroy()

## pthread_mutex_init

Esta función inicializa un mutex para poder empezar a a usarlo.

```
pthread_mutex_t mutex;
pthread_mutex_init(&mutex, NULL);
```

## pthread_mutex_lock

Esta función bloquea un mutex, y si ya está bloqueado, el hilo queda en espera hasta que se libere.

```
pthread_mutex_lock(&mutex); // Bloquea el mutex
// Sección crítica (acceso exclusivo a un recurso)
pthread_mutex_unlock(&mutex); // Libera el mutex
```

## pthread_mutex_trylock

Esta función intenta bloquear el mutex, pero sin bloquear el hilo si el mutex ya está ocupado. Si el mutex está libre, lo bloquea y devuelve 0. Si está ocupado, devuelve EBUSY y el hilo sigue ejecutándose sin esperar.

```
if (pthread_mutex_trylock(&mutex) == 0) {
    // Sección crítica
    pthread_mutex_unlock(&mutex);
} else {
    // El mutex está ocupado, hacer otra cosa
}
```

## pthread_mutex_unlock

Esta función libera un mutex bloqueado, permitiendo que otros hilos lo adquieran. Debe ser desbloqueado por el mismo hilo que lo bloqueó. Si no estaba bloqueado, el comportamiento es indefinido.

```
pthread_mutex_unlock(&mutex);
```

## pthread_mutex_destroy

Esta función libera los recursos de un mutex cuando ya no se va a usar. Solo debe llamarse si el mutex está desbloqueado.

# Solución con Mutex

[Este código fuente](https://github.com/aicastell/ipc/blob/main/mutex/mutex.c) en lenguaje C utiliza un mutex para resolver la [condición de carrera](/post/2025/race-conditions) que vimos en un articulo anterior.

Este código previene la condición de carrera, asegurando que solo un hilo incrementa la variable *contador* a la vez. El código ahora si imprime 2000000 como resultado final, siempre.

```
$ ./mutex
Valor final del contador: 2000000

$ ./mutex
Valor final del contador: 2000000

$ ./mutex
Valor final del contador: 2000000
```

# Deadlock

Uno de los problemas más frecuentes al trabajar con mutex es el **deadlock**. Ocurre cuando dos o más hilos quedan bloqueados indefinidamente, esperando la liberación de un recurso que nunca estará disponible.

![Mutex deadlock](/img/mutex-deadlock.webp)

¿Como se produce un deadlock? Para que entiendas el problema, te pondré otro ejemplo sencillo. Imagina un puente estrecho por donde solo cabe un coche a la vez. En cada extremo hay un coche queriendo pasar. El coche 1 entra desde un lado y avanza hasta la mitad del puente. El coche 2 entra desde el otro lado y también avanza hasta la mitad. Ahora, ninguno puede seguir avanzando porque el otro está bloqueando el camino. Tampoco pueden retroceder fácilmente porque hay tráfico detrás. Se quedan atascados sin poder moverse, generando un deadlock.

En este caso, los coches representan hilos de ejecución. Y el puente representa el recurso compartido que ambos necesitan usar. En programación, esto sucede cuando dos hilos bloquean recursos en un orden que impide que ambos avancen.

## Deadlock en C

[Este código fuente](https://github.com/aicastell/ipc/blob/main/deadlock/deadlock.c) en lenguaje C muestra dos hilos bloqueados en un deadlock.

Este código produce un deadlock debido a la forma en que los dos hilos intentan bloquear los mutex en orden inverso. El thread1 bloquea el mutex1 y el thread 2 bloquea el mutex2. Ahora el thread 1 intenta bloquear mutex2, pero ya está bloqueado por Thread 2, por lo que queda esperando. Y el thread 2 intenta bloquear el mutex1, pero ya está bloqueado por Thread 1, por lo que también queda esperando. En este punto, ambos hilos están esperando que el otro libere un mutex, pero eso no sucederá nunca. Esto genera un deadlock.

# Soluciones al deadlock

Existen dos maneras de solucionar un deadlock:

- Orden consistente
- Uso de pthread_mutex_trylock

## Orden consistente

Para evitar el deadlock, se puede asegurar un orden consistente en la adquisición de los mutex.

[Este código fuente](https://github.com/aicastell/ipc/blob/main/deadlock/fix1/deadlock_fix1.c) escrito en C resuelve el problema haciendo que ambos hilos bloqueen los mutex en el mismo orden: primero el mutex 1 y después el mutex2. Esto evita el deadlock.

## Uso de pthread_mutex_trylock

En lugar de usar pthread_mutex_lock para adquirir el segundo mutex, se utiliza pthread_mutex_trylock. Si el mutex no está disponible, pthread_mutex_trylock devuelve inmediatamente con un código de error en lugar de bloquear el hilo.

[Este código fuente](https://github.com/aicastell/ipc/blob/main/deadlock/fix2/deadlock_fix2.c) escrito en C resuelve el problema del deadlock utilizando la función pthread_mutex_trylock.

El thread 1 bloquea mutex1 y luego intenta bloquear mutex2. Si tiene éxito, realiza la operación crítica, desbloquea ambos mutex y sale del bucle. Si no puede bloquear mutex2, desbloquea mutex1, espera 1 segundo, y vuelve a intentar bloquear los mutex, comenzando con mutex1.

El thread 2 bloquea mutex2 y luego intenta bloquear mutex1. Si tiene éxito, realiza la operación crítica, desbloquea ambos mutex y sale del bucle. Si no puede bloquear mutex1, desbloquea mutex2, espera 1 segundo, y vuelve a intentar bloquear los mutex, comenzando con mutex2.

Este enfoque de reintentos asegura que siempre haya progreso. Si pthread_mutex_trylock no puede adquirir el segundo mutex, el hilo libera el primer mutex y espera un poco antes de reintentar. Esto evita el deadlock al permitir que ambos hilos retrocedan y reintenten la adquisición de los mutex.

Una vez que un hilo adquiere ambos mutex y realiza la operación crítica, sale del bucle y termina su ejecución. Este enfoque asegura que los hilos no se queden bloqueados indefinidamente y evita el deadlock.

# Cierre

En este articulo has aprendido que los mutex son esenciales para evitar las race conditions, garantizando que solo un hilo acceda a un recurso compartido a la vez. Sin embargo, su uso incorrecto puede provocar deadlocks, donde dos hilos quedan bloqueados eternamente, esperando la liberación de un recurso ya bloqueado por otro hilo. Este articulo te ha enseñado dos estrategias para evitar los deadlocks.

Dominar estos conceptos es clave para desarrollar programas concurrentes eficientes y estables. Un uso correcto de los mutex no solo previene errores, sino que también mejora el rendimiento y la escalabilidad de las aplicaciones multihilo.

Espero que este articulo te haya resultado útil. Cualquier duda, no dudes en preguntar por el [canal de Telegram](https://t.me/lateclaescape), donde estaré atento a tus comentarios e intentaré ayudarte a resolver cualquier duda que te surja relacionada con ésta o con otras cuestiones.

¡Nos vemos en el siguiente articulo!

Pulso la tecla ESC, dos puntos wq!
