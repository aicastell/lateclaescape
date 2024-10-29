---
title: Los hardware ID
date: 2024-01-13
image: /img/posts/la-tecla-esc.jpg
categories: [ "tecnología" ]
tags: [ ]
draft: true
featured: true
---

Una empresa que vende muchos productos. 

Todos tenemos claro que un identificador de ha


Q1: ¿Qué elementos debemos considerar para identificar a los equipos de manera única?

Como mínimo, estos:

    - producto: raption/ccl2/enext
    - pantallas
        - cantidad (0 o 1)
        - tipo de pantalla (7 pulgadas, 15 pulgadas, lcd, ...)
    - placas de nodos
        - cantidad
        - tipo
    - placas de modo4
        - cantidad
        - tipo
    - placas de modo3
        - cantidad
        - tipo
    - placas de secc
        - cantidad
        - tipo (iotecha, akka, etc)

La idea es que los equipos que compartan las características de esta lista anterior, tengan el mismo hardware-id.

Q2: ¿Que formato tendrá el hardware-id?

Tenemos dos opciones:

    1.- Usar un identificar genérico que no codifique ninguna información (un entero + 1 para generar una clave nueva única)
    2.- Una clave compuesta por distintos componentes que identifiquen al equipo

Ventajas del esquema 1:
    - Facilita la generación de claves nuevas (entero + 1)
    - Nunca tendremos que cambiar su formato 

Ventajas del esquema 2:
    - Es más visual, de un vistazo ya tienes una idea de que equipo es
    - Puede requerir modificaciones futuras si se incorporan en el futuro elementos identificadores en los equipos no contemplados inicialmente

Personalmente prefiero el 1.

Q3: ¿Quién setea el hardware-id al equipo?

Tenemos dos posibilidades:

    1.- Automático (el equipo cuando arranca hace un escaneo de los elementos identificadores y averigua por sí mismo su hardware-id).
    2.- Manual (alguien tiene que setear el hardware-id en algún momento).

Personalmente prefiero el 1. El 2 es propenso a errores humanos.
Pero necesitamos poder identificar todos los elementos de la lista Q1 en el arranque de forma automática, de alguna maner.
Si no es posible 1, no tenemos mas remedio que optar por la opción 2.

Q4: ¿Que componentes del sistema van a usar el hardware-id?

Dado el hardware-id:

    - El secc-upgrader podrá saber que SECCS tiene que actualizar y saber cuando ha finalizado su trabajo
    - El devupgrader podrá saber que placas de nodos/modo3/modo4 tiene que actualizar
    - El pwrstudio lo utiliza en su mapa defaults.xcfg (no conozco suficiente el código de motor para saber mas detalles)
    - El SVF podrá saber que sistema tiene que verificar
    - Probablemente mas que desconozco

Q5: ¿Como vamos a guardar toda esta información?

La lista de componentes que identifican a cada hardware-id, debe guardarse en alguna base de datos. Posibilidades:

    - En uno o varios XML
    - En uno o varios JSON
    - En una base de datos relacional (SQL)
    - En una base de datos no relacional (Mongo)

Q6: ¿Como acceden los componentes del equipo a esa información?

Los componentes del equipo van a necesitar acceder a esa base de datos elegida en Q5.
Opciones:

    1. Accesible a través del cloud (internet)
    2. Accesible en local (instalada en el rootfs de Linux)

La alternativa 1 necesita tener conectividad con internet. Si no entiendo yo mal, el equipo debería poder funcionar sin ella. Por tanto no se puede aplicar.

La alternativa 2 tiene dos variantes:

    a. Disponer de toda la base de datos en el rootfs
    b. Disponer en el rootfs solamente de la versión que corresponda al harware-id del equipo

Para la alternativa 2b tendríamos que aprovisionar la configuración en algún momento antes de salir a producción. Si el equipo cambia su hardware-id en producción, tendríamos que volver a aprovisionar la configuración especifica para su nuevo hardware-id. Por eso no me gusta.

Personalmente prefiero la opción 2a, y que el equipo tenga todo de forma autónoma para funcionar sin conexión a internet.

Q7: ¿Como se mantiene actualizada esta información?

Posibilidades hay muchas, pero estaría bien tener un front-end web que permita añadir/modificar/borrar tanto los elementos que componen los hardware-ids, como los propios hardware-ids. 
Y que el resultado de todo ese trabajo se almacene en la base de datos de Q5.
Esa base de datos de Q5 debería ser el INPUT para que los equipos puedan acceder a ella Q6. 


