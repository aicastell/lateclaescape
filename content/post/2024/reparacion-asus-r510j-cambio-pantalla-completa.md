---
title: Reparación pantalla ASUS R510J
date: 2024-10-17
image: /img/posts/reparacion-asus-r510j.webp
categories: [ "tecnología", "personal", "hardware" ]
tags: [ "reparación", "ASUS-R510J" ]
draft: false
featured: true
---

# El portátil

En este articulo explico mi experiencia personal reparando la pantalla de un portátil ASUS R510J. Es la primera vez que intento reparar la pantalla de un portátil.

Este portátil cuenta con una CPU Intel(R) Core(TM) i7-4720HQ @ 2.60GHz de 4 núcleos y 8 hilos, pantalla de 15.6'', 8GB de RAM y almacenamiento en un disco mecánico de 1TB.

Instalado con Linux, distribución Ubuntu 24.04 con escritorio XFCE, rinde suficientemente bien para navegar por Internet, ver vídeos en Youtube, reproducir películas y hacer todo tipo de tareas ofimáticas.

# La avería

El portátil presenta una rotura en el lateral de la pantalla. Nunca se ha caído al suelo, y lo mas probable es que, de abrir y cerrar la pantalla, en algún momento se fisuró el lateral. Y poco a poco, la fisura se ha hecho grande sin darme cuenta.

![ASUS R510J](/img/reparacion-asus-r510j-pantalla-rota.webp)

Con esa rotura, la pantalla sigue funcionando, mostrando una imagen nítida, pero salen 6 rayas negras horizontales que no auguran nada bueno. Por tanto, voy a intentar repararlo.

# Pantalla nueva

Decido buscar una pantalla completa, que esta compuesta por:

- el panel LCD
- el bisel frontal
- la tapa trasera
- las bisagras

El *panel LCD* es la parte de la pantalla donde se muestra la imagen. El *bisel frontal* es el plástico que rodea el panel frontal, que protege los bordes de la pantalla. La *tapa trasera* protege a la pantalla por su parte trasera, y a su vez, es la parte visible del portátil cuando está cerrado. Por último, las *bisagras*, son los elementos mecánicos que unen la pantalla al portátil y permiten que la pantalla se abra y se cierre.

## ASUS

El fabricante ASUS ya no tiene recambios de este portátil en stock, así que toca descartar esta opción.

## Amazon

En Amazon solo encuentro recambios para el panel LCD, pero no encuentro recambios para el bisel ni tampoco para la tapa trasera.

## Wallapop

Busco en wallapop. Un chico de Sevilla vende un despiece de este mismo modelo de portátil. Pide 30€ por la pantalla completa. Si llega en buen estado, podré repararla. Y si no, habré perdido 30€. Es un riesgo controlado que decido asumir, consciente de las posibilidades, prefiero intentarlo que quedarme con la duda.

![ASUS R510J](/img/reparacion-asus-r510j-compra-pantalla-wallapop.webp)

## El recambio

La pantalla llega perfectamente embalada, y aparentemente en buen estado:

![ASUS R510J](/img/reparacion-asus-r510j-recambio-wallapop2.webp)

Aunque la tapa trasera lleva una pegatina horrorosa:

![ASUS R510J](/img/reparacion-asus-r510j-recambio-wallapop.webp)

# La reparación

Primero quito la pegatina aplicando un poco de calor con un secador. A pesar del cuidado, queda pegamento incrustado en la tapa. Elimino el pegamento con un poco de alcohol isopropilico y lavavajillas. Queda bastante limpio.

El proceso de desarmado de cualquier portátil es bastante laborioso. Primero quito de la parte trasera la batería y la tapa que esconde el disco duro y la memoria RAM.

![ASUS R510J](/img/reparacion-asus-r510j-sin-bateria-tapa-hdd.webp)

Después quito los tres tornillos que sujetan el disco duro a la carcasa, y procedo a retirarlo deslizando el disco hacia el lateral izquierdo.

A partir de este punto, es necesario quitar una gran cantidad de tornillos. Mi recomendación personal es tener mucho cuidado y organizarlos en una mesa, colocándolos de manera paralela y en la misma disposición en la que estaban en el portátil. Hay más de 30 tornillos, y una vez retirados, puede ser complicado recordar su ubicación exacta. Mantenerlos bien organizados hará que el proceso de reensamblado sea mucho más sencillo y fluido.

Tras desconectar con mucho cuidado los 3 cables tipo FLEX planos y el conector LVDS que viene de la pantalla, por fin consigo liberar la tapa del teclado y acceder a la placa base.

![ASUS R510J](/img/reparacion-asus-r510j-teclado-desconectado.webp)

Una vez abierto, encuentro mucho polvo acumulado. Aprovecho para limpiarlo con unos cepillos y echando aire frío con un secador de pelo.

Desmonto el lector de DVD que lleva en el lateral derecho, y la turbina de aire que hay en el lateral izquierdo. De esta manera, finalmente consigo acceder a la parte inferior de la placa base, por donde van rutados los cables que vienen de las bisagras de la pantalla.

![ASUS R510J](/img/reparacion-asus-r510j-fully-open.webp)

De una parte, los cables blanco y negro, que vienen de la bisagra derecha, hay que pasarlos por la parte inferior de la placa base, hasta conectarlos a dos conectores tipo UFL del módulo WiFi.

De otra parte, el cable que viene directo desde la bisagra izquierda de la pantalla, hay que pasarlo con cuidado por la parte inferior de la placa base, hasta el conector LVDS que hay en su parte superior.

Reensamblar el portátil es una tarea sencilla. Lo mas delicado es encajar los cables tipo FLEX en su posición para que queden perfectamente conectados a la placa base. Me quedo con dudas si los he conectado bien o no.

Tras encender el portátil, consigo visualizar un vídeo en Youtube, por lo que funciona el teclado, la WiFi, el touchpad del ratón y la pantalla. No estamos tan mal.

![ASUS R510J](/img/reparacion-asus-r510j-pantalla-visualiza-rana.webp)

La pantalla del portátil ha quedado reparada:

![ASUS R510J](/img/reparacion-asus-r510j-pantalla-reparada.webp)
![ASUS R510J](/img/reparacion-asus-r510j-pantalla-reparada2.webp)

Desde aquí le mando un saludo a José M., el vendedor de Wallapop, y le doy las gracias porque la pantalla funciona perfecta.

# Problemas

Durante el proceso de desmontaje, se rompieron dos tornillos que sujetaban la bisagra derecha de la pantalla a la carcasa de plástico. Estos estaban atornillados a unos pivotes plásticos bastante frágiles que, tras años de uso intensivo, probablemente perdieron su rigidez original. Aunque esta rotura no afectará el funcionamiento final del equipo, me deja una sensación agridulce, ya que esta bisagra, aunque sigue siendo funcional, ha quedado vulnerable.

![ASUS R510J](/img/reparacion-asus-r510j-rotura-torretas.webp)

Durante el proceso de limpieza, los cepillos estropean la membrana de uno de los altavoces internos. No sabía que eran tan delicados. Ahora cuando suena genera una vibración muy desagradable. Se puede solucionar con un altavoz externo conectado a la salida jack de audio.

He identificado los dos recambios en aliexpress. La tapa trasera de plástico vale 40€. Y los altavoces 7€. Es posible que en una reparación posterior me anime a reemplazar las dos piezas para dejar el portátil como nuevo.

# Despedida

En esta reparación has aprendido a cambiar la pantalla de un portátil ASUS R510J. En mi repositorio de [github](https://github.com/aicastell/repairable/tree/master/asus-r510j) he dejado todas las fotos del despiece por si puede ser de utilidad a alguien.

Como defensor del reciclaje, te animo a reparar tus propios dispositivos y no tirarlos a la basura al primer síntoma de que algo no funciona bien. Con un poco de paciencia, puedes darles una segunda vida y ahorrarte un dinerito bueno.

Por supuesto, si necesitas ayuda para hacer una reparación similar, puedes contactar conmigo en el [canal de Telegram](https://t.me/lateclaescape) e intentaré ayudarte. Gracias por leerme y nos vemos en el siguiente articulo.

Pulso la tecla `ESC:wq!`
