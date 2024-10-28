---
title: Uso de fork con multithreads
date: 2024-01-02
image: "/img/posts/la-tecla-esc.jpg"
categories: [ "development" ]
tags: [ "fork", "pthread" ]
draft: true
featured: true
---

Motivación =

Vamos a explicar un problema que puede ocurrir a la hora de desarrollar codigo
en un proyecto multithread donde quieres hacer uso de la llamada al sistema
fork().

Parte teorica =====

Cuando trabajas en un proyecto con multithread, existen mutex compartidos por
los distintos pthread, que pueden bloquearse o liberarse.

Si intentas hacer uso de la llamada fork() en un proyecto que utiliza varios
pthreads, te expones a problemas serios. Al hacer una llamada a fork() en un
entorno multithread, creas un nuevo proceso hijo que es una copia exacta del
proceso padre. Este proceso hijo solo tendrá un thread puesto que fork() solo
clona el pthread que está en ejecución en el momento del fork(). Los mutex son
variables (la zona de memoria se copia tal cual). Lo que provoca que cualquier
mutex bloqueado por el proceso padre quede eternamente bloqueado en el proceso
hijo.

Esto no suele ser un problema cuando llamas a exec() justo despues de crear al
hijo con fork(). Sin embargo, cuando el hijo desea realizar ciertas acciones
antes de llamar al exec() (por ejemplo escribir cosas en el syslog), o incluso
si nunca llama a exec(), entonces es cuando nos podemos encontrar con
escenarios de deadlocks.


Que ves en la practica? =====

En la practica, lo que veras cuando hagas un ps fax son varias instancias del
mismo proceso corriendo. Solo una de las instancias estará en ejecución. El
resto serán instancias bloqueadas en un mutex que no finalizará nunca.

Y esto es debido a procesos hijo que estan quedando bloqueados en un mutex que
nadie liberará nunca.

Es por ello que distintas fuentes recomiendan evitar llamadas a fork() en
programas que utilizan pthreads.

Mas info aqui:

https://stackoverflow.com/questions/6078712/is-it-safe-to-fork-from-within-a-thread/6079669#6079669
https://docs.oracle.com/cd/E19455-01/806-5257/gen-92888/index.html


Como afrotamos este problema? =====

Lo primero que recomiendan es que una aplicación use pthreads o forks, de forma
exclusiva (o unos o otros). Pero no ambos.

Cuando trabajas en un entorno multithread en el que se utilizan mutex para
sincronizar el acceso a recursos compartidos, lanzar comandos de shell
directamente desde los threads con fork puede causar problemas de
sincronización y bloqueos inesperados. Esto se debe a que la creación de nuevos
procesos o ejecución de comandos de shell pueden ser operaciones costosas y
pueden entrar en conflicto con los mutex existentes.

Una alternativa segura es utilizar un pool de hilos para manejar la ejecución
de los comandos de shell. Aquí tienes un ejemplo de cómo hacerlo utilizando la
biblioteca pthread en C:

    #include <pthread.h>
    #include <stdlib.h>
    #include <stdio.h>

    void *run_command(void *command)
    {
        char *cmd = (char *)command;
        system(cmd);
        free(cmd); // Libera la memoria asignada para el comando
        pthread_exit(NULL);
    }

    int main()
    {
        pthread_t threads[NUM_THREADS]; // NUM_THREADS es el número de hilos que deseas utilizar
        char *commands[NUM_COMMANDS] = {
            "ls -l",
            "echo Hello, World!",
            // ... más comandos ...
        };

        for (int i = 0; i < NUM_THREADS; ++i) {
            char *cmd = strdup(commands[i]); // Duplica el comando para evitar problemas de sincronización
            pthread_create(&threads[i], NULL, run_command, (void *)cmd);
        }

        // Espera a que todos los hilos terminen
        for (int i = 0; i < NUM_THREADS; ++i) {
            pthread_join(threads[i], NULL);
        }

        return 0;
    }



