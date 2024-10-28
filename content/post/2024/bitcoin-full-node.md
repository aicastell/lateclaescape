---
title: Bitcoin full-nodes
date: 2023-12-27
draft: true
categories: ["criptomonedas"]
tags: [ "bitcoin", "nodos", "red de malla"]
draft: true
featured: true
---

# Introducción

  
  # Problema de coordinación
  
  Imagina por un momento que cada nodo de la red de Bitcoin insertara un bloque de transacciones nuevo de manera independiente en la copia local de su blockchain. Este evento daría lugar a l  a creación de múltiples variantes de la blockchain, conocidas como bifurcaciones o forks. Esto generaría inconsistencias en la red. 
  
  Como resultado, los nodos no podrían llegar a un consenso sobre cuál de todas es la blockchain válida. Lo que llevaría a un absoluto caos y la pérdida de confianza en el sistema de Bitcoin  .
  
  Al tratarse de un sistema distribuído, no existe una autoridad central que se encargue de coordinar a los nodos ni imponga un orden especial para insertar nuevos bloques en la blockchain.   Este es un desafío clave en las redes distribuidas.
  
  Es un buen momento para reflexionar. ¿Como se coordinan todos los nodos para añadir un nuevo bloque de transacciones a la blockchain de manera ordenada?.

Se utiliza el mecanismo de consenso que hemos hablado en el articulo anterior. Sin embargo,no he explicado como se usa ese mecanismo para insetar nuevos bloques en la blockchain.




## Nodo completo

Los **nodos completos** o **full nodes**, a parte de almacenar la copia completa de la blockchain (unos 600MB), se encargan de realizar el **proceso de verificación** de los bloques minados. La verificación de un bloque minado consiste en:

- Verificar que los hash del bloque sean validos
- Verificar que todas las transacciones dentro del bloque sean validas
- Verificar que el bloque siga el siguiente bloque de la blockchain mas larga de toda la red.

Si el bloque minado cumple con todas estas reglas, el full node acepta el bloque y lo añade a su propia copia local de la blockchain. Después propaga el bloque minado a otros full nodes de la red, que repiten el proceso de verificacion.

Si el proceso de verificación falla por cualquier motivo (por ejemplo, si el nodo minero hizo trampas incluyendo transacciones inválidas), el full node rechaza el bloque, que no será aceptado en su copia local, ni propagado al resto de los nodos de la red.










  Estos nodos guardan una copia completa de la blockchain, lo que permite verificar completamente todas las transacciones y todos los bloques desde el bloque génesis. Validan cada transacción y bloque de acuerdo con las reglas del protocolo de Bitcoin. Reciben, verifican   y propagan transacciones y bloques a otros nodos. Y aplican las reglas del consenso de Bitcoin, asegurando la integridad y seguridad de la red. Son esenciales para la descentralización y la seguridad de Bitcoin.
  
  Haremos un articulo próximamente para hablar especificamente sobre Bitcoin Core y sobre los pasos necesarios para convertir un ordenador de escritorio en un full node de Bitcoin.
  
  Son fundamentales para la descentralización y seguridad de la red. Pueden funcionar independientemente de los mineros.




El término "nodo completo" (full node) en la red Bitcoin se refiere a su capacidad de validar y propagar todas las transacciones y bloques de la blockchain, manteniendo una copia completa de toda la cadena de bloques. Aunque la minería solía ser una función que algunos nodos completos realizaban, la minería en sí misma ha evolucionado hasta convertirse en una tarea altamente especializada, debido a la competencia y la complejidad creciente de la red. Aquí está el motivo por el cual todavía se llama "nodo completo" a pesar de que la minería no es una de sus funciones principales:

Razones para Mantener el Término "Nodo Completo"

    Validación y Seguridad:
        Los nodos completos validan todas las transacciones y bloques según las reglas del protocolo Bitcoin.
        Verifican la autenticidad y la integridad de la blockchain, rechazando cualquier transacción o bloque inválido.
        Esta validación asegura que todas las transacciones cumplen con las reglas de consenso de Bitcoin, manteniendo la seguridad y la integridad de la red.

    Propagación de Datos:
        Los nodos completos propagan transacciones y bloques válidos a otros nodos en la red.
        Ayudan a distribuir la información de manera eficiente y rápida, asegurando que todos los nodos de la red tengan una copia actualizada de la blockchain.

    Mantenimiento de la Blockchain:
        Almacenan una copia completa de la blockchain, lo que permite a cualquier nodo acceder al historial completo de todas las transacciones realizadas en la red.
        Este almacenamiento completo es crucial para la descentralización, ya que no depende de una autoridad central para mantener la historia de las transacciones.

    Descentralización:
        La existencia de muchos nodos completos contribuye a la descentralización de la red, lo que es esencial para la resistencia a censura y ataques.
        Cualquiera puede operar un nodo completo, lo que permite una amplia distribución de la validación y la propagación de la información.

Evolución de la Minería

    Especialización:
        La minería se ha convertido en una tarea especializada que requiere hardware avanzado como ASICs para ser competitiva.
        Los mineros se centran exclusivamente en resolver problemas criptográficos (prueba de trabajo) para encontrar el nonce correcto y crear nuevos bloques.

    Separación de Roles:
        La red

ChatGPT

Vamos a completar la explicación sobre la separación de roles en la red Bitcoin y por qué los "nodos completos" siguen siendo llamados así aunque no realicen la función de minería.
Separación de Roles en la Red Bitcoin
Nodos Completos (Full Nodes)

    Validación y Propagación:
        Los nodos completos validan todas las transacciones y bloques según las reglas del protocolo Bitcoin, asegurando que todas las actividades en la red sean legítimas.
        Propagan transacciones y bloques válidos a otros nodos, manteniendo la red sincronizada y segura.

    Almacenamiento de la Blockchain:
        Mantienen una copia completa de la blockchain, permitiendo la verificación independiente de todo el historial de transacciones.

    Descentralización:
        Al permitir que cualquier persona opere un nodo completo, la red se mantiene descentralizada, evitando la dependencia de una autoridad central.

    Funcionalidades Complementarias:
        Aunque no participan en la minería, los nodos completos proporcionan infraestructura crítica que permite que la red funcione de manera eficiente y segura.

Nodos de Minería

    Resolución de Problemas Criptográficos:
        Los mineros se centran en resolver problemas criptográficos (prueba de trabajo) para encontrar el nonce correcto y crear nuevos bloques.
        Utilizan hardware especializado (ASICs) para realizar este trabajo intensivo en recursos.

    Creación de Bloques:
        Recogen transacciones de la mempool, las agrupan en bloques y compiten para añadir estos bloques a la blockchain.

    Recompensas:
        Reciben recompensas en forma de bitcoins nuevos y comisiones de transacciones por cada bloque que minan con éxito.

Razones para la Nomenclatura

    Historia y Evolución:
        Históricamente, los nodos completos también podían realizar la minería cuando la dificultad de la red era mucho menor.
        Con el tiempo, a medida que la minería se volvió más competitiva, se especializó en hardware dedicado, pero los nodos completos mantuvieron su nombre y funciones esenciales de validación y propagación.

    Funciones Esenciales:
        La principal función de un nodo completo es validar y propagar transacciones y bloques, lo cual sigue siendo vital para el funcionamiento de la red.
        Aunque la minería se ha especializado, la red depende de los nodos completos para mantener la integridad y la descentralización.

    Descentralización y Accesibilidad:
        La capacidad de cualquier individuo de operar un nodo completo sin necesidad de invertir en hardware de minería especializado es crucial para la descentralización.
        Esto permite una mayor participación y resistencia a la censura.

Conclusión

Los "nodos completos" siguen siendo llamados así debido a sus funciones esenciales de validación y propagación de transacciones y bloques, almacenamiento de la blockchain y mantenimiento de la descentralización de la red. Aunque la minería se ha especializado y se ha separado como una función distinta, los nodos completos desempeñan un papel crítico que justifica su nomenclatura y su importancia dentro del ecosistema de Bitcoin.




