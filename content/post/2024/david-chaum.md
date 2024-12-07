---
title: David Lee Chaum
date: 2024-05-11
image: "/img/posts/david-chaum.webp"
categories: [ "cypherpunk", "bitcoin", "criptomonedas" ]
tags: [ "mix_network", "blind_signature", "e-Cash", "DigiCash", "xx-network" ]
draft: false
featured: true
---

# David Lee Chaum

En este articulo voy a hablar de David Lee Chaum, conocido mundialmente por ser el inventor del dinero digital y de los pagos online anónimos.

## Educación

[David Chaum](https://www.linkedin.com/in/david-chaum-43a555180/) nace el 10 de Octubre de 1955 en Nueva York, en el seno de una familia textil adinerada.

Crece en Washington D.C. y asiste a la [Sidwell Friends School](https://www.sidwell.edu/), una prestigiosa escuela privada.

Desde muy temprano, Chaum siente especial fascinación por la criptografía, a través de la cual pretende hacer de este mundo un lugar mejor. Por ello decide estudiar ciencias de la computación en el [California Institute of Technology](https://www.caltech.edu/) (CalTech).

En 1982 obtiene su doctorado en la prestigiosa [Universidad de California Berkeley](https://www.berkeley.edu/).

Al terminar su Ph.D, empieza a trabajar como científico investigador en el [centro de investigación Thomas J. Watson](https://research.ibm.com/labs/yorktown-heights) en Nueva York, la sede global de IBM Research, la organización dedicada a la investigación industrial mas grande del mundo.

En 1983 Chaum funda la [International Association for Cryptologic Research](https://iacr.org/) donde se organizan conferencias sobre investigación académica en criptografía y criptología.

En 1984 se muda a Amsterdam, donde funda un grupo de investigación criptográfica dentro del [Centrum Wiskunde & Informatica](https://www.cwi.nl).

A estas alturas, sus colegas de profesión ya le consideran como uno de los cinco mejores expertos en criptografía del mundo.

## Publicaciones

Chaum es autor de numerosos artículos científicos donde ha presentado ideas innovadoras que han ayudado a dar forma al panorama de las criptomonedas y le han posicionado como una autoridad en el campo.

En 1979, durante sus estudios de doctorado, Chaum publica el paper [Computer Systems Established, Maintained, and Trusted by Mutually Suspicious Groups](https://chaum.com/wp-content/uploads/2022/02/techrep.pdf). Aquí sienta las bases para establecer una red de nodos de confianza completamente descentralizada, donde ningún nodo de la red debe confiar en un sistema central.

En este trabajo, Chaum ya introduce casi todos los conceptos de blockchain que se encuentran actualmente en Bitcoin, excepto la Prueba de trabajo (POW). Su trabajo posibilita hacer transacciones de monedas digitales entre personas, sin la necesidad de una autoridad central como un banco.

En 1981, aún sin terminar su doctorado, Chaum publica el paper [Untraceable Electronic Mail, Return Addresses and Digital Pseudonums](https://dl.acm.org/doi/pdf/10.1145/358549.358563). Aquí presenta el concepto de **Mix Network**, que permite ocultar los metadatos del emisor de una comunicación digital, lo que sienta las bases para desarrollar una tecnología que permita preservar la privacidad total en las comunicaciones digitales.

Aplicado a los email, por ejemplo, permite ocultar la dirección de correo del remitente, y proporciona una dirección de correo anónima a la cual se puede enviar la respuesta. Aplicaciones basadas en este concepto incluyen remailers anónimos como MixMaster, el Proyecto Tor y algunas criptomonedas como Monero (XMR) o ZCash (ZEC).

En 1983, publica el paper [Blind signatures for Untraceable Payments](http://www.hit.bme.hu/~buttyan/courses/BMEVIHIM219/2009/Chaum.BlindSigForPayment.1982.PDF). Aquí presenta el protocolo de **firma digital ciega** o **blind signature**. Este protocolo criptográfico permite que un usuario pueda enviar documentos a una entidad firmante (como una [Autoridad Certificadora](/post/2024/certificados-digitales)), para que sean firmados digitalmente, sin que el usuario tenga que revelar el contenido de los documentos firmados.

La principal motivación es que, cada vez que se llama por teléfono, cada vez que se compra un producto usando una tarjeta de crédito, cada vez que se subscribe a una revista o cada vez que se paga algún impuesto, el cliente tiene que revelar información personal que termina en alguna base de datos que permite a los bancos o al gobierno rastrear los pagos personales realizados en linea, lo que transgrede el derecho fundamental a la privacidad de los usuarios.

En 1985, en su articulo [Security without Identification: Transaction Systems to Make Big Brother Obsolete](https://www.cs.ru.nl/~jhh/pub/secsem/chaum1985bigbrother.pdf), Chaum propone **e-Cash**, una moneda digital novedosa que proporciona a los usuarios completa privacidad y anonimato. Utilizando las **blind signatures** consigue garantizar que las transacciones son seguras y privadas, y no puedan ser rastreadas hasta su origen.

Su lista de publicaciones es interminable. Chaum posee [mas de 50 patentes](https://patents.justia.com/inventor/david-chaum) concedidas por el gobierno de los Estados Unidos. Esto le ha convertido en uno de los activistas mas reconocidos dentro del movimiento **cypherpunk**.

## La empresa DigiCash

El sueño de Chaum es acabar con el dinero en efectivo. Es demasiado caro, engorroso y anticuado. Pretende diseñar una moneda digital que proporcione niveles de privacidad y anonimato sin precedentes, que replique las características del dinero en efectivo en el mundo físico, que permita transacciones directas entre las partes sin necesidad de intermediarios, y al mismo tiempo, resuelva el problema del doble gasto.

En 1989, cuando la mayoría de los mortales ni siquiera ha escuchado hablar de Internet, Chaum funda [DigiCash Inc.](https://www.digi.cash/), una compañía con sede central en el [Amsterdam Science Park](https://www.amsterdamsciencepark.nl/) que pretende explotar las capacidades de **e-Cash** a nivel empresarial.

Los usuarios del sistema DigiCash crean una cuenta digital en la que pueden depositar dinero FIAT desde su cuenta bancaria. Luego pueden utilizar esa cuenta digital para realizar pagos online de forma segura y anónima, sin revelar su identidad o el monto de la transacción a terceros, protegiendo así su privacidad financiera. Esto representa un avance significativo en comparación con los sistemas financieros tradicionales, que a menudo requieren divulgar información personal y financiera sensible.

Digicash también aborda el problema del doble gasto utilizando un sistema de billetes digitales firmados por una autoridad central. Estos billetes digitales son únicos y por tanto no pueden ser duplicados, lo que garantiza la integridad de la transacción. Sin embargo, esta autoridad central es el punto débil del sistema, ya que atacar dicho servidor y hacerse con su control puede exponer a todos los usuarios de e-Cash.

El ya desaparecido banco Mark Twain de los Estados Unidos es el primero en experimentar con e-Cash. Mas tarde, otros siete bancos siguen su ejemplo, incluidos grandes actores como el [Deutsche Bank](https://www.deutsche-bank.es/) y [Credit Suisse](https://www.credit-suisse.com).

### Desafíos de DigiCash

A pesar de sus innovaciones y su visión revolucionaria, Digicash enfrentó una serie de desafíos para la adopción masiva de e-Cash.

El principal obstáculo es la falta de adopción generalizada del comercio electrónico en Internet en la década de 1980-1990.

Por un lado, los bancos. Son conservadores por naturaleza. Se asocian con DigiCash principalmente por no quedar rezagados, no porque quieran desempeñar un papel de vanguardia implantando esta nueva tecnología. El comercio electrónico está dominado por las tarjetas de crédito. Y con esto los bancos ya ganan suficiente dinero.

Por otro lado, los consumidores. Hay conformidad con la situación existente. No le dan demasiada importancia al anonimato. En su percepción, el riesgo de fraude con las tarjetas de crédito es bajo. Si algo sale mal, no son ellos quienes asumen el riesgo, sino las compañías de tarjetas de crédito.

Por lo tanto, se establece un punto muerto. Los bancos proceden con calma. Y los consumidores no ven beneficios relevantes.

A mediados de 1998, la situación es desesperada. Los altos salarios consumen las reservas mientras apenas se generan ingresos. Digicash finalmente se ve obligada a declararse en quiebra en 1998.

Un destino triste para un pionero en una tecnología digital que estaba avanzado a su tiempo.

Aunque e-Cash nunca llegó a alcanzar una adopción generalizada, fue una innovación revolucionaria que demostró el potencial de las criptomonedas para proporcionar a los usuarios privacidad y anonimato.

## Entrevista

Eres el padre fundador del dinero digital. ¿Qué te llevó a esa idea?

> Nuevas formas de comunicación y conexión a menudo requieren nuevas formas de entender el dinero. Hace unos cientos de años, el dinero en efectivo era una innovación, necesaria porque no querías cargar tu tesoro de oro a todas partes. De manera similar, una vez que tienes bancos y sucursales y redes, obtendrás cheques y eventualmente tarjetas de crédito. Me pareció obvio que Internet, que empodera a las personas en todas partes para conectarse y comunicarse entre sí, necesitaría su propia moneda.

¿Consideras que la blockchain está yendo en la dirección correcta con Bitcoin?

> No estoy seguro de que la blockchain esté yendo en una sola dirección. Todos los días se están introduciendo nuevos enfoques y nuevas tecnologías. El crecimiento de la blockchain ha superado al de Bitcoin. Dicho esto, son innegables las limitaciones de Bitcoin, especialmente en cuanto a la velocidad de cálculo y el gasto de energía.

¿Puede una moneda digital de suministro limitado, como Bitcoin, jugar alguna vez un papel significativo en la economía?

> Bitcoin ha lanzado un movimiento mundial y ha atraído a millones de personas a la promesa y la importancia de la moneda digital. Eso es un logro maravilloso. Me emociona encontrar constantemente, en mis viajes por el mundo, personas animadas por las preocupaciones que planteé por primera vez hace muchos años sobre la importancia de la privacidad y seguridad digital.

¿Crees que ya es posible sentar las bases para protocolos de criptografía que sean a prueba de computadoras cuánticas?

> La blockchain tiene una capacidad única para descentralizar el poder, y es esencial que no cedamos la 'supremacía cuántica' a Google o a quienquiera que tenga la computadora más rápida. Ya estamos trabajando en la construcción de un protocolo resistente a computadores cuánticos. ¿Crecerá, evolucionará y cambiará? Por supuesto que sí, pero las bases ya están aquí.

## La empresa Elixxir

David Chaum sigue en activo en el mundo de las criptomonedas. Su trabajo no debería pasar desapercibido para nadie. Actualmente es el CEO de la empresa [Elixxir.io](https://xx.network/).

Su empresa ha desarrollado la red XX. Esta red implementa la primera blockchain segura ante ataques de computación cuantica. Usando esta blockchain se pueden ocultar los metadatos de las comunicaciones, ofreciendo una plataforma de mensajería y pagos segura, descentralizada, escalable y totalmente privada.

## Despedida

La introducción global de Internet de alta velocidad ha permitido que las redes sociales y las aplicaciones móviles transformen la manera en que nos comunicamos e intercambiamos valor. Sin embargo, las empresas que han liderado esta transformación han demostrado estar poco dispuestas a proteger la privacidad de los usuarios, y en su lugar, han priorizado maximizar sus beneficios explotando la publicidad.

![Collected information social networks](/img/collect-info-socialnets.webp)

En este articulo has aprendido que el trabajo de David Lee Chaum ha sido fundamental para proteger la privacidad de las personas. Con su tecnología, no hay forma de que ningún tercero, incluidos gobiernos, empresas tecnológicas o la propia red, pueda ver información sobre el remitente o destinatarios de comunicaciones o pagos.

Ademas, su contribución ha sido determinante en el desarrollo de Bitcoin y otras muchas criptomonedas que se han desarrollado después.

La aplicación Twitter ha pasado a llamarse "X" tras la adquisición de la compañía por parte de Elon Musk. El propio Musk ha afirmado en distintas entrevistas que quiere integrar en X un sistema financiero mas eficiente, seguro y anónimo que la banca tradicional. Tendría mucho sentido que la red XX de Chaum fuera la plataforma elegida por Musk para implementar este sistema financiero. ¿Que pensáis sobre ello?

Espero que este contenido os resulte interesante. Como siempre, estaré atento a vuestros comentarios en el [canal de Telegram](https://t.me/lateclaescape).

Gracias por leerme y nos vemos en el siguiente articulo.

Pulso la tecla ESC, dos puntos wq!
