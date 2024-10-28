---
title: Sistemas de voto electronico
date: 2024-02-23
image: /img/posts/david-chaum.webp
categories: [ ]
tags: [ ]
draft: true
featured: true
---

Las firmas digitales pueden desempeñar un papel crucial en el contexto de un sistema de votos electrónicos al proporcionar autenticación, integridad y no repudio, garantizando así la seguridad y la confianza en el proceso de votación. Aquí hay algunas formas en que las firmas digitales pueden ser útiles en un sistema de votos electrónicos:

Autenticación del votante: Las firmas digitales pueden utilizarse para autenticar la identidad de los votantes. Cada votante podría tener una clave privada única asociada a su identidad, y al firmar digitalmente su voto con esta clave, se puede verificar su identidad de manera segura.

Integridad del voto: Las firmas digitales garantizan que el voto no haya sido alterado durante la transmisión o almacenamiento. Cada voto firmado digitalmente incluiría una firma única que se puede verificar para asegurar que el voto no haya sido modificado desde que fue emitido.

No repudio: Las firmas digitales proporcionan una forma de asegurar que un votante no pueda negar haber emitido un voto específico. Al firmar digitalmente su voto, un votante no puede negar su participación en el proceso de votación.

Verificación de la integridad del sistema: Las autoridades electorales y los supervisores pueden utilizar firmas digitales para verificar la integridad del sistema de votación en su conjunto, garantizando que no se haya manipulado el software o los datos relacionados con la votación.

Seguimiento de la cadena de custodia: Las firmas digitales pueden utilizarse para rastrear la cadena de custodia de los votos, desde el momento en que se emiten hasta el momento en que se cuentan y se registran. Cada etapa del proceso de votación podría ser firmada digitalmente para garantizar su autenticidad e integridad.

Es importante destacar que, si bien las firmas digitales pueden mejorar la seguridad y la confianza en un sistema de votos electrónicos, también plantean desafíos en términos de privacidad, accesibilidad y garantías de que el proceso de votación sea justo y equitativo para todos los votantes. Por lo tanto, cualquier implementación de un sistema de votos electrónicos debe abordar estos desafíos de manera integral para garantizar la integridad y la legitimidad del proceso electoral.




https://github.com/kvas-it/votegrity/issues

https://gist.github.com/colindean/5239812


https://www.youtube.com/watch?v=izddjAp_N4I


https://www.ted.com/talks/david_bismark_e_voting_without_fraud/transcript?source=facebook&language=es


Blockchain & voting
https://www.youtube.com/watch?reload=9&v=d0iLN8LDJ8g&feature=youtu.be



Why blockchain voting is critical?

https://www.youtube.com/watch?v=B94Jqhkxt3Y&feature=youtu.be



https://www.youtube.com/watch?v=whIftEWs6_A&feature=youtu.be



https://www.youtube.com/watch?v=KpvVqa-O_Tg&feature=youtu.be



https://www.youtube.com/watch?v=7TRRKk-VH3o&feature=youtu.be




https://www.youtube.com/watch?v=abQCqIbBBeM





Indice =====

Introducción

Elecciones por el metodo actual
    - Inconvenientes
        - Atentan contra la democracia
            * Software centralizado y privado
        - Otros inconvenientes
    - Reflexión para mejorar

Sistema electronico de voto
    - Ventajas
    - Inconvenientes
    - Empresas

Herramientas necesarias para montar sistema electronico de voto
    - SHA-256 hash
    - Public/Private criptography
    - Certificados digitales
    - Blockchain

Explicacion tecnica de un sistema electronico de voto
    - 

Conclusiones
    - Debemos esperar








Blockchain al servicio de la democracia ======================================

Introducción =====

Hay pocas cosas que nos unan tanto como unas elecciones. 

Todos salimos de casa el mismo día para ir a votar. Acudimos a los centros
electorales. Votamos. Y luego seguimos atentamente los resultados desde
nuestras casas. 

Nuestras democracias se basan en las elecciones. Todos entendemos por qué
tenemos elecciones. Apreciamos la oportunidad de dar nuestra opinión para
ayudar a decidir el futuro de nuestro país.

La idea fundamental es que a los políticos se les concede el mandato para
hablar por nosotros, para tomar decisiones en nuestro nombre que nos afectan a
todos. Sin ese mandato, serían unos dictadores.



La corrupción =====

Aunque la idea de la elección es perfecta, una elección nacional es un
proyecto grande, y los proyectos grandes son complicados.

Pero lamentablemente, el poder corrompe por eso la gente hace muchas cosas para
llegar al poder y mantenerlo. Incluso cosas malas en las elecciones.

Cada vez que hay una elección, parece que algo siempre sale mal: alguien trata
de hacer trampa, se pierde una urna por aquí, aparece un voto por allá...




El protocolo actual =====

Estos son los elementos de unas elecciones:

    * Los votantes. A traves del Censo Electoral, se define la lista de personas fisicas con derecho a voto: personas mayores de edad en posesión de un Documento Nacional de Identidad (DNI).
    * Los candidatos. Las personas fisicas que sean titulares del derecho de sufragio pasivo, y por tanto en posesión del derecho a ser elegidos como candidatos de un proceso electoral. Se hace otra lista.
    * Los votos. El votante elige uno de los candidatos de la lista de candidatos y lo deposita en un sobre opaco donde se preserva el secreto del voto.
    * Las urnas. Es el lugar donde se depositan los sobres con el voto de cada uno de los votantes.
    * La base de datos. Es el sistema de información en el que se lleva la cuenta de los votos que ha recibido cada candidato.


Este es el procedimiento:

    1. El votante se dirige a la mesa electoral asignada
    2. El votante entra en la sala de votación.
    3. El votante elige de forma completamente privada un candidato y lo mete dentro de un sobre opaco.
    4. El votante se dirige con su voto hasta la mesa electoral asignada
    5. El presidente de mesa pide al votante que se identifique mostrando su DNI
    6. Una vez identificado, el presidente tacha el votante de la lista de votantes para que no pueda votar una segunda vez.
    7. Despues el presidente concede permiso al votante para votar.
    8. El votante deposita el sobre con su voto en la urna. Allí se mezcla con todos los demas votos de modo que nadie sbrá cual ha sido nuestro voto.

Tras este proceso, volvemos a casa confiados en que el sistema electoral funciona y las autoridades de la mesa harán bien su trabajo.

Sin embargo, tras cerrar los colegios electorales, ocurren aún muchas cosas:

1. Las urnas se llevan precintadas a los lugares de escrutinio.
2. Allí se les quita el precinto.
3. Se extraen los votos de la urna y se cuentan laboriosa y escrupulosamente, a mano, uno a uno
4. El proceso de cuenteo es supervisado por interventores de los distintos partidos políticos que se encargan de velar por que el recuento se realice correctamente. Cualquier ciudadano puede asistir a ese proceso.
4. El recuento final se plasma en un Acta Oficial firmada por el presidente, los vocales y los distintos interventores.
5. Del Acta Oficial se hacen 3 copias:
    * la primera se entregará en el Juzgado de Primera Instancia más cercano
    * la segunda se entregará a un empleado de Correos (que la llevará a la Junta Electoral Central)
    * la tercera se entrega a un representante de la Administración.
6. Un representante de la Administración transfiere los resultados de esa mesa electoral al sistema informático central, utilizando un PDA.
7. El sistema informático central se encarga de recopilar los datos de los distintos colegios electorales, y ofrecer el escritinio global en tiempo real.







** Por más profesional que seas, no conoces el sistema electoral español. en este sistema todos los actores se llevan copias de las actas de cada mesa, las que además se exhiben en la puerta de cada centro de votación.
Cada mesa genera además tres sobres con los resultados. Los sobres 1 y 2 los llevan dos de las autoridades de cada mesa, con escolta policial, al juez local. Este juez en 10 horas lleva el Sobre 1 a la junta electoral. El sobre 2 queda en el juzgado. El tercer sobre se envia por Correos desde la mesa a la junta electoeal. Cinco días más tarde, en acto público se abren los sobres y se realiza el escrutinio definitivo.
Indra sólo participa en el provisorio y como todos los partidos tienen copias de las actas verifican que coincida con Indra en paralelo. Mucha gente de todos los partidos trabaja esa noche tanto o más que Indra. En España el único fraude posible se da con trucos durante la votación y el escrutinio en la propia mesa. Puesto que es distribuido es dificil un fraude masivo más allá de algunos votos pícaros aquí o allá.








Puntos de fallo del sistema actual =====

Vamos a enumerar los puntos de fallo que presenta el sistema electoral actual:

Primero, el representante de la Administración que introduce los datos en un PDA no es un funcionario público. Es un trabajador externo contratado específicamente para introducir los datos en un PDA y transferirlos al sistema informático central. Normalmente la empresa que contrata la administración para realizar este proceso es Indra. Hablaremos después sobre esta empresa. La pregunta aqui es si alguien comprueba que los datos que introduce el trabajador de Indra en la PDA se corresponden con los datos reales del Acta Oficial de la votación. Y la respuesta es que no, nadie lo hace.

Segundo, el software que corre en todos los elementos del sistema informático debería ser auditable, para poder analizar lo que hace y verificar que los programadores que han desarrollado su código no están haciendo trampas, por ejemplo, sumando votos a unos candidatos y restando votos a otros. De esta manera, tanto el software que corre dentro de las PDA, como el software que corre en el servidor central que recibe los datos de los distintos PDA's deberian ser publicos en pro de la transparencia, para su análisis por la comunidad de científicos. Sin embargo, el código fuente de estos sistemas propiedad de la empresa Indra se guarda en el mas absoluto secreto. Por lo tanto, tenemos que confiar en el buen hacer de esta empresa para creernos el resultado de las elecciones.

Tercero, la propia base de datos que guarda los contadores de cada candidato debería ser inmutable. Es decir, una vez escritos los resultados, nadie debería poder editar ni modificar esos datos. Y no lo és. La base de datos es accesible por un número limitado de personas, que podría alterar los datos a su propio interés, sin que nadie lo supiera. De nuevo, tenemos que confiar en el buen hacer de los administradores de la base de datos de Indra para creernos el resultado de las elecciones.







La empresa Indra =====

¿Quien es la empresa Indra? Indra, Soluciones Tecnológicas de la Información, S.L.U. es una de las mayores empresas armamentísticas de España, siendo una de las tres empresas españolas que se encuentran entre las 100 mayores compañías mundiales del sector de defensa y seguridad. Es un gigante con muy buenas relaciones con el estado. Pertenece al IBEX 35 desde el 1 de julio de 1999. Esta empresa consiguió en 2016 unos ingresos de 2.709 millones de euros y cuenta con 34.000 empleados repartidos en 46 países y mantiene operaciones comerciales en más de 140 países. Esta empresa ha sido la encargada de la gestión de la mayoría de los procesos electorales desde la transición teniendo, prácticamente, el monopolio del sector excepto en 2015 cuando la empresa encargada fue la catalana Scytl.

Sin embargo, la reputación de esta compañia ha sido cuestionada en varias ocasiones:

    * En Sevilla, en 2015, el conteo de votos electrónicos de 44 mesas estuvo bloqueado durante varios días.
    * En 2010 en Barcelona el sistema falló en varias ocasiones antes, durante y después de una jornada electoral.

Y no solo en España. Indra también ha gestionado más de 400 recuentos provisionales en elecciones en el extranjero con varias sospechas de fraude. 

    * En 2015, en las elecciones de la República Dominicana, los resultados electorales fueron rechazados por toda la oposición acusando a la empresa de pucherazo.

Y no solo estamos hablando de escandalos electorales. En los últimos años ha salido a la luz de Indra estaba relacionada con varios casos de corrupción relacionados con el Partido Popular: Caso Púnica y Operación Lezo. La Guardia Civil descubrió que Indra utilizó empresas tapadera para financiar la Caja B del PP con 600.000€. Este dinero habría salido de adjudicaciones públicas infladas.






Otros problemas asociados al sistema de votación actual =====

A parte de los propios fallos de seguridad que ponen en peligro nuestra Democracia, existen otros problemas asociados al sistema actual de elecciones:

    * Proceso lento, el cuenteo manual puede llevar varias horas.
    * Proceso propenso a errores humanos.
    * Proceso económicamente caro, imprimir los votos supone practicamente el 50% del coste, requiere movilizar a muchas personas
    * Proceso poco accesible, para personas que el día de las votaciones se encuentran lejos de sus domicilios habituales (por trabajo, vacaciones, etc), o para personas con problemas de movilidad.
    * Proceso peligroso para la salud publica, en los tiempos de covid-19 que corren, muchas veces se forman colas en los colegios electorales.


Utilizamos los teléfonos móviles para cosas tan delicadas como comprar por internet, acceder a nuestras cuentas bancarias. Y confiamos en esos sistemas porque son seguros. ¿Por que no implementar una APP de movil que permita votar a todo el mundo de forma sencilla y confortable, desde el salón de nuestra propia casa?








Algunas soluciones propuestas =====

Se han propuesto algunas soluciones, pero no son suficientemente seguras. Hay unos cuantos retos que cumplir:

* Medidas de seguridad para evitar que el proceso pueda ser manipulado
* Evitar ataques de DoS
* Evitar que los servidores puedan ser manipulados por hackers
* Blockchain permite sistemas IVS (internet voting system) que sea inmutable, transparent y que no se pueda hackear para cambiar los resultados
* Blockain permite implementar este sistema
    - El primer paso debe ser validar la identidad del votante. Es muy importante que no se pueda falsear la identidad de los votantes, porque cada voto cuenta, cada voto importa
    - El votante debe descargar la aplicación para votar en su telefono movil, en su PC, etc
    - El votante debe enviar su identidad al sistema para que verifique que es un votante valido
    - El sistema informático debe comprobar en su base de datos si es un votante valido
    - Entonces toda la información del votante es añadida a la blockchain
    - Despues de verificar la identidad, se ejecuta un smart contract que emitirá un voto, para que el usuario pueda votar y enviar su voto a la urna virtual
    - El sistema de votaciones basado en blockchain asegura que un mismo usuario no vote varias veces.
    - Es imposible modificar un dato una vez insertado ya que los bloques dejarían de ser consistentes 
    - Al ser una base de datos publica, tu puedes verificicar a quien has votado, pero cualquiera puede ver a quien has votado
    - Otras ventajas:
        - accesibilidad (desde cualquier parte del mundo)
        - asequibilidad (muy barato, no hay necesidad de comprar servidores caros, ni gente contando votos a mano) 
        - velocidad (se conoce el total en tiempo real)

¿Como se hace esto?

Te bajas una APP oficial en tu smartphone, verificas tu identidad, y votas.

En un blockchain based voting system, cuando un votante vota, las estaciones de polling consultan the voter blockchain para asegurar que el votante no ha utilizado ya su voto.

Si el voto del usuario es valido, el polling station acepta su voto, y si es invalido, rechaza su voto.

De esta manera se aborda el problema de que una persona intente votar varias veces.


Despues de votar, el voto se convierte en una transacción y se almacena en la blockchain despues de ser encriptado.


Una vez introducido en la blockchain, el voto no se puede modificar debido a las caracteristicas innatas de la blockchain.



El votante tiene incluso la opción de imprimir un recibo de su voto.

A traves de la blockchain, un votante puede verificar que su voto ha sido insertado en el sistema, y contado.

El votante incluso puede auditar cada voto en la urna, y confirmar si los resultados son seguros.

Mientras se mantiene la privacidad de todos los votantes.

Con la blockchain, los resultados de las elecciones se pueden declarar inmediatamente tras cerrar los colegios electorales, sin ninguna posibilidad de que existan errores humanos.

La tecnologia blockchain permite a cualquier votante ejercer su derecho a voto desde cualquier parte del mundo. Simplemente necesita un telefono y una conexión a internet activa.

Es un proceso muchisimo mas barato




¿Estamos muy lejos de ver sistemas de votaciones como estos? Suiza lo ha hecho ya con elecciones municipales, despues declararon que fue un proceso mucho mas seguro y menos susceptible a manipulaciones que otros sistemas de votaciones usados en el pasado. Otro ejemplo Japon, lo mismo. No estamos lejos de adoptar blockchain para futuras elecciones.








El sistema actual esta basado en la confianza ciega =====

La mayoría tenemos que confiar en que nuestro voto sea contabilizado
correctamente, y tenemos que confiar que lo mismo suceda con todos los votos de
las elecciones de los millones de ciudadanos con derecho a voto en este país.

. Tenemos que confiar en mucha gente intermediaria, en muchos procedimientos propensos a errores humanos. 
Incluso tenemos que confiar en ordenadores que no podemos auditar.


veces tenemos que confiar en los ordenadores. Imaginen cientos de millones de
votantes emitiendo cientos de millones de votos, todos para ser contados
correctamente y todo lo que puede salir mal generando todos esos titulares
negativos. Y no se podemos evitar sentirnos agobiados por la idea de tratar de
mejorar las elecciones. 




¿Que cosas debe garantizar un sistema electoral? =====

Bueno, de cara a todas estos titulares negativos los investigadores han
recapacitado sobre cómo hacer las elecciones de manera diferente. Han tomado
distancias para tener una visión global. Y la visión global es ésta:

las elecciones deberían ser verificables. Los votantes deberían poder verificar
que sus votos fueron contados correctamente, sin violar el secreto electoral,
que es tan importante. Y esa es la parte difícil. ¿Cómo hacer un sistema
electoral totalmente verificable y al mismo tiempo mantener los votos en
absoluto secreto?

Pero la magia de las elecciones no se detiene ahí. En su lugar, queremos hacer
todo el proceso tan transparente que los medios de comunicación y los
observadores internacionales y cualquier persona que lo desee puede descargar
todos los datos y contarlos ellos mismos. Pueden comprobar que todos los votos
fueron contados correctamente. Pueden comprobar que los resultados anunciados
de las elecciones son los correctos. Y éstas son elecciones de la gente, para
la gente, por lo que el siguiente paso para nuestras democracias es que sean
transparentes y verificables. 



Una solución =====

Bien, la forma que hemos ideado utiliza ordenadores pero no depende de ellos. Y
el secreto es el formulario de votación. Si los miran de cerca se darán cuenta
de que la lista de candidatos está en un orden diferente en cada caso. Y eso
significa que, si uno marca sus opciones en una de ellas y luego elimina la
lista de candidatos la parte que queda no revelará para quién fue el voto. Y en
cada formulario de votación existe este valor cifrado en forma de código de
barras 2D a la derecha. Se usa un poco de criptografía, y es complicada, pero
lo que no es complicado es votar con uno de estos formularios. Podemos dejar la
criptografía a los ordenadores, y luego usar el papel como comprobante. 

Así es como se vota. Uno recibe un formulario de votación al azar, y luego
entra en la sala de votación, marca sus preferencias, y corta por el
troquelado. Y destruye la lista de candidatos. Y la parte que queda, la que
tiene las marcas, es el voto encriptado. La autoridad de la mesa escanea el
voto encriptado. Y como está encriptado puede ser enviado, almacenado, y
contado de forma centralizada y mostrado en un sitio web para que todos lo
vean, incluyendo Ud. Así que uno se lleva el voto cifrado a casa como recibo. Y
tras el cierre de las elecciones, uno puede verificar que su voto fue contado
comparando el recibo con el voto del sitio web. Y recuerden que el voto está
encriptado desde el momento en que abandonaron la sala de votación entonces, si
una autoridad electoral quiere averiguar cómo votaron no podrá hacerlo. Si el
gobierno quiere descubrir cómo votaron no va a poder. Ningún hacker puede
descifrarlo y descubrir cómo votaron. Ningún hacker puede descifrarlo y cambiar
su voto porque entonces no coincidirá con el recibo. Los votos no pueden
perderse porque de ser así no los encontrarían cuando los buscaran. 








WISHLIST
    * Cada votante vote una sola vez
    * Quiero poder registrar todos los votos de forma segura
    * Cada votante vote de forma secreta
    * Quiero poder contar los votos de forma fiable
    * Cada votante pueda comprobar si ha votado sin confiar en terceras personas
    * 









Beneficios de blockchain:
    * All encrypted ballots authenticated with the voter
    * Verifiable ballot anonymization
    * Verifiable ballot decryption standards
    * Proof of blockchain to validate all proceses
    * Voters can see their own ballot on the blockchain


Blockchain =
    confianza y transparencia son las cuestiones mas grandes que resuelve
    persistent, transparent, public
    sistema en el que puedes añadir nuevos datos pero no puedes modificar los existentes
    La seguridad consiste en un challenge que nadie por si solo puede resolver (calculo del hash)--> Nadie puede forzar a insertar nuevos datos sin resolver previamente el hash
    Imposible fraud, imposible alterar

    es una red de computadores distribuídos (descentralizado) y publicos que almacenan todos la misma copia de la base de datos
    en lugar de centralizar los datos en una sola base de datos, los tenemos repartidos en muchos ordenadores
    luego es validada por todos los ordenadores de la red.
    cada nueva transacción es sincronizada en todos los nodos de la red
    esta sincronizandose continuamente
    como sabemos que es segura? Utiliza criptografia para codificar todas las transacciones
    es un sistema contable
    en lugar de estar alojado por una sola compañia, esta alojado en todos los ordenadores de la red



La gente no debe confiar en una sola empresa para gestionar este tipo de sistemas. Naturaleza descentralizada.




Empresas:
https://www.agora.vote/technology
https://www.scytl.com/










Riesgos de un sistema electronico =====

    * Cliente
    * Canal
    * Servidor


Conectado a internet estamos en riesgo, pero usamos encriptación end-to-end, que consiste en que el emisor lo encripte y solo el receptor lo puede desencriptar, de forma que mientras el mensaje circula por internet, un hacker podría interceptar el mensaje pero no podría ni ver ni variar su contenido.

El software del servidor, podemos fiarnos de quien lo ha instalado. Vale, hagamos un ejercicio de confianza. Incluso confiando en quien ha instalado ese servidor, podemos estar seguros que los hacker no estan manipulando la base de datos y cambiando los datos para variar el resultado de las eleccciones? ¿De veras puede ser hackeado un servidor conectado en Interenet? Por supuesto que es posible. ¿Estamos hablando con el servidor correcto, o es un servidor fake con el que estamos hablando?


Y podemos estar seguros de la seguridad del cliente? Es decir, tu telefono o tu portatil o tu PC? El software te podria decir, ya has votado a tu candidato favorito! Y por debajo estar enviando un fake voto hacia el candidato que el software malicioso quiera. Puedes tener un virus que haga esto, o incluso un hacker que esté atacando tu propio dispositivo cliente el día de las elecciones.


Poodriamos hacer software que funcione bien durante la fase de test y falle intencionadamente el día de las votaciones? Por supuesto! Preguntad a la empresa Volkswageen que lo hizo durante decenas de años con el tema de emisiones!

Todos estos son los riesgos, y muchos de ellos no tienen respuesta.




Como se distribuyen las credenciales a los votantes de forma segura?



Se trabaja desde la comunidad de cientificos en implementar un protocolo de voto criptográfico que cumpla todas estas premisas.

    * Permitir que cada persona vote una sola vez
    * Registrar los votos de forma precisa
    * Contar los votos de forma precisa
    * El votante pueda estar seguro de que su voto se ha contado, sin tener que confiar en terceras personas (incluso si son trabajadores de la administración publica!)
    * Secreto de voto, nadie debe saber a quien ha votado un votante


Actualmente no se conoce ningún sistema que cumpla todas las premisas.







Sistema actual permite manipulaciones a pequeña escala, pero es muy dificil cambiar el resultado electoral añadiendo o quitando unos pocos votos de un buzón. Por contra, en un sistema electronico que fuera hackeado se podría cambiar millones de votos en unas decimas de segundo. Por tanto, la magnitid del fraude sería mucho mas grave.








Herramientas necesarias para montar sistema electronico de voto ==============


1. SHA-256 hash










2. Public/Private criptography




3. Certificados digitales




4. Blockchain

Fuentes:

https://www.youtube.com/watch?v=hEoYL5j0wYU






David Chaum en 1983, publico el paper [Blind signatures for Untraceable Payments](http://www.hit.bme.hu/~buttyan/courses/BMEVIHIM219/2009/Chaum.BlindSigForPayment.1982.PDF), donde presentó el protocolo del firma ciega o Blind signature. Este protocolo criptográfico permite que un usuario pueda enviar documentos a una entidad firmante (como una Autoridad Certificadora), para que sean firmados digitalmente, sin que usuario tenga que revelar el contenido de los documentos firmados. En un sistema de voto electrónico esto puede permitir que los votantes puedan firmar digitalmente sus votos de manera que sean autetnticados sin revelar el contenido de su voto. Lo que puede ayudar a prevenir fraude electoral y a su vez proteger la privacidad del votante.

