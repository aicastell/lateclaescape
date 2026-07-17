---
title: GrapheneOS
date: 2026-06-10
image: /img/posts/grapheneos.webp
categories: [ "cybersecurity", "privacy" ]
tags: [ "smartphone", "GrapheneOS", "secure_boot", "Android" ]
draft: false 
featured: true
---

# Introducción

Durante años he utilizado Android como lo hace todo el mundo. Configurando mi cuenta de Google, instalando mis aplicaciones habituales y utilizando el teléfono sin darle demasiadas vueltas. Y siendo honestos, suele ser más que suficiente para el día a día.

Pero con el tiempo empecé a sentirme incómodo con su funcionamiento. Las aplicaciones de mi teléfono me mostraban publicidad relacionada con conversaciones que había tenido horas antes. Mi teléfono tenía varias aplicaciones que no podía borrar. Una simple calculadora necesitaba acceso al GPS o a Internet para hacer sumas y restas. Y lo que ya me reventó por completo: el fabricante dejó de darle soporte al móvil al poco tiempo de comprarlo.

Empecé a buscar alternativas. Lo hice durante bastante tiempo. Investigué teléfonos centrados en la privacidad, proyectos basados en Linux, sistemas alternativos a Android e incluso dispositivos más abiertos que permitieran mantener el software actualizado durante más tiempo. Pero todas las alternativas implicaban aceptar compromisos importantes: drivers genéricos que empeoran el rendimiento, problemas de compatibilidad, falta de aplicaciones, y, en general, una experiencia de usuario bastante pobre.

Fue precisamente durante esa búsqueda cuando descubrí **GrapheneOS**. Y empecé a buscar información sobre este sistema operativo. Cuanto más leía sobre el proyecto, más convencido estaba de haber encontrado lo que buscaba.

En este artículo voy a explicarte por qué **GrapheneOS** es diferente. Si crees que es un simple "Android sin Google" te recomiendo seguir leyendo hasta el final, porque la realidad es mucho más interesante.

# Qué es exactamente GrapheneOS

**GrapheneOS** es un sistema operativo de código abierto desarrollado a partir de Android Open Source Project (AOSP), la base sobre la que se construye Android. A nivel visual, resulta difícil distinguirlo de un de Android puro.

Sin embargo, la diferencia no está en la interfaz, sino en todo lo que ocurre por debajo. **GrapheneOS** ha sido diseñado con un objetivo muy claro: reforzar cuatro aspectos fundamentales de cualquier smartphone moderno:

- privacidad
- seguridad
- aislamiento entre aplicaciones
- control del usuario

Voy a analizar cada aspecto por separado.

## Privacidad

La privacidad en **GrapheneOS** no consiste únicamente en "quitar Google" ni en desaparecer de Internet. Si utilizas tus cuentas habituales, tu número de teléfono y los mismos servicios de siempre, seguirás siendo identificable.

**GrapheneOS** parte de una idea muy simple: conceder a cada aplicación únicamente los permisos que realmente necesita. Esto otorga al usuario un mayor control sobre los datos que salen del teléfono con destino a algún servidor de Internet.

![GrapheneOS privacidad](/img/grapheneos-privacidad.webp)

Esto es especialmente relevante porque muchas aplicaciones aparentemente inocuas recopilan más información de la que realmente necesitan. Una linterna, una calculadora o un lector de códigos QR, que técnicamente podrían funcionar sin conexión a Internet, establecen conexiones constantes con servidores externos para enviar estadísticas de uso, telemetría o información publicitaria.

Para evitar este tipo de situaciones, **GrapheneOS** proporciona herramientas muy potentes al usuario:

- Bloquear completamente el acceso a Internet de una aplicación
- Limitar acceso a sensores
- Limitar la recopilación silenciosa de telemetría
- Controlar cámara y micrófono
- Restringir acceso al portapapeles
- Reducir visibilidad entre aplicaciones
- Limitar actividad en segundo plano
- Dificultar que las aplicaciones puedan identificarse entre ellas
- Separar aplicaciones mediante perfiles independientes

Todo esto cambia la relación entre el usuario y su teléfono. En lugar de aceptar los permisos por defecto y confiar ciegamente en cada aplicación instalada, pasas a decidir de forma consciente qué puede hacer cada una de ellas.

## Seguridad

La seguridad es probablemente la parte más importante de **GrapheneOS**. A diferencia de muchas ROMs Android, **GrapheneOS** no busca reinventar la rueda ni añadir un interfaz de usuario llamativa, sin mas. Su objetivo es más simple: tomar la arquitectura de seguridad de Android y reforzarla donde exista margen de mejora.

![GrapheneOS seguridad](/img/grapheneos-seguridad.webp)

Para ello incorpora protecciones adicionales frente a vulnerabilidades de memoria, endurece el asignador de memoria mediante *hardened_malloc*, introduce restricciones sobre la creación y ejecución de procesos, aplica políticas SELinux más estrictas y amplía el control de permisos disponible para el usuario.

El objetivo es que, incluso cuando una aplicación vulnerable sea comprometida, avanzar desde ese punto hasta comprometer el resto del sistema siga siendo extremadamente difícil.

### SecureBoot

De poco serviría tener un sistema operativo muy seguro si un atacante pudiera modificar componentes críticos del arranque sin ser detectado. Por eso **GrapheneOS** aprovecha plenamente mecanismos como Android Verified Boot, la cadena criptográfica de confianza, la verificación de integridad durante el arranque y las funciones de seguridad respaldadas por hardware. Esto conecta directamente con el artículo sobre [SecureBoot](/post/2026/secure-boot) publicado hace unos días.

La idea es sencilla: cada etapa del arranque valida criptográficamente la siguiente antes de ejecutarla. Así, el dispositivo puede verificar que el firmware, el bootloader y el sistema operativo no han sido modificados. Si alguna pieza de esa cadena falla, el problema se detecta antes incluso de que **GrapheneOS** llegue a iniciarse.

Este es uno de los aspectos que más diferencia a **GrapheneOS** de muchas ROMs Android tradicionales. Algunos proyectos reducen la dependencia de Google, pero a costa de debilitar elementos fundamentales de seguridad: bootloaders menos seguros, pérdida de Verified Boot, políticas SELinux más permisivas, actualizaciones más lentas o cadenas de confianza incompletas.

**GrapheneOS** adopta el enfoque contrario. Su objetivo es mejorar la privacidad sin sacrificar seguridad, porque si no puedes confiar en la integridad del sistema, cualquier promesa de privacidad termina apoyada sobre una base demasiado frágil.

### Google pixel

Y precisamente aquí es donde entran en juego los dispositivos [Google Pixel](/post/2026/adios-xiaomi-redmi5plus-hola-pixel9a).

Una de las preguntas más habituales cuando alguien descubre **GrapheneOS** es por qué únicamente ofrece soporte oficial para teléfonos Pixel. La respuesta es simple: el proyecto depende de garantías de seguridad que muy pocos fabricantes Android ofrecen actualmente.

**GrapheneOS** no necesita únicamente un teléfono capaz de ejecutar Android. Necesita una plataforma que permita construir una cadena de confianza sólida desde el arranque hasta el propio sistema operativo. Y los Pixel destacan precisamente porque ofrecen una combinación difícil de encontrar en otros dispositivos:

- actualizaciones rápidas y mantenidas durante años
- soporte completo para Android Verified Boot
- bootloader relockable de forma segura
- hardware-backed keystore
- compatibilidad con los chips de seguridad Titan M y Titan M2

Los chip Titan son especialmente importantes porque protegen claves criptográficas, participan en la validación del arranque y refuerzan la cadena de confianza del dispositivo. Gracias a ellos, determinadas garantías de seguridad dependen también del hardware y no únicamente del software.

Por este motivo, **GrapheneOS** no busca ser compatible con el mayor número posible de dispositivos, sino ofrecer las máximas garantías de seguridad sobre una plataforma capaz de soportarlas. El resultado es una combinación poco habitual: un sistema operativo endurecido ejecutándose sobre un hardware diseñado con la seguridad como prioridad.

## Aislamiento entre aplicaciones

Uno de los aspectos más interesantes de **GrapheneOS** es cómo gestiona el aislamiento entre aplicaciones.

Para entender qué aporta **GrapheneOS**, primero hay que reconocer algo importante: Android ya tiene uno de los modelos de aislamiento más sólidos del mercado. Cada aplicación se ejecuta con su propio identificador de usuario Linux (UID), dispone de almacenamiento independiente, mantiene sus propios permisos y está sometida a las restricciones impuestas por SELinux. En condiciones normales, una aplicación no puede acceder a los datos de otra ni interactuar libremente con el sistema.

Entonces, si Android ya hace todo esto, ¿qué aporta **GrapheneOS**?

![GrapheneOS aislamiento entre apps](/img/grapheneos-aislamiento-apps.webp)

La mayoría de ataques modernos no buscan comprometer directamente el sistema operativo. Lo habitual es comenzar explotando una aplicación vulnerable e intentar utilizarla como punto de entrada para escalar hasta tener el control del resto del dispositivo.

La filosofía de **GrapheneOS** consiste en asumir que cualquier aplicación puede ser vulnerable. Por eso endurece el modelo de aislamiento de Android mediante políticas más restrictivas, controles de permisos más granulares, limitaciones adicionales sobre lo que las aplicaciones pueden hacer y una reducción sistemática de los privilegios disponibles.

Cuanto más difícil resulte escapar de su entorno aislado, más complicado será para un atacante utilizar una vulnerabilidad para tomar el control total del dispositivo.

### Los perfiles de usuario

Esta misma filosofía se extiende a una de las funciones más potentes de **GrapheneOS**: los perfiles de usuario.

Cada perfil funciona como un entorno prácticamente independiente, con sus propias aplicaciones, almacenamiento, permisos, procesos y claves de cifrado. En la práctica, es como tener varios teléfonos dentro del mismo dispositivo.

Esto permite separar contextos de uso de forma muy efectiva. Por ejemplo, puedes mantener un perfil personal para tus datos privados, un perfil bancario para aplicaciones financieras o un perfil de trabajo con herramientas corporativas.

La ventaja es que los perfiles no comparten automáticamente aplicaciones, datos ni permisos. Si una aplicación queda confinada a un perfil concreto, también quedan confinados sus riesgos potenciales.

No se trata de virtualización completa como la que ofrece [Qubes OS](https://www.qubes-os.org/), ni de contenedores tradicionales al estilo [Docker](/post//2024/herramienta-docker). Sin embargo, los perfiles de usuario proporcionan un nivel de aislamiento sorprendentemente potente para un dispositivo móvil. Y una vez te acostumbras a separar contextos de esta forma, resulta difícil volver a la idea de que todas tus aplicaciones y datos deban convivir en un único espacio compartido.

## Control del usuario

En Android convencional es habitual aceptar permisos por inercia, utilizar servicios preinstalados sin cuestionarlos y asumir que determinadas aplicaciones necesitan privilegios especiales para funcionar.

En cambio, **GrapheneOS** plantea una relación muy distinta con el dispositivo. En lugar de ocultar decisiones importantes detrás de procesos automatizados, devuelve al usuario el control sobre aspectos que normalmente permanecen fuera de su alcance: qué aplicaciones pueden acceder a Internet, qué permisos reciben, qué servicios pueden ejecutarse en segundo plano o qué información pueden consultar del sistema.

![GrapheneOS control](/img/grapheneos-control.webp)

Esta filosofía se aprecia perfectamente en una de las características más interesantes del proyecto: **Sandboxed Google Play**.

En un teléfono Android convencional, Google Play Services forma parte de la infraestructura del sistema y dispone de privilegios especiales. Muchas aplicaciones dependen de él para recibir notificaciones, acceder a servicios de ubicación, utilizar mapas o verificar la integridad del dispositivo.

**GrapheneOS** adopta un enfoque radicalmente distinto. Permite instalar Google Play Services, pero lo ejecuta como una aplicación normal dentro del sandbox estándar de Android, sometida a las mismas restricciones y permisos que cualquier otra aplicación.

La consecuencia es importante: Google deja de ocupar una posición privilegiada dentro del sistema operativo. Sigue funcionando, pero ya no dispone de acceso especial al dispositivo ni puede saltarse las mismas reglas que afectan al resto de aplicaciones.

Lo más interesante es que, pese a ello, la compatibilidad sigue siendo excelente. Aplicaciones tan habituales como Google Maps, Gmail, WhatsApp, Play Store o la mayoría de aplicaciones bancarias continúan funcionando con normalidad.

Y aquí aparece una de las ideas más inteligentes de **GrapheneOS**. No obliga a renunciar a Google ni a cambiar por completo tu forma de utilizar el teléfono. Simplemente te permite decidir cuánto quieres depender de sus servicios y qué nivel de acceso estás dispuesto a concederles.

De hecho, muchos usuarios aprovechan los perfiles de usuario descritos anteriormente para aislar Google Play Services en un entorno separado del resto de aplicaciones y datos personales, añadiendo una capa extra de separación entre distintos contextos de uso.

En cierto modo, esta característica resume perfectamente la filosofía del proyecto: menos confianza implícita, menos privilegios automáticos y más control por parte del usuario.

# Conclusión

Después de entender su filosofía y utilizarlo durante unas semanas, ya puedo decir que **GrapheneOS** se ha convertido en el sistema operativo de mi teléfono personal.

Y no porque sea perfecto o porque elimine todos los riesgos. Lo ha hecho porque es la primera alternativa que he encontrado capaz de ofrecer más privacidad, más seguridad y más control sin obligarme a renunciar a la experiencia de uso de un smartphone moderno.

**GrapheneOS** no intenta reinventar Android. Tampoco pretende aislarte del mundo moderno. Su objetivo es mucho más práctico: reducir privilegios innecesarios, reforzar la seguridad y devolver al usuario una parte del control que normalmente se da por perdida.

Después de usarlo unas semanas, me doy cuenta que muchas de las limitaciones que asociamos a Android no son inevitables. Son decisiones de diseño, y **GrapheneOS** demuestra que existen alternativas razonables. Y esa es precisamente la razón por la que **GrapheneOS** también merece tu atención.

En el próximo artículo publicaré una guía paso a paso para instalar **GrapheneOS** en un Google Pixel 9a. Si te interesa el contenido sobre Linux, seguridad, privacidad o infraestructura, puedes seguirme en el [canal de Telegram](https://t.me/lateclaescape), donde comparto todos los artículos que publico y donde podemos debatir cualquier duda, sugerencia o experiencia relacionada con el proyecto.

Muchas gracias por leerme, y nos vemos en el próximo articulo!

Pulso la tecla `ESC:wq!`
