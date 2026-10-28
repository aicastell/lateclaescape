---
title: Me estafan en Wallapop
date: 2026-10-27
image: /img/posts/estafado-en-wallapop.webp
categories: [ "hardware", "personal" ]
tags: [ "Samsung", "990_PRO", "NVMe", "storage", "SSD", "Wallapop", "falsificaciones" ]
draft: false
featured: true
---

# Introducción

Hace unas semanas compré un portátil [Lenovo ThinkPad E14 Gen 8](/post/2026/lenovo-thinkpad-e14-gen8) equipado con un procesador Intel Core Ultra 7 de la familia Panther Lake. El portátil incorpora de fábrica una unidad NVMe de 256 GB. Aunque es suficiente para instalar el sistema operativo y las herramientas habituales, mi intención era comprar una unidad de almacenamiento extra para almacenar mi directorio /home, donde guardar mi trabajo.

Buscaba una unidad NVMe de mayor capacidad y, entre las opciones disponibles, me interesaba especialmente el Samsung 990 PRO de 4 TB, un SSD PCIe 4.0 de gama alta con un rendimiento extraordinario, valorado actualmente en más de 700 €.

![Estafado en Wallapop samsung 990PRO precio pccomponentes](/img/estafado-en-wallapop-samsung-990pro-precio-pccomponentes.webp)

# Samsung 990 PRO de 4 TB en Wallapop

Mientras buscaba alternativas, encontré en Wallapop un anuncio que llamó inmediatamente mi atención. El vendedor ofrecía un producto anunciado como SSD M.2 NVMe 4 TB Samsung 990 PRO.

![Estafado en Wallapop anuncio fullbazar](/img/estafado-en-wallapop-anuncio-fullbazar.webp)

El precio era de 40 €, muy por debajo del habitual para una unidad de esas características. Era una oferta extraordinariamente atractiva. También, evidentemente, sospechosa.

Sin embargo, decidí arriesgarme confiando en el sistema de protección al comprador de Wallapop. Después de años utilizando la plataforma sin ningún problema, daba por hecho que, si recibía un producto distinto del anunciado, podría reclamar y recuperar mi dinero. Con esa tranquilidad completé la compra. Entre el artículo y los gastos asociados el precio total pagado fueron 49 €.

# La llegada del SSD

Cuando recibí el paquete, las primeras impresiones no fueron buenas. El embalaje no era el del disco original de Samsung. Tenía una inscripción «SSD M.2 NVMe» y un adhesivo que indicaba una capacidad de 4 TB. Uno de los laterales muestra una relación de capacidades disponibles que llega hasta 2 TB. Ni siquiera menciona los 4 TB del producto adquirido.

![Estafado en Wallapop etiquetas contradiccion](/img/estafado-en-wallapop-etiquetas-contradiccion.webp)

Por sí sola, esta circunstancia no demuestra que un dispositivo sea falso. Pero son detalles que ya me pusieron en modo alerta.

Al revisar la unidad encontré algo más preocupante: la etiqueta mostraba el nombre 990 PRO, pero incluía la [referencia MZ-V8P1T0](https://download.semiconductor.samsung.com/resources/data-sheet/Samsung-NVMe-SSD-980-PRO-Data-Sheet_Rev.2.1_230509_10129505074622.pdf).

![Estafado en Wallapop codigo MX-V8P1T0 resaltado](/img/estafado-en-wallapop-codigo-MZ-V8P1T0-resaltado.webp)

Según el datasheet de fabricante Samsung, esta referencia se corresponde con el modelo Samsung 980 PRO de 1 TB, y no con el Samsung 990 PRO de 4 TB comprado.

![Estafado en Wallapop MX V8P1T0 datasheet](/img/estafado-en-wallapop-MZ-V8P1T0-datasheet.webp)

La etiqueta, por tanto, contenía identificaciones incompatibles entre sí.

# Identificación electrónica

Llegado a este punto decido comprobar el dispositivo conectándolo a uno de mis equipos. Mi intención es averiguar si el dispositivo es o no un Samsung, tal y como se anunciaba en Wallapop. Para investigar la identidad del SSD utilicé Debian GNU/Linux y `smartctl`, una herramienta de Linux que permite consultar información de dispositivos de almacenamiento.

Tras lanzar el comando:

```
sudo smartctl -x -d sntjmicron /dev/sdX
```

El resultado fue el siguiente:

```
=== START OF INFORMATION SECTION ===
Model Number:                       SSD 4TB
Serial Number:                      001766
Firmware Version:                   VC2S038D
PCI Vendor/Subsystem ID:            0x10ec
IEEE OUI Identifier:                0x00e04c
Controller ID:                      1
NVMe Version:                       1.4
Number of Namespaces:               1
Namespace 1 Size/Capacity:          4.000.787.030.016 [4,00 TB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            00e04c 17b7335359
Local Time is:                      Tue Oct 27 08:06:50 2026 CET
Firmware Updates (0x02):            1 Slot
Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
Optional NVM Commands (0x0054):     DS_Mngmt Sav/Sel_Feat Timestmp
Log Page Attributes (0x02):         Cmd_Eff_Lg
Maximum Data Transfer Size:         32 Pages
Warning  Comp. Temp. Threshold:     100 Celsius
Critical Comp. Temp. Threshold:     110 Celsius

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
 0 +     8.00W       -        -    0  0  0  0        0       0
 1 +     4.00W       -        -    1  1  1  1        0       0
 2 +     3.00W       -        -    2  2  2  2        0       0
 3 -   0.0300W       -        -    3  3  3  3     5000   10000
 4 -   0.0050W       -        -    4  4  4  4    54000   45000

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
 0 +     512       0         0

=== START OF SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02)
Critical Warning:                   0x00
Temperature:                        40 Celsius
Available Spare:                    100%
Available Spare Threshold:          32%
Percentage Used:                    0%
Data Units Read:                    20.817 [10,6 GB]
Data Units Written:                 260.531 [133 GB]
Host Read Commands:                 927.841
Host Write Commands:                7.753.157
Controller Busy Time:               0
Power Cycles:                       14
Power On Hours:                     4
Unsafe Shutdowns:                   7
Media and Data Integrity Errors:    0
Error Information Log Entries:      0
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    0
```

El identificador PCI reportado por el propio dispositivo es un [0x10ec](https://devicehunt.com/view/type/pci/vendor/10EC), que pertenece al fabricante [Realtek Semiconductor Corp](https://www.realtek.com/). Ni rastro de Samsung.

Para completar la investigación, examiné físicamente la PCB. En la cara posterior encontré serigrafiada la referencia [RTS5765DL](https://devicehunt.com/view/type/pci/vendor/10EC/device/5765):

![Estafado en Wallapop codigo RTS5765DL resaltado](/img/estafado-en-wallapop-codigo-RTS5765DL-resaltado.webp)

Esta referencia está asociada a una plataforma de controladores SSD de Realtek Semiconductor Co., Ltd, lo que encaja perfectamente con el reporte generado por la herramienta `smartctl`.

Con todas estas evidencias sobre la mesa, la conclusión parece bastante clara: el dispositivo recibido no se identificaba como el Samsung 990 PRO de 4 TB que he comprado. A estas alturas, todo apuntaba a que tengo entre manos una falsificación.

# Pruebas de rendimiento

Decido comprobar el rendimiento que ofrece realmente el supuesto Samsung 990 PRO. Para ello recurro a fio (Flexible I/O Tester), una herramienta de software libre ampliamente utilizada en GNU/Linux para evaluar el rendimiento de dispositivos de almacenamiento mediante diferentes patrones de entrada y salida.

Para medir el ancho de banda de lectura del dispositivo, comienzo con una prueba de lectura secuencial, utilizando bloques de 1 MiB y una profundidad de cola de 16 operaciones.

```
$ fio \
  --name=sequential-read-qd16 \
  --filename=/dev/sdX \
  --readonly \
  --rw=read \
  --bs=1M \
  --ioengine=libaio \
  --iodepth=16 \
  --direct=1 \
  --offset=1G \
  --size=1G \
  --group_reporting \
  --output=benchmark-read-qd16.json \
  --output-format=json
```

Un Samsung 990 PRO auténtico debería alcanzar velocidades secuenciales de hasta 7450 MB/s en lectura y 6900 MB/s en escritura. El disco de Wallapop apenas logra alcanzar una lectura secuencial de 19 MB/s. La diferencia es tan disparatada que pretender ignorarla sería como comprarse un Ferrari y descubrir que, para adelantar a un ciclista, hay que bajarse a empujar.

# Integridad de los datos

Voy a comprobar ahora la integridad de los datos. Durante esta prueba compruebo como distintas operaciones de escritura finalizan sin errores aparentes, pero tras desconectar el dispositivo y volver a conectarlo, los datos escritos no existen, simplemente han desaparecido. Hago la prueba utilizando patrones de datos reconocibles y comparando sus hash SHA256 antes y después de escribirlos en el dispositivo. Como no podía ser de otra manera, aparecieron diferencias entre los datos escritos y los recuperados.

```
Offset: 16777216

SHA-256 esperado:
7a0947add4463a43dfb4e839d34d820bb9427150023e95252f4745970c3bc475

SHA-256 obtenido:
f723abf5898e76f3f0f42fdc751d55a6c3c64f5f5568577b4198b15857348775

RESULTADO: FAIL
```

Los problemas no terminan con las pruebas de lectura y escritura. También intento regenerar la tabla de particiones del dispositivo utilizando `fdisk` y `GParted`, pero los cambios no se conservaban correctamente.

Para descartar que se trate únicamente de un problema con la tabla de particiones, intento crear un sistema de ficheros `ext4` mediante `mkfs.ext4` directamente sobre el dispositivo `/dev/sdX`, sin crear partición. Aunque la herramienta finaliza aparentemente sin errores, posteriormente no es posible montar el sistema de ficheros: al comprobarlo, los metadatos esperados, incluida la firma del superbloque `ext4`, no son válidos.

En definitiva, el dispositivo no solo presenta un rendimiento lamentable: tampoco conserva de forma fiable las estructuras básicas necesarias para almacenar información.

Llegados a este punto, decido sacar la artillería pesada. Voy a usar F3 [Fight Flash Fraud](https://github.com/AltraMayor/f3), una herramienta de software libre desarrollada precisamente para desenmascarar unidades de almacenamiento fraudulentas que presumen de capacidades que no tienen. Si el supuesto Samsung 990 PRO esconde alguna sorpresa más, ha llegado el momento de descubrirla.

> Cuidado, esta prueba sí es destructiva y puede sobrescribir información almacenada en el dispositivo, por lo que no debe ejecutarse sobre una unidad de almacenamiento que contenga datos que quieras conservar.

Tras ejecutar el comando `f3probe`:

```
sudo f3probe --destructive --time-ops /dev/sdX
```

se confirmaron las peores noticias:

```
Bad news: The device `/dev/sdX' is damaged

Device geometry:
    *Usable* size: 0.00 Byte (0 blocks)
    Announced size: 3.64 TB (7814037168 blocks)
```

Es un resultado contundente con el que concluyo que estoy analizando una falsificación de pésima calidad, incapaz de cumplir con su función más elemental: almacenar datos de forma fiable. Y, sinceramente, ni siquiera me atrevería a utilizarla como pisapapeles.

# La disputa con Wallapop

Aquí llegamos a la cuestión fundamental: he comprado un producto anunciado como Samsung 990 PRO y he recibido un dispositivo cuya identificación no se corresponde con ese modelo. Ante esta situación, abro una disputa a través de Wallapop.

![Estafado en Wallapop apertura disputa](/img/estafado-en-wallapop-apertura-disputa.webp)

Mi reclamación se fundamentaba en una cuestión muy sencilla: el producto recibido no es el anunciado. El anuncio ofrece un Samsung 990 PRO de 4 TB y el dispositivo entregado presenta identificaciones físicas y electrónicas incompatibles con ese producto.

Para mi sorpresa, Wallapop rechaza mi reclamación:

![Estafado en Wallapop disputa rechazada](/img/estafado-en-wallapop-disputa-rechazada.webp)

En la práctica, con esta decisión, Wallapop está validando la venta de falsificaciones en su portal. Sinceramente, sabía que comprar un supuesto Samsung 990 PRO de 4 TB por 40 € podía traer sorpresas. Pero jamás imaginé que la mayor de todas me la daría Wallapop.

Posteriormente contacto de nuevo con [atención al cliente](mailto:supportteam@wallapop.com). Recibo una segunda respuesta negativa, en la que reiteran su negativa. Una decisión me resulta especialmente decepcionante porque había realizado la compra confiando en el sistema de protección al comprador de la plataforma. Una confianza que cuesta mucho de ganar y muy poco perderla.

En el momento de redactar este artículo, la reclamación continúa sin resolverse favorablemente. Yo ya doy por perdidos los 49 €.

# Contacto con el vendedor

El vendedor usa la identidad *FullBazar* en Wallapop. En el momento de consultar su perfil, la plataforma muestra su ubicación en Lisboa, 175 ventas realizadas y 272 artículos anunciados.

Tras recibir el producto, he contactado directamente con él para comunicarle que el dispositivo es una falsificación y no se corresponde con el Samsung 990 PRO anunciado. El vendedor responde en portugués y me pregunta si el artículo funciona. Le explico que el problema no es si funciona o no, sino que lo ha anunciado como un producto de Samsung cuando su identificación electrónica corresponde a otro dispositivo. A partir de aquí, no me contesta a más mensajes.

No puedo afirmar cuáles eran sus conocimientos sobre el origen del dispositivo ni sus intenciones al publicarlo. Lo que sí puedo documentar es el contenido del anuncio, las características del artículo recibido, el resultado de mis investigaciones, y de las gestiones para solicitar una devolución. Y esos son los hechos que quiero dejar reflejados públicamente.

# Conclusiones

Compré este artículo sabiendo que su precio era demasiado bajo para ser verdad. Pero confiaba plenamente en el servicio de atención a cliente de Wallapop. Creía poder reclamar si recibía un producto distinto del anunciado. Pero mi experiencia con el proceso de disputa de Wallapop ha sido decepcionante.

Nunca imaginé que, después de demostrar que el dispositivo recibido ni siquiera se identificaba como el Samsung 990 PRO de 4 TB que había comprado, mi reclamación acabaría siendo rechazada. Sinceramente, todavía me cuesta entenderlo.

Al final, el dinero perdido ha sido lo de menos. Lo que realmente me fastidia es haber descubierto que la protección al comprador en la que tanto confiaba no ha respondido cuando la he necesitado. Dicen que la confianza cuesta años ganarla y apenas unos minutos perderla. En mi caso, Wallapop acaba de perder un cliente. No volveré a comprar en esta plataforma.

Tampoco pienso quedarme únicamente con el mal sabor de boca. Si algo bueno puedo sacar de esta experiencia, es la oportunidad de compartir lo aprendido y ayudar a otros compradores a identificar este tipo de falsificaciones. Si este artículo consigue evitar que tú también caigas en la misma trampa, daré por bien invertidos los 49 € que me costó la aventura.

Si has pasado por alguna experiencia similar, me encantaría conocerla. Te invito a unirte al [Canal de Telegram](https://t.me/lateclaescape), donde ya somos unos cuantos miembros que compartimos experiencias, resolvemos dudas y donde todos podemos aprender de los demás. ¡Y es totalmente gratis!

Este artículo tendrá una segunda parte. Próximamente compraré un Samsung 990 PRO a un proveedor de plena confianza para ampliar el almacenamiento de mi ThinkPad. Aprovecharé para repetir las pruebas de identificación y rendimiento, comparar ambos dispositivos y mostrar cómo identificar un SSD NVMe auténtico desde GNU/Linux. Resultará especialmente revelador poder comprobar de primera mano las prestaciones ofrecidas por el Samsung 990 PRO original.

¡Nos vemos en el próximo artículo!

Pulso la tecla `ESC:wq!`

