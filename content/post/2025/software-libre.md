---
title: Software Libre
date: 2025-01-31
image: /img/posts/software-libre.jpg
categories: [ "software_libre", "free_software" ]
tags: [ "GNU", "GPL", "FSF", "privacidad", "anonimato", "comunidad", "copyleft" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/software-libre.mp3" >}}

# Introducción

Richard Stallman ha dejado una huella profunda en la informática con su visión de un software que garantice la libertad de los usuarios. Su trabajo dio origen al proyecto GNU, la Free Software Foundation (FSF) y la Licencia Pública General (GPL), pilares del Software Libre.

En este artículo, exploraré cómo Stallman desafió el software privativo, cómo nació GNU para ofrecer un sistema operativo completamente libre y cómo Linux completó este esfuerzo. Acompáñame en este recorrido por la historia del Software Libre, sus principios fundamentales y su impacto en la informática moderna.

# Richard Stallman

Richard Matthew Stallman nace en Nueva York el 16 de marzo de 1953. Desde temprana edad, muestra un gran talento en matemáticas y programación. En la década de 1970, estudia en la Universidad de Harvard y, posteriormente, trabaja en el Laboratorio de Inteligencia Artificial del MIT. Allí se integra en una comunidad de hackers que comparten el código de sus programas, fomentando la colaboración y la mejora continua del software. Esta experiencia es clave en la gestación de su visión sobre el Software Libre.

El Laboratorio recibe la nueva impresora Xerox 9700. La versión anterior de esta impresora permitía modificar el código fuente de su driver, y los programadores habían mejorado su funcionalidad, por ejemplo, añadiendo una alerta cuando el papel se atascaba.

![Software libre printer Xerox 9700](/img/software-libre-printer-xerox-9700.webp)

Sin embargo, la nueva impresora llega con un cambio inesperado: el código fuente de su driver es totalmente cerrado, e impide cualquier modificación. Esto rompe con la cultura de compartir y mejorar el software que había caracterizado a la comunidad hacker hasta el momento. El software propietario comienza a ganar terreno.

Stallman contacta con Xerox y solicita su código fuente, pero Xerox se niega a proporcionarlo. Este hecho marca un punto de inflexión en la vida de Stallman. Las crecientes restricciones que está imponiendo el software propietario hacen necesaria una alternativa que garantice la libertad de los usuarios.

Esto lleva a Stallman a definir el concepto del **Software Libre**, basándose en cuatro libertades esenciales:

- Libertad de usar
- Libertad de estudiar
- Libertad de distribuir
- Libertad de mejorar

Estas libertades aseguran que cualquier persona pueda usar, estudiar, compartir y mejorar el software sin restricciones, sin necesidad de permisos ni pagos de licencias. A diferencia del software propietario, cuyo código fuente permanece oculto, el Software Libre es como un libro abierto: cualquiera puede examinarlo, modificarlo y adaptarlo a sus propias necesidades.

# El sistema operativo UNIX

Unix es un sistema operativo creado en 1969 por Ken Thompson y Dennis Ritchie en los laboratorios Bell de AT&T, se comparte inicialmente con universidades y desarrolladores, lo que facilita su rápida expansión y adaptación. Su diseño modular, basado en pequeños programas que realizan tareas específicas y se combinan mediante tuberías, lo hace versátil y eficiente. En los años 70 y 80, Unix se convierte en el sistema operativo preferido para la investigación y el desarrollo, siendo utilizado en universidades y laboratorios de todo el mundo.

En los años 80, AT&T restringe el acceso al código fuente de Unix y comienza a licenciarlo como software propietario, limitando su uso. Esto afecta a programadores e investigadores que dependían de su apertura para innovar. Esta transición hacia un modelo cerrado es clave para el nacimiento del movimiento del Software Libre, que impulsado por Stallman, busca recuperar la libertad de modificar y distribuir software sin restricciones.

# El proyecto GNU/Linux

Unix se había convertido en un estándar en la industria y en universidades, y muchas de sus herramientas eran muy potentes y estaban bien diseñadas. Para hacer realidad su ideal de Software Libre, Stallman necesita un sistema operativo completamente libre.

El 27 de septiembre de 1983, Stallman anuncia públicamente su intención de desarrollar un sistema operativo totalmente libre y compatible con Unix, para que los usuarios puedan migrar fácilmente. Así es como nace el Proyecto GNU (acrónimo de "GNU's Not Unix").

Stallman y otros colaboradores empiezan desarrollando herramientas fundamentales, como el compilador (GCC), un editor de texto (GNU Emacs), una linea de comandos (Bash) y otras utilidades básicas (ls, grep, sed, awk, etc), necesarias para montar un sistema operativo funcional.

Para que el sistema operativo GNU sea una solución completa, Stallman necesita un kernel completamente libre. Durante muchos años, intenta desarrollar Hurd, un kernel diseñado específicamente para este proyecto, pero su desarrollo se enfrenta a diversos obstáculos técnicos y retrasos inesperados.

Debido a las dificultades en el desarrollo de Hurd, la comunidad de Software Libre, liderada por Stallman, decide integrar Linux, un kernel creado por Linus Torvalds, en el sistema GNU. GNU proporciona todas las herramientas y aplicaciones esenciales, mientras que Linux actúa como el núcleo que permite la interacción con el hardware. Por esta razón, el sistema completo se denomina GNU/Linux, reconociendo la contribución fundamental de ambos proyectos.

# La Free Software Foundation

Para respaldar el desarrollo del Software Libre y proteger legalmente los programas que crea, Stallman funda la [Free Software Foundation](https://www.fsf.org/) (FSF) en 1985.

![Software Libre FSF](/img/software-libre-fsf.webp)

La FSF tiene cuatro misiones principales:

- Proteger legalmente al Software Libre
- Financiar el desarrollo de GNU y otras herramientas libres
- Educar a la comunidad
- Luchar contra el software propietario

A lo largo de los años, la FSF se ha convertido en la principal organización defensora del Software Libre, promoviendo el uso de sistemas abiertos y rechazando software privativo como Windows o macOS.

# La licencia GPL

Uno de los principales problemas del Software Libre era que algunas empresas tomaban código libre, lo modificaban y lo cerraban, impidiendo que las mejoras volvieran a la comunidad.

Para evitar este problema, Stallman y la FSF desarrollaron en 1989 la [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.html) (GPL), una licencia que garantiza que:

- Cualquiera puede usar, distribuir y modificar el software.
- Las mejoras y modificaciones también deben ser libres (**copyleft**).
- Nadie puede convertir el software en propietario.

Esta fue la primera licencia diseñada específicamente para proteger el Software Libre, **asegurando que cualquier software derivado también debía ser libre**. En 1991, se lanza la GPLv2, con ajustes para fortalecer su aplicación. Posteriormente, en 2007, llega la GPLv3, adaptada a nuevos desafíos como la DRM y las patentes de software.

![Software libre licencia GPL](/img/software-libre-licencia-gpl.webp)

La licencia GPL es el mecanismo legal que garantiza a los usuarios cuatro libertades fundamentales: usar, estudiar, modificar y distribuir el software. Su característica principal es el **copyleft**, una cláusula que obliga a que cualquier versión modificada o derivada de un software bajo GPL se distribuya con la misma licencia. Esto impide que el Software Libre sea transformado en propietario, asegurando que sus libertades perduren en el tiempo.

Gracias a la licencia GPL, el Software Libre ha podido expandirse globalmente, consolidando su filosofía en cada proyecto que la adopta. Aunque los aspectos legales nos puedan parecer un auténtico rollo, la GPL ha sido decisiva en la historia del Software Libre.

# Ventajas del Software Libre

Veamos todas las ventajas del Software Libre:

## Gratuito

Uno de los mayores atractivos del Software Libre, y por el que seguramente lo conozcas, es por su condición de gratuito. No necesitas pagar licencias costosas para su uso. El objetivo es que sea accesible para todos, sin importar tu presupuesto, si eres rico o pobre, o si eres persona física o jurídica (empresa).

## Control total sobre el software

Los usuarios tienen acceso completo al código fuente, lo que les permite estudiarlo, personalizarlo y modificarlo según sus necesidades.

## Transparencia

Promueve la transparencia, permitiendo que cualquier persona revise el código fuente para verificar qué acciones realiza el software, cómo trata los datos y cómo se comunica con servidores externos. Esto asegura que el software no transmita información sensible a servidores no deseados ni recopile datos sobre tus actividades sin tu consentimiento.

## Auditoría independiente

Usuarios y expertos de todo el mundo realizan auditorías independientes, ofreciendo un nivel de vigilancia sin igual. Esto facilita la detección y corrección de problemas que podrían permanecer ocultos en el software propietario. Además, asegura que el software esté libre de elementos maliciosos, como backdoors o spyware, reforzando la confianza en su uso.

## Seguridad

Permite detectar vulnerabilidades o fallos, lo que facilita soluciones rápidas gracias al esfuerzo colectivo. Esta colaboración, junto con el compromiso de desarrolladores y usuarios, impulsa la creación de herramientas seguras y confiables, beneficiando a todos los usuarios.

## Privacidad y anonimato

Ofrece control total y transparente sobre la gestión de tus datos, permitiéndote auditar y verificar que no haya funciones que comprometan tu privacidad. Herramientas como *Tor*, *Tails* y *Signal*, desarrolladas por comunidades comprometidas con la privacidad, protegen el anonimato. Este enfoque contrasta con las plataformas propietarias, que ofrecen soluciones opacas sin el mismo nivel de transparencia.

## Cifrado avanzado

Utiliza las mejores prácticas en cifrado para proteger tu información. Linux permite cifrar discos, particiones y archivos individuales, resguardando datos sensibles en caso de pérdida o robo. Además, muchas aplicaciones implementan cifrado E2EE (End-to-End Encryption), garantizando que solo tú y el destinatario podáis leer los mensajes, evitando interceptaciones por terceros.

## Independencia del proveedor

Elimina la dependencia de un proveedor único, lo que evita problemas comunes como la obsolescencia programada, los cambios abruptos en políticas comerciales o las actualizaciones obligatorias impuestas por empresas. Esto reduce significativamente el riesgo de quedar atrapado en un ecosistema cerrado y fomenta una mayor autonomía y control sobre las tecnologías que se utilizan.

## Comunidad activa

El Software Libre cuenta con una comunidad global de desarrolladores y usuarios que colaboran para mejorar el software, resolver problemas y crear nuevas funcionalidades. Esta comunidad a menudo es más accesible que los canales de soporte de software propietario, donde los tiempos de respuesta pueden ser largos o costosos.

## Fomento de la innovación

La libertad para modificar y compartir software fomenta la creatividad y la innovación. Los desarrolladores pueden experimentar con nuevas ideas y enfoques sin estar atados a las limitaciones de un producto propietario.

## Fomento de redes descentralizadas

Muchas soluciones de Software Libre fomentan el uso de redes descentralizadas. Es el caso de Mastodon o Bitcoin. Estas redes están diseñadas para evitar la concentración de poder en unas pocas empresas o gobiernos, lo que ayuda a reducir el riesgo de censura o monitoreo masivo.

# Inconvenientes del Software Libre

Veamos los inconvenientes del Software Libre:

## Curva de aprendizaje

Aunque muchas aplicaciones Software Libre son fáciles de usar, algunas pueden ser más complejas que sus contra-partes comerciales. Los usuarios sin experiencia técnica pueden encontrar más difícil la instalación, configuración y uso de ciertas aplicaciones.

## Compatibilidad limitada

Algunas aplicaciones Software Libre pueden no ser completamente compatibles con otros programas propietarios. Por ejemplo, un archivo creado en Microsoft Word puede no abrirse perfectamente en LibreOffice, lo que podría causar algunos problemas de funcionalidad.

## Soporte limitado

Aunque las comunidades son muy activas, no siempre ofrecen el mismo nivel de asistencia rápida y personalizada que las empresas propietarias. Para usuarios que necesitan soporte técnico inmediato, esto puede ser una desventaja significativa.

## Interfaz de usuario menos amigable

Algunos aplicaciones Software Libre pueden no tener un interfaz de usuario tan amigable como algunas soluciones comerciales.

## Falta de funciones avanzadas

En algunos sectores, como la producción musical, el diseño gráfico o la edición de vídeo profesional, las herramientas Software Libre aún están en proceso de maduración y no siempre pueden competir con las soluciones propietarias en términos de características y funcionalidades.

## Desactualizados o abandonados

Algunos proyectos de Software Libre pueden quedar desactualizados o abandonados, debido a la falta de contribuciones o recursos.

## Menor compatibilidad con hardware

Algunos dispositivos de hardware, como impresoras o cámaras, pueden contar con drivers específicos desarrollados solo para ciertos sistemas operativos comerciales, como Windows o macOS. Aunque algunas empresas y comunidades han creado controladores de código abierto, estos a menudo se basan en ingeniería inversa, lo que significa que la compatibilidad no siempre está garantizada.

# Conclusión

El Software Libre no es solo una alternativa técnica, es una filosofía de vida que defiende la libertad de los usuarios y el acceso equitativo a la tecnología. Desde la lucha de Richard Stallman por un software abierto hasta la creación de la GPL, cada paso ha sido crucial para garantizar un ecosistema digital más transparente y accesible.

Gracias a estas iniciativas y al trabajo comunitario basado en Software Libre, hoy en día podemos disfrutar de poderosas herramientas como Linux, Bash, GIMP y otras muchas, sin depender de corporaciones que impongan sus restricciones.

Te animo a seguir explorando más sobre este fascinante mundo. ¿Qué piensas sobre el Software Libre? ¿Lo usas en tu día a día? ¿Compartes la visión de Richard Stallman? Comparte tu opinión y experiencias en el [canal de Telegram](https://t.me/lateclaescape). ¡Me encantará leer tus comentarios!

Si este articulo te ha resultado interesante, no te pierdas el próximo, donde hablaré sobre el Open Source y las diferencias clave con el Software Libre. ¡Nos vemos pronto!

Pulso la tecla ESC, dos puntos wq!
