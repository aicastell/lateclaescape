---
title: Satoshi Nakamoto
date: 2024-05-30
image: /img/posts/satoshi-nakamoto.webp
categories: [ "cypherpunk", "criptomonedas", "bitcoin" ]
tags: [ "e-Cash" ]
draft: false
featured: true
---

# Introducción

Satoshi Nakamoto ha sido una figura rodeada de misterio desde la aparición de Bitcoin en 2009. Su identidad ha generado un sinfín de teorías y especulaciones, convirtiéndose en uno de los mayores enigmas de la era digital.

En este artículo, nos sumergimos en las pistas, las teorías más intrigantes y los posibles candidatos que se han propuesto a lo largo de los años, con el objetivo de arrojar luz sobre la verdadera identidad de Satoshi Nakamoto.

Si no te gusta leer, puedes escuchar este articulo en la plataforma [ivoox](https://go.ivoox.com/sq/2494222).

## Teorías populares

En el idioma japonés, la palabra *Nakamoto* puede traducirse por "base central" o "origen central". Y *Satoshi* en ese mismo idioma significa "inteligencia". Una teoría popular sostiene que la NSA, la CIA o alguna otra agencia de inteligencia podría estar detrás de la creación de Bitcoin.

Grandes corporaciones tecnológicas como *Google* o *Microsoft* podrían estar detrás de Bitcoin. Estas empresas tienen los recursos y el talento necesarios para desarrollar una tecnología tan avanzada y podrían haberlo hecho como un experimento interno que luego se lanzó al público.

Los bancos y las instituciones financieras son actores poderosos con gran influencia económica y política. Es comprensible que vean a Bitcoin como una amenaza a su monopolio sobre la emisión y el control del dinero. La protección del anonimato de Satoshi podría haber sido una medida de seguridad preventiva contra posibles represalias.

## Nombres propios

### Elon Musk

Ha habido especulaciones sobre si Elon Musk, el fundador de SpaceX y Tesla, podría ser Satoshi Nakamoto. A pesar de que Musk ha negado repetidamente estas afirmaciones, algunos creen que su conocimiento en tecnología, así como su capacidad para innovar en diversas áreas, lo convierten en un candidato plausible.

Sin embargo, sus proyectos suelen estar muy unidos a su personalidad. Su afán por el control lo inclina más hacia sistemas centralizados (como PayPal) que distribuidos. Su ego le hubiera llevado a publicar su nombre. Lo que lo descarta como candidato.

### Dorian Satoshi Nakamoto

En marzo de 2014, la periodista Leah McGrath Goodman identificó a un hombre japonés-americano que vive en California como Satoshi Nakamoto en un artículo de Newsweek. Se reveló que Nakamoto había trabajado en proyectos confidenciales de defensa y como ingeniero informático en empresas de tecnología e información financiera. Durante una breve entrevista, Nakamoto insinuó ser el fundador de Bitcoin, pero luego se retractó, afirmando que ya no estaba involucrado y que otros se encargaban de ello. Esto desencadenó un gran interés mediático, con reporteros esperando cerca de la casa de Dorian Nakamoto y siguiéndolo en coche. Sin embargo, durante una entrevista posterior, Dorian Nakamoto negó cualquier conexión con Bitcoin.

### Craig Steven Wright

En mayo de 2016, el informático australiano Craig Wright afirmó públicamente en su blog ser Satoshi Nakamoto. La BBC y The Economist anunciaron que algunos periodistas fueron testigos de cómo Wright firmaba un mensaje con la clave privada asociada a la primera transacción Bitcoin. Sin embargo, la comunidad Bitcoin demostró rápidamente que la prueba era inválida. Wright afirmó haber pagado el dominio bitcoin.org con su tarjeta de crédito, pero se descubrió que AnonymousSpeech permitía pagar por servicios de dominio sin importar el propietario. Wright inició acciones judiciales, pero en una sentencia de mayo de 2024, un juez concluyó que Wright había producido deliberadamente documentación falsa y había mentido repetidamente sobre su identidad como Satoshi Nakamoto.

## Base tecnológica

El trabajo pionero de Whitfield Diffie y Martin Hellman en 1976, con el intercambio de claves Diffie-Hellman, fue fundamental para la criptografía de clave pública.

La contribución de Ralph Merkle en 1979, con sus árboles de Merkle, fue fundamental para la integridad de la blockchain.

En 1980, [David Lee Chaum](https://www.lateclaescape.com/post/2024/david-chaum/) inventa el concepto de moneda digital con su sistema de dinero electrónico e-Cash, que ofrece privacidad y anonimato. Sin embargo, su sistema requiere de una autoridad central para la emisión y validación de transacciones. Por tanto, no resuelve el problema del doble gasto en un entorno descentralizado.

En 1997, [Adam Back](https://www.lateclaescape.com/post/2024/adam-back/) introduce la Prueba de Trabajo (POW) con su sistema Hashcash. POW se utiliza para mitigar el spam y los ataques de denegación de servicio (DoS) mediante la exigencia de un cálculo computacional costoso para cada operación. POW es un componente esencial de la minería en Bitcoin, pero por sí solo tampoco resuelve el problema del doble gasto.

En 2004, [Harold Thomas Finney](https://www.lateclaescape.com/post/2024/harold-finney/) con su sistema RPOW hace un intento de crear un sistema de dinero digital descentralizado basado en el trabajo de Adam Back. Es un avance significativo pero tampoco resuelve el problema del doble gasto en un entorno descentralizado.

## Blockchain distribuida

A pesar de todos los avances realizados, sigue faltando el componente que resuelva el problema del doble gasto sin depender de una autoridad central.

En su white paper, Satoshi presenta al mundo la pieza clave que resuelve este rompecabezas: una **blockchain distribuida** en una red P2P.

Esta blockchain actúa como un registro público e inmutable de todas las transacciones, donde cada bloque está enlazado al anterior mediante un hash criptográfico. La cadena más larga, respaldada por la mayoría de la potencia de cálculo de la red, se considera la versión verdadera.

Esta innovación permite que la red resista ataques y asegure la integridad de las transacciones sin necesidad de una autoridad central.

## El código fuente

El [nakamotoinstitute.org](https://satoshi.nakamotoinstitute.org/code/) conserva una copia exacta de las tres primeras versiones publicadas del código fuente de Bitcoin.

Analizar el código fuente es entrar en la cabeza del mismísimo Satoshi.

Las lineas de los ficheros fuente terminadas en \r\n indican que el entorno de desarrollo elegido fue Windows. El código esta escrito en lenguaje C++. En un principio esto debería indicar que es un programador que domina la orientación a objetos. Sin embargo, hay dos detalles que nos llaman la atención.

El primero es que, en el código fuente, se declara un puntero a carácter con el mensaje del bloque génesis:

```
// Genesis block
char* pszTimestamp = "The Times 03/Jan/2009 Chancellor on brink of second bailout for banks";
```

Un purista del lenguaje C++ hubiera utilizado la clase string de la librería estándar de C++ para declarar esta constante de tipo cadena. Sin embargo, la declaración de la variable *pszTimestamp* se hace usando un puntero a una cadena de caracteres terminada en nulo. Usar esta declaración es propio de un programador en C.

El segundo es que el código fuente no utiliza *cout*, la función nativa de C++ para printar cadenas. Utiliza la función *printf* en todas partes. Y esta función forma parte de la biblioteca estándar de C.

Estos dos detalles revelan que si bien el código se desarrolló en C++, el programador detrás del código se sentía mas cómodo utilizando el lenguaje C para ciertas cuestiones.

## Hechos consumados

Para crear Bitcoin, Satoshi inventa muy pocas cosas. Lo que hace es combinar de manera innovadora conceptos y técnicas ya existentes.

Por esto, afirmar que Bitcoin fue la invención de una sola persona sería faltar al respeto a todos los criptógrafos e ingenieros que pusieron las bases tecnológicas necesarias para su puesta en marcha. Por tanto, Satoshi Nakamoto debe ser sin duda el seudónimo utilizado por un grupo de personas que trabajaron de manera colaborativa.

Cualquiera de los comunes mortales habría publicado su nombre en busca de fama y notoriedad. Sin embargo, Satoshi sacrifica toda compensación personal para garantizar el éxito del proyecto. Conoce perfectamente la naturaleza del dinero. Tiene unas solidas convicciones sobre la privacidad y el anonimato. Probablemente viene del mundo académico, lo demuestra la redacción impecable de su white paper. Estos datos revelan que Satoshi tiene una vida acomodada. Y que no necesita dinero ni reconocimiento para vivir.

Por otro lado, Satoshi manifiesta una clara crítica hacia el sistema financiero tradicional. En la primera frase de su white paper, hace una referencia explícita a los problemas inherentes de los sistemas financieros. Esta crítica se reitera en el comentario incluido en el bloque génesis de Bitcoin. Es plausible que Satoshi haya experimentado alguna adversidad relacionada con el sistema financiero en el pasado, lo cual podría haber motivado su aparente deseo de transformar dicho sistema.

## Opinión personal

Lo que sigue es mi opinión personal. Entramos en el terreno de la pura especulación.

Chaum, considerado como el padre del dinero digital, tenia un sueño: crear una moneda digital que no dependa de ningún banco ni autoridad central.

En 1985 Chaum pone en marcha e-Cash, la primera criptomoneda conocida. Sin embargo, e-Cash fracasa a nivel comercial. Dos son los motivos de su fracaso:

1. e-Cash no es completamente distribuido. La dependencia de los bancos centrales y su falta de interés en adoptar tecnologías nuevas dificultan la adopción.
2. En los años 80-90, el comercio electrónico es residual, la gente no percibe la utilidad real de una tecnología adelantada a su tiempo.

La empresa DigiCash de Chaum termina en bancarrota. Y Chaum queda muy dolido con el sistema financiero tradicional. Pero no abandona su sueño.

A Chaum y a su criptomoneda e-Cash le faltan dos piezas clave. La primera la desarrolla Adam Back cuando en 1997 crea la prueba de trabajo (POW).

Finney, un ingeniero muy inteligente y reflexivo, trata de ordenar todas las piezas para crear una criptomoneda completamente descentralizada. En 2004 lo intenta sin éxito con RPOW. Pero su naturaleza curiosa le anima a seguir investigando.

Chaum y Finney nacen con un año de diferencia. Ambos provienen de entornos académicos. Han estudiado juntos en el [California Institute of Technology](https://www.caltech.edu/) (CalTech). Comparten aficiones, por lo que es muy probable que se conozcan y colaboren juntos. Ambos terminan dando con la pieza del rompecabezas que les faltaba para resolver el problema del doble gasto sin depender de una autoridad central: la blockchain distribuida.

En este momento, todas las piezas necesarias para montar Bitcoin están listas.

Chaum ya tiene experiencia lanzando tecnologías disruptivas que han terminado en fracaso por la falta de adopción generalizada. No está dispuesto a cometer dos veces el mismo error. Así que espera pacientemente la llegada del momento adecuado para su lanzamiento.

Mientras tanto, se desarrolla Bitcoin, con tiempo y sin prisas. Es probable que Finney aproveche este intervalo de tiempo para aprender C++ mientras desarrolla la primera versión.

El crash bancario mundial que provoca la Gran Recesión abre la ventana de oportunidad. La gente cambia su percepción sobre la banca tradicional. Ahora entienden que es peligrosa y buscarán alternativas que no dependan de los bancos tradicionales. Es el momento ideal para presentar el white paper al mundo. La adopción masiva y global esta vez si, está garantizada.

Ni Chaum ni Finney aparecen citados en el white paper de Satoshi. Ambos son dos criptógrafos respetados por sus trabajos. Ninguno necesita mayores méritos profesionales para alimentar su propio ego. Ambos comparten un objetivo mucho mas ambicioso. Que mejor manera de mantener su anonimato que no atribuirse ningún mérito. Sin embargo, si aparece referenciada la prueba de trabajo (POW) de Adam Back. Poniendo énfasis en la enorme importancia que tuvo su trabajo para el éxito del proyecto. Un merecido detalle que tuvieron con el criptógrafo británico.

Finney siempre ha alegado que él programaba en C y que no sabia programar en C++. Pero el código de Bitcoin fue escrito probablemente por un programador de C, que quiso ocultar su estilo, usando C++ para hacer el desarrollo, garantizando de esa manera su anonimato. No olvidemos que Finney fue la primera persona en recibir una transacción de Bitcoin. Esta transacción probablemente se la envió Chaum, testeando de esta manera el correcto funcionamiento del software.

Tras asegurar el éxito del proyecto, Satoshi desaparece del foro Bitcoin Talk sin dejar ni rastro. El código fuente está en buenas manos, mantenido por los miembros de la comunidad open source. Por fin Chaum ha completado su creación: el dinero digital completamente descentralizado, sin bancos.

La ultima pista que conecta a estos tres genios son las siglas **BTC** de Bitcoin:

- **B**ack
- **T**homas
- **C**haum

Tratándose de criptógrafos de este nivel, es difícil imaginar que esta sea otra mera casualidad.

## Despedida

Espero que hayáis disfrutado de este articulo tanto como yo he disfrutado al escribirlo. Dejadme los comentarios en el [canal de Telegram](https://t.me/lateclaescape) que pensáis sobre este asunto. ¿Le veis sentido a esta historia?.

En próximos artículos iniciaré un repaso a los temas mas técnicos de Bitcoin. Si tenéis ganas de aprender, estáis en el sitio correcto. ¡No os perdáis lo que está por venir!.

Muchas gracias por leerme y nos vemos en el próximo articulo.

Pulso la tecla ESC, dos puntos wq!

