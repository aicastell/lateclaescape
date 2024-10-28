---
title: Bitcoin lightweight node
date: 2023-12-27
image: "/img/posts/bitcoin-consensus-mechanism.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "nodos", "red de malla"]
draft: true
featured: true
---

https://www.athena-alpha.com/bitcoin-node/

- La red de bitcoin
- El nodo de bitcon
- Utilidad de los nodos
- Tipos de nodos
- Beneficios
- Protocolo gossip
- Red simplificada


# Motivación

En este articulo voy a hablar sobre los nodos de Bitcoin. Veremos que són los nodos de Bitcoin y como se interconectan entre sí para compartir toda la información.

## Nodo de Bitcoin

Un **nodo de Bitcoin** fisicamente puede ser cualquier tipo de ordenador, desde un PC de escritorio o un portatil, hasta una Raspberry PI.

Ese ordenador debe ejecutar un software especial conocido como **Bitcoin Core**, que lo convierte en un nodo de Bitcoin.

## Red de Bitcoin

Todos los nodos de Bitcoin están conectados a traves de Internet, formando una red de malla (mesh network) que se conoce como la **red de Bitcoin**.

Cada nodo de la red de Bitcoin se conecta solamente con algunos nodos cercanos (vecinos), evitando la necesidad de que cada nodo mantenga una conexión abierta con el resto de los nodos de la red, lo que sería extremadamente ineficiente.

En la red de Bitcoin, cuando se crea una transacción, cuando se crea un nuevo bloque de transacciones, o cuando se actualiza la blockchain, la información se comparte de vecino a vecino, y rápidamente se propaga a todos los nodos de la red. Propagación de información: Los nodos reconectados continúan propagando transacciones y bloques, asegurando que la red permanezca funcional y eficiente.

Como analogía, puedes imaginar a la red de Bitcoin como una red de pesca a nivel global, donde los nudos representan a los nodos de Bitcoin, y donde los hilos que unen a esos nudos representan las conexiones entre los nodos de Bitcoin.

En el portal [bitnodes.io](https://bitnodes.io/nodes/) puedes ver el número exacto de Nodos activos en la red de Bitcoin. En el momento exacto que escribo estas lineas, son 19304 nodos activos.

### Redundancia

En la red de Bitcoin, cuando un nodo deja de estar disponible, ya sea por un fallo o por una desconexión voluntaria, los nodos vecinos detectan la pérdida de conexión y buscan otros nodos disponibles para establecer nuevas conexiones y mantener la red de malla interconectada. Por tanto, cada nodo puede unirse o salir de la red en cualquier momento sin afectar el funcionamiento global de la red.

### Descentralizacion

La red de Bitcoin no tiene un punto central de control. Cada nodo tiene la misma importancia en el mantenimiento y operación de la red. No existe ningún nodo central donde se almacene información crítica, se procese información especial o se tomen decisiones importantes que lo diferencien de los demás. Si hubiera nodos centrales que guardaran información crítica o realizaran cálculos especiales, Bitcoin perdería todo su valor, ya que su característica única es la confianza en el consenso de la mayoría. Se creó precisamente para prescindir de una entidad centralizada que pudiera manipular la información registrada y almacenada. Al ser completamente distribuida, incluso si algunos países censuraran su uso, la red de Bitcoin seguiría operando en otros países.

### Escalabilidad

La red de Bitcoin también puede crecer añadiendo más nodos, lo que fortalece la red y mejora su capacidad para manejar más transacciones.

## Funciones

Los Nodos de Bitcoin tienen muchas responsabilidades. Voy a agrupar sus responsabilidades en tres grandes grupos:

- Manejo de transacciones
- Manejo de bloques de transacciones
- Gestion de la blockchain

Estas tres funciones van a ser la base de los proximos articulos. Haremos un articulo específico para hablar sobre cada una.

## Tipos de nodos

Inicialmente, todos los nodos de Bitcoin realizaban las mismas funciones, todas las descritas en el apartado anterior.

Sin embargo, con el crecimiento de la red y la complejidad de las operaciones, los nodos comenzaron a especializarse para manejar mejor las diferentes tareas requeridas. Esto ha llevado a la aparición de varios tipos de nodos con funciones específicas:

- Nodos completos
- Nodos de minería
- Nodos de validación ligera

Los **nodos completos**, tambien se conocen como **full node**. Hablaremos sobre ellos en próximos articulos.

Los **nodos de minería**, también conocidos como **mineros**. Hablaremos sobre ellos en próximos articulos.

Los **nodos de validación ligera**, tambien conocidos como **lightweight nodes**, **simplified payment verification**, o simplemente **nodos SPV**. Hablaremos sobre ellos en próximos articulos.



Estos nodos sirven para montar un nodo de Bitcoin en dispositivos con recursos de almacenamiento limitados. Solo necesitan descargar/almacenar las cabeceras de los bloques, por tanto, no necesitan almacenar una copia completa de la blockchain. Permiten verificar transacciones al confiar en full nodes externos para obtener la información necesaria para verificar la transacción.

Son utilizadas por wallets que no requieren la descarga completa de la blockchain, como por ejemplo Electrum.



Los Lightweight Nodes (nodos ligeros o SPV nodes) están diseñados principalmente para permitir a los usuarios realizar transacciones de manera eficiente y con menos recursos que un nodo completo. Aquí hay un resumen de sus características y funciones principales:
Funciones Principales de los Lightweight Nodes (SPV Nodes)

    Realizar Transacciones: Permiten a los usuarios enviar y recibir transacciones de Bitcoin sin la necesidad de descargar la blockchain completa.
    Verificación de Transacciones: Utilizan el método de Simplified Payment Verification (SPV) para verificar transacciones. Descargan solo los encabezados de los bloques y consultan a los nodos completos para confirmar que una transacción específica está incluida en un bloque.
    Menor Consumo de Recursos: Al no almacenar la blockchain completa, requieren menos espacio de almacenamiento, menos uso de ancho de banda y menos poder de procesamiento, lo que los hace ideales para dispositivos con recursos limitados como teléfonos móviles y computadoras portátiles.

Limitaciones de los Lightweight Nodes

    Dependencia de Nodos Completos: Dependen de los nodos completos para verificar la autenticidad de las transacciones, lo que introduce un grado de confianza en terceros.
    Menor Seguridad y Privacidad: Comparados con los nodos completos, los nodos ligeros no ofrecen el mismo nivel de seguridad y privacidad, ya que se basan en otros nodos para obtener información de la blockchain.
    No Participan en la Minería: Los Lightweight Nodes no pueden participar en la minería de Bitcoin, ya que no tienen una copia completa de la blockchain y no realizan una verificación exhaustiva de las transacciones.

Ejemplos de Lightweight Nodes (SPV Nodes)

    Electrum: Una de las billeteras SPV más populares que permite a los usuarios realizar transacciones de manera rápida y segura sin descargar la blockchain completa.
    BRD (Breadwallet): Una billetera móvil que ofrece una interfaz amigable y utiliza SPV para mantener la eficiencia y la rapidez.
    Mycelium: Una billetera móvil avanzada que utiliza SPV y ofrece funcionalidades adicionales para usuarios experimentados.

Conclusión

Los Lightweight Nodes están principalmente diseñados para facilitar la realización de transacciones de Bitcoin de manera eficiente y con menos consumo de recursos. No almacenan la blockchain completa y dependen de los nodos completos para la verificación de transacciones. Si bien son muy útiles para dispositivos móviles y usuarios que buscan una solución más ligera, no ofrecen el mismo nivel de seguridad y funcionalidad que los nodos completos.

Para más detalles sobre los Lightweight Nodes y sus aplicaciones, puedes consultar el whitepaper original de Bitcoin por Satoshi Nakamoto.





















### Red simplificada

Este documento tiene fines educativos y el número de nodos reportado es demasiado grande para manejar aquí.

Puesto que este documento tiene fines educativos, vamos a reducir la complejidad de esta red de Nodos a una escala manejable. En lugar de 17843, vamos a suponer que la red de Nodos de Bitcoin esta compuesta por 5 Nodos. Los vamos a nombrar de esta manera (BN, Bitcoin Node):

- BN1
- BN2
- BN3
- BN4
- BN5

Estos 5 nodos estan geográficamente repartidos por todo el mundo:

- BN1 en Estados Unidos
- BN2 en Rusia
- BN3 en China
- BN4 en Australia
- BN5 en España (en mi casa)

Aunque se puede correr un nodo de bitcoin sin wallet configurado, en caso de que eese nodo minara un bloque, se perdería su recompensa. Asi que lo aconsejable es tener un wllet configurado en cada nodo.

Cada nodo de Bitcoin debe tener configurado un wallet (WL). Por tanto tendremos que:

* BN1 tiene el wallet WL1
* BN2 tiene el wallet WL2
* BN3 tiene el wallet WL3
* BN4 tiene el wallet WL4
* BN5 tiene el wallet WL5

Esos 5 nodos están interconectados entre si a través de la red de redes (Internet).

## Despedida

De momento esto es todo. Nos vemos en el proximo post.

Pulso la tecla ESC, dos puntos wq!















# Sobre la mineria


Bitcoin Core, el software principal para la red Bitcoin, en el pasado permitía la minería en solitario (solo mining). Sin embargo, en la actualidad, Bitcoin Core ya no es adecuado para la minería en solitario de manera práctica debido a la alta dificultad de la red Bitcoin. Esto es debido a varios factores:

Factores que Hacen Impráctica la Minería en Solitario con Bitcoin Core

    Aumento de la Dificultad de Minería:
        La dificultad de la red Bitcoin ha aumentado considerablemente con el tiempo. La competencia con grandes operaciones de minería que utilizan hardware especializado (ASICs) hace que la probabilidad de minar un bloque con hardware no especializado sea extremadamente baja.

    Hardware Especializado:
        Actualmente, la minería de Bitcoin se realiza casi exclusivamente con ASICs (Application-Specific Integrated Circuits), que son mucho más eficientes que las CPUs y GPUs convencionales.
        Bitcoin Core no está diseñado para trabajar directamente con este tipo de hardware especializado. Se requiere software de minería específico para controlar y optimizar el rendimiento de los ASICs.

    Eficiencia y Costos:
        El costo de la electricidad y el hardware hace que la minería con hardware no especializado sea financieramente inviable.
        Los pools de minería permiten a los mineros individuales unir fuerzas y compartir las recompensas, aumentando la probabilidad de obtener ingresos regulares.

Bitcoin Core y la Minería en la Actualidad

Bitcoin Core todavía tiene funcionalidades básicas de minería, pero estas no están optimizadas para la minería competitiva en la red actual de Bitcoin. Aquí hay algunas funciones relacionadas con la minería que Bitcoin Core puede realizar:

    Generación de Bloques:
        Bitcoin Core puede generar bloques y tiene las funciones necesarias para crear transacciones y bloques válidos.
        Sin embargo, la generación de bloques no es práctica sin el uso de hardware especializado.

    Nodo Completo:
        Bitcoin Core sigue siendo esencial como un nodo completo que valida y propaga transacciones y bloques.
        Los nodos completos son vitales para la seguridad y la descentralización de la red Bitcoin.

    Soporte para Pools de Minería:
        Mineros pueden configurar Bitcoin Core para trabajar con pools de minería, donde el trabajo se distribuye entre muchos mineros y las recompensas se comparten proporcionalmente.
        Esto se hace generalmente utilizando software de minería específico que se conecta al pool y comunica con Bitcoin Core.

Software Específico de Minería

Para la minería competitiva, se utiliza software especializado como:

    CGMiner
    BFGMiner
    BitMinter

Estos programas están diseñados para trabajar con hardware ASIC y optimizar el proceso de minería.
Conclusión

Bitcoin Core ya no es práctico para la minería en solitario debido a la alta dificultad de la red y la necesidad de hardware especializado. La minería efectiva de Bitcoin en la actualidad requiere el uso de software específico de minería y hardware ASIC, y generalmente se realiza en colaboración con pools de minería para aumentar la probabilidad de obtener recompensas. Bitcoin Core sigue siendo crucial como un nodo completo para la validación y propagación de transacciones y bloques, contribuyendo a la seguridad y descentralización de la red Bitcoin.






Heterogeneidad de la Red Bitcoin

La red Bitcoin es heterogénea debido a la variedad de roles y funciones que los diferentes nodos desempeñan. Esta heterogeneidad es beneficiosa por varias razones:

    Eficiencia:
        Cada tipo de nodo se especializa en tareas específicas, lo que maximiza la eficiencia general de la red.

    Descentralización:
        Al permitir que diferentes tipos de nodos participen, la red puede ser operada por una amplia gama de participantes, lo que aumenta la descentralización y la resistencia a censuras.

    Escalabilidad:
        La existencia de nodos ligeros permite que más usuarios participen en la red sin la necesidad de recursos computacionales y de almacenamiento significativos.

    Resiliencia:
        La diversidad de nodos contribuye a la resiliencia de la red, asegurando que incluso si algunos nodos fallan o son atacados, la red en su conjunto puede seguir funcionando de manera efectiva.

Conclusión

En resumen, la red Bitcoin es heterogénea, compuesta por diferentes tipos de nodos que cumplen funciones específicas. Esta estructura permite a la red ser eficiente, descentralizada, escalable y resiliente. Los nodos completos, nodos de minería, nodos de pools de minería y nodos ligeros colaboran para mantener la integridad y la seguridad de la red Bitcoin.










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
