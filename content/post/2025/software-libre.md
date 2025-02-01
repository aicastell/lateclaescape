---
title: Software Libre
date: 2025-01-31
image: /img/posts/software-libre.jpg
categories: [ "software_libre" ]
tags: [ "GNU", "GPL", "FSF", "privacidad", "anonimato", "comunidad", "Berkeley", "Richard Stallman", "copyleft" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/software-libre.mp3" >}}

# Introducción

En el mundo de la informática, pocas figuras han dejado una huella tan profunda como Richard Stallman. Su visión de un software que garantice la libertad de los usuarios llevó al nacimiento del proyecto GNU, la creación de la Free Software Foundation (FSF) y el desarrollo de la Licencia Pública General (GPL), la piedra angular del Software Libre.

En este artículo voy a explicar cómo Stallman desafió el modelo de software privativo, cómo nació GNU en un esfuerzo por ofrecer un sistema operativo completamente libre, y cómo finalmente Linux se convirtió en la pieza clave que completó este rompecabezas.

Acompáñame en este recorrido por la historia del Software Libre, sus principios fundamentales y el impacto que ha tenido en la informática moderna.

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

Unix es un sistema operativo creado en 1969 por Ken Thompson y Dennis Ritchie en los laboratorios Bell de AT&T. Inicialmente, AT&T comparte el código con universidades y desarrolladores, lo que permite su rápida expansión y adaptación a diferentes plataformas. Su diseño modular, basado en pequeños programas que realizan tareas específicas y pueden combinarse mediante tuberías, lo hace especialmente versátil y eficiente. Durante los años 70 y principios de los 80, Unix se convierte en el sistema operativo favorito para la investigación y el desarrollo, utilizado en universidades y laboratorios de todo el mundo.

Sin embargo, en los años 80, AT&T decide restringir el acceso al código fuente y comenzar a licenciar Unix como software propietario, lo que limita su uso y afecta a muchos programadores e investigadores que dependen de su apertura para innovar. La transición de Unix hacia un modelo cerrado es decisiva para el nacimiento del movimiento Software Libre. Impulsado por Stallman y por la Free Software Foundation (FSF), el movimiento busca recuperar la libertad de modificar y distribuir software sin restricciones.

# El proyecto GNU/Linux

Unix se había convertido en un estándar en la industria y en universidades, y muchas de sus herramientas eran muy potentes y estaban bien diseñadas. Para hacer realidad su ideal de Software Libre, Stallman necesita un sistema operativo completamente libre.

El 27 de septiembre de 1983, Stallman anuncia públicamente su intención de desarrollar un sistema operativo totalmente libre y compatible con Unix, para que los usuarios puedan migrar fácilmente. Así es como nace el Proyecto GNU (acrónimo de "GNU's Not Unix").

Stallman y otros colaboradores empiezan desarrollando herramientas fundamentales, como el compilador (GCC), un editor de texto (GNU Emacs), una linea de comandos (Bash) y otras utilidades básicas (ls, grep, sed, awk, etc), necesarias para montar un sistema operativo funcional.

Para que el sistema operativo GNU sea una solución completa, Stallman necesita un kernel completamente libre. Durante muchos años, intenta desarrollar Hurd, un kernel diseñado específicamente para este proyecto, pero su desarrollo se enfrenta a diversos obstáculos técnicos y retrasos inesperados.

Debido a las dificultades en el desarrollo de Hurd, la comunidad de Software Libre, liderada por Stallman, decide integrar Linux, un kernel creado por Linus Torvalds, en el sistema GNU. GNU proporciona todas las herramientas y aplicaciones esenciales, mientras que Linux actúa como el núcleo que permite la interacción con el hardware. Por esta razón, el sistema completo se denomina GNU/Linux, reconociendo la contribución fundamental de ambos proyectos.

# La Free Software Foundation

Para respaldar el desarrollo del Software Libre y proteger legalmente los programas que crea, Stallman funda la [Free Software Foundation](https://www.fsf.org/) (FSF) en 1985.

![Software Libre FSF](/img/software-libre-fsf.webp)

La FSF tiene tres misiones principales:

- Proteger legalmente al Software Libre
- Financiar el desarrollo de GNU y otras herramientas libres
- Educar a la comunidad y luchar contra el software propietario

A lo largo de los años, la FSF se ha convertido en la principal organización defensora del Software Libre, promoviendo el uso de sistemas abiertos y rechazando software privativo como Windows o macOS.

# La licencia GPL

Uno de los principales problemas del Software Libre era que algunas empresas tomaban código libre, lo modificaban y lo cerraban, impidiendo que las mejoras volvieran a la comunidad.

Para evitar este problema, Stallman y la FSF desarrollaron en 1989 la [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.html) (GPL), una licencia que garantiza que:

- Cualquiera puede usar, distribuir y modificar el software.
- Las mejoras y modificaciones también deben ser libres (copyleft).
- Nadie puede convertir el software en propietario.

Esta fue la primera licencia diseñada específicamente para proteger el Software Libre, asegurando que cualquier software derivado también debía ser libre. En 1991, se lanza la GPLv2, con ajustes para fortalecer su aplicación. Posteriormente, en 2007, llega la GPLv3, adaptada a nuevos desafíos como la DRM y las patentes de software.

![Software libre licencia GPL](/img/software-libre-licencia-gpl.webp)

La licencia GPL es el mecanismo legal que garantiza a los usuarios cuatro libertades fundamentales: usar, estudiar, modificar y distribuir el software. Su característica principal es el "copyleft", una cláusula que obliga a que cualquier versión modificada o derivada de un software bajo GPL se distribuya con la misma licencia. Esto impide que el Software Libre sea transformado en propietario, asegurando que sus libertades perduren en el tiempo.

Gracias a la licencia GPL, el Software Libre ha podido expandirse globalmente, consolidando su filosofía en cada proyecto que la adopta. Aunque los aspectos legales nos puedan parecer un auténtico rollo, su impacto ha sido decisivo en la historia del Software Libre.

# Aplicaciones GPL

A continuación enumero una lista de aplicaciones distribuidas bajo distintas versiones de la licencia GPL.

## Sistemas operativos

| Aplicación | Descripción | Licencia |
|-|-|-|
| Linux | El kernel del sistema operativo | GPLv2 |
| GRUB | Cargador de arranque | GPLv3 |
| Debian | Distribución Linux basada exclusivamente en Software Libre | GPL y otras |
| Trisquel | Distribución 100% libre basada en Ubuntu | GPL |
| OpenWRT | Distribución Linux para routers | GPLv2 |

## Herramientas del sistema operativo

| Aplicación | Descripción | Licencia |
|-|-|-|
| GNU Bash | Shell de GNU | GPLv3 |
| BusyBox | Tools para sistemas embebidos | GPLv2 |
| Coreutils | Comandos básicos de GNU (ls, cp, mv, etc) | GPLv3 |
| Findutils | Buscar archivos (find, locate, etc) | GPLv3 |
| Sed | Editor para procesamiento de textos y logs | GPLv3 |
| Gawk | Re-implementación de awk con GNU | GPLv3 |
| Tar | Empaquetar y extraer archivos | GPLv3 |
| Gzip | Herramienta de compresión | GPLv3 |
| Bzip2 | Otra herramienta de compresión | GPLv2 |
| XZ Utils | Mas herramientas de compresión | GPLv2+ |
| Diffutils | Herramientas para comparar ficheros (diff, cmp) | GPLv3 |
| Inetutils | Herramientas básicas de red (ftp, telnet o ping) | GPLv3 |

## Entornos de escritorio

| Aplicación | Descripción | Licencia |
|-|-|-|
| GNOME | Entorno de escritorio para Linux | GPLv2/GPLv3 |
| KDE Plasma | Otro entorno de escritorio popular | GPLv2/GPLv3 |
| XFCE | Un escritorio ligero | GPLv2 |
| LXQt | Un escritorio ligero basado en Qt | GPLv2/GPLv3 |
| MATE | Un fork de GNOME 2 | GPLv2/GPLv3 |

## Desarrollo de software

| Aplicación | Descripción | Licencia |
|-|-|-|
| GCC | Compilador de GNU | GPLv3 |
| Vim | Mi editor de texto | GPLv2 |
| Emacs | Editor de texto avanzado | GPLv3 |
| GDB | Depurador de GNU | GPLv3 |
| KDevelop | Entorno de desarrollo de KDE | GPLv2 |
| Git | Sistema de control de versiones | GPLv2 |

## Aplicaciones multimedia

| Aplicación | Descripción | Licencia |
|-|-|-|
| Blender | Suite de animación y modelado 3D | GPLv2+ |
| GIMP | Editor de imágenes tipo Photoshop | GPLv3 |
| Inkscape | Editor de gráficos vectoriales tipo Illustrator | GPLv3 |
| Audacity | Editor de audio | GPLv2 |
| Krita | Editor de ilustración y pintura digital | GPLv3 |
| Darktable | Procesado de fotos ROW tipo Lightroom | GPLv3 |
| OBS Studio | Grabar pantalla y transmisión en vivo | GPLv2 |
| VLC | Reproductor multimedia | GPLv2 |

## Redes y seguridad

| Aplicación | Descripción | Licencia |
|-|-|-|
| Pass | El gestor de contraseñas estándar de Unix | GPLv2 |
| KeePass | Otro gestor de contraseñas seguras | GPLv2 |
| Wireshark | Herramienta de análisis de protocolos de red | GPLv2 |

## Web

| Aplicación | Descripción | Licencia |
|-|-|-|
| Konqueror | Navegador y gestor de archivos KDE | GPLv2 |
| Wget | Descarga de archivos | GPLv3 |
| Links | Browser en modo texto | GPLv2+ |

## Ofimática

| Aplicación | Descripción | Licencia |
|-|-|-|
| LibreOffice | Suite ofimática completa | GPLv3 |
| FreeCAD | Diseño 3D paramétrico | GPLv2+ |

## Bases de datos

| Aplicación | Descripción | Licencia |
|-|-|-|
| MySQL | Sistema gestión bases de datos | GPLv2 |
| MariaDB | Fork de MySQL | GPLv2 |

## Servidores

| Aplicación | Descripción | Licencia |
|-|-|-|
| Samba | Interoperabilidad con Windows | GPLv3 |
| CUPS | Gestor de impresión utilizado en Linux y macOS | GPLv2+ |
| Dnsmasq | Gestor de DNS y DHCP ligero para redes pequeñas | GPLv2 |

# Conclusión

El Software Libre no es solo una alternativa técnica, es una filosofía de vida que defiende la libertad de los usuarios y el acceso equitativo a la tecnología. Desde la lucha de Richard Stallman por un software abierto hasta la creación de la GPL, cada paso ha sido crucial para garantizar un ecosistema digital más transparente y accesible.

Gracias a estas iniciativas, hoy en día podemos disfrutar de herramientas poderosas sin depender de corporaciones que imponen restricciones. Linux, Bash, GIMP y muchos otros proyectos son el resultado de décadas de trabajo comunitario basado en la filosofía del Software Libre.

Te animo a seguir explorando más sobre este fascinante mundo. ¿Qué piensas sobre el Software Libre? ¿Lo usas en tu día a día? ¿Cuáles son tus aplicaciones favoritas? Puedes compartir tus opiniones y experiencias en el [canal de Telegram](https://t.me/lateclaescape). ¡Me encantará leer tus comentarios!

Si este articulo te ha resultado interesante, no te pierdas el próximo, donde hablaré sobre el Open Source y las diferencias clave con el Software Libre. ¡Nos vemos pronto!

Pulso la tecla ESC, dos puntos wq!
