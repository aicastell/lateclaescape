---
title: Open Source
date: 2025-02-04
image: /img/posts/open-source.jpg
categories: [ "open_source", "codigo_abierto" ]
tags: [ "MIT", "BSD", "Apache", "OSI", "comunidad" ]
draft: false
featured: true
---

*Articulo disponible en formato audiblog:*

{{< audio path="audio/open-source.mp3" >}}

# Introducción

El articulo anterior analiza el concepto de [Software Libre](/post/2025/software-libre), basado en las ideas fundamentales de Richard Stallman y la FSF, que defiende que los usuarios deben tener la libertad de ejecutar, modificar, distribuir y estudiar el software sin restricciones. La licencia GPL es el mecanismo legal que garantiza que cualquier modificación de un Software Libre permanezca bajo la misma licencia, evitando que pueda convertirse en un producto comercial privado.

Muchas personas, incluidos profesionales del sector, usan el término "Open Source" (código abierto) como sinónimo de "Software Libre", cuando en realidad existen diferencias sutiles pero cruciales. Algunos consideran a estas diferencias como meras cuestiones filosóficas o éticas, pero la realidad es mucho mas pragmática.

En este artículo, explico que significa realmente "Open Source", su relación con el "Software Libre" y las diferencias clave entre ambos. Atentos porque voy a tocar un tema delicado que puede herir sensibilidades.

# El Open Source

En 1998, dos influyentes defensores del software libre, Eric S. Raymond y Bruce Perens, crean la Open Source Initiative (OSI), con la intención de diferenciar el **Open Source**, del software propietario.

![Open Source Initiative](/img/open-source-osi.webp)

La OSI establece y define los principios básicos que debe cumplir el código **Open Source**:

- Acceso al código fuente
- Libertad para modificar y distribuir
- Sin restricciones arbitrarias

El **Open Source** debe estar disponible para que cualquier persona pueda **ver**, **modificar** y **distribuir** el código fuente, sin restricciones significativas. Los usuarios deben poder modificar el código y distribuirlo, ya sea en su forma original o modificada. Las licencias no deben imponer limitaciones injustificadas ni discriminar a ninguna persona, grupo o uso del software. Esto significa que el software debe poder ser utilizado para cualquier propósito sin restricciones que limiten su adopción o su uso en ciertos contextos.

Esta filosofía fomenta la **colaboración**, la **innovación**, la **transparencia** y la **mejora continua** del software. Al estar disponible públicamente, el **Open Source** impulsa la creación de soluciones más robustas y eficientes. Hasta aquí, todo se parece bastante al Software Libre.

# Licencias Open Source

A continuación repaso las licencias Open Source mas conocidas:

![Open Source licencias](/img/open-source-licences.webp)

## MIT License

La [MIT License](https://opensource.org/license/mit) es una licencia de las más simples y permisivas. Solo requiere que se incluya el aviso de copyright y la licencia original en cualquier distribución del código, ya sea modificada o no. No impone restricciones sobre sublicencias ni patentes, lo que la hace altamente compatible con otros proyectos.

## BSD License

La [BSD License](https://opensource.org/license/bsd-3-clause) también es una licencia permisiva, pero incluye cláusulas adicionales relacionadas con el uso del nombre del proyecto y de sus contribuyentes. Prohíbe el uso del nombre del proyecto o sus colaboradores para fines promocionales sin un permiso explícito. Existen varias versiones de la BSD License, como la de 2 cláusulas y la de 3 cláusulas, que añaden distintas restricciones.

## La Apache License

La [Apache License](https://www.apache.org/licenses/LICENSE-2.0) incluye cláusulas adicionales relacionadas con patentes y el uso del nombre del proyecto. Tiene una cláusula única que asegura que los contribuyentes no pueden demandar a otros por infracción de patentes relacionadas con el código distribuido bajo esta licencia. Esta protección es especialmente importante en el ámbito comercial, ya que protege a los usuarios del código de posibles litigios sobre patentes.

## Sutil pero trascendental

Las licencias Open Source tienen una característica única que las diferencia por completo de la GPL. Todas son licencias **permisivas**. Esto de las licencias permisivas podría pasar desapercibido para muchos, pero no para [LaTeclaEscape](https://www.lateclaescape.com). Lo que significa este concepto en apariencia inofensivo, es que **NO OBLIGAN** a los desarrolladores que modifican el código a compartir sus modificaciones. Un detalle sutil pero que tiene implicaciones prácticas muy importantes.

¿Que significa esto? Significa que las licencias Open Source permiten que el software derivado se convierta en propietario. Es decir, una empresa puede tomar el código fuente desarrollado por la comunidad, modificarlo para crear un producto cerrado y venderlo como software propietario, sin necesidad de liberar las modificaciones realizadas. Esto es precisamente lo que impide la cláusula copyleft de la licencia GPL. Pero las licencias Open Source no incluyen dicha cláusula copyleft.

Existen ejemplos muy evidentes de esto, protagonizados por gigantes tecnológicos como Apple, Google o Amazon.

![Open Source Evil Corporation](/img/open-source-evil-corp.webp)

**Apple** tomó partes del código de OpenBSD y otros proyectos Open Source para desarrollar macOS (antes OS X), especialmente en su núcleo Unix llamado XNU. Debido a que OpenBSD usa una licencia permisiva, Apple no estaba obligada a compartir todas sus modificaciones, lo que le permitió crear un sistema propietario basado en ese código.

**Android** se basa en el núcleo de Linux, que es Software Libre, y en teoría, debería ser un sistema operativo libre. Sin embargo, Google ha cerrado muchas de las aplicaciones y servicios clave de Android, como Google Play Services, Gmail, Google Maps y otras aplicaciones de Google. Estas aplicaciones no son libres, y su uso está sujeto a restricciones y condiciones impuestas por Google. Además, Google ha fomentado un ecosistema en el que los fabricantes de dispositivos dependen de sus servicios propietarios, limitando la libertad de los usuarios.

**Amazon** utilizó el proyecto Open Source Elasticsearch para crear su servicio Amazon Elasticsearch Service. Aunque Amazon contribuyó al proyecto inicialmente, también comenzó a ofrecer características propietarias que no devolvió a la comunidad. Esto llevó a los creadores de Elasticsearch a cambiar la licencia de su software para evitar que grandes corporaciones lo aprovecharan sin contribuir.

El problema real de todo esto no es que las corporaciones utilicen el Open Source. Eso está bien. El problema es que lo hagan de una manera que **no devuelva valor a la comunidad** y, en algunos casos, lo conviertan en software cerrado. Esto va en contra del espíritu original del Open Source y del Software Libre, que busca garantizar que el software sea accesible, modificable y distribuible por todos.

El modelo actual del Open Source favorece más a las empresas que a la comunidad. Sus licencias actúan como un "caballo de Troya" en la batalla contra el Software Libre: permiten que las compañías lo adopten con la promesa de transparencia y colaboración, pero les brindan la libertad de cerrar el código cuando les conviene. Así, las grandes corporaciones se benefician del trabajo comunitario sin necesidad de retribuirlo, lo que está erosionando progresivamente al ecosistema del Software Libre.

En general, este asunto sigue y seguirá siendo motivo de acalorados debates dentro del ecosistema tecnológico actual.

# Conclusión

Elegir una licencia para tu proyecto no es un detalle menor, define su posible impacto, la comunidad que lo rodea y la forma en que será utilizado en el futuro. Mientras que licencias permisivas como MIT, BSD o Apache 2.0 ofrecen gran flexibilidad, permitiendo incluso su uso en software propietario, las licencias con copyleft, como la GPL, aseguran que cualquier modificación permanezca accesible para todos, protegiendo la esencia del Software Libre.

Ahora que conoces estas diferencias, ¿sigues viendo al Open Source y al Free Software con los mismos ojos? ¿Sigues pensando que las diferencias son meras cuestiones éticas y filosóficas? ¿Quien crees que lleva razón en todo esto? ¿Las empresas o la comunidad de desarrolladores? Como siempre, estaré atento a tus comentarios en el [canal de Telegram](https://t.me/lateclaescape).

Si este artículo te ha parecido interesante, en el próximo haré un listado de las aplicaciones más relevantes dentro del mundo del Open Source y del Software Libre. Seguro que descubres alguna aplicación interesante. ¡Nos vemos en el siguiente artículo!.

Pulso la tecla ESC, dos puntos wq!
