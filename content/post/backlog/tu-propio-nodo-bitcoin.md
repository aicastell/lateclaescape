---
title: Tu propio nodo Bitcoin
date: 2023-12-27
image: /img/posts/la-tecla-esc.jpg
categories: [ "criptomonedas" ]
tags: [ "bitcoin", "nodos" ]
draft: true
featured: true
---


https://www.athena-alpha.com/bitcoin-node/

Correr un Nodo Full Bitcoin es una de las mejores cosas que puedes hacer por tu privacidad y seguridad. Fortale la red, le permite recibir pagos si dirige un negocio y una serie de otras habilidades básicas como enrutar a otros pueblos Pagos relámpagos.

Mientras que muchos rehúyen de convertirse en un Runner de Nodo porque piensan que es demasiado técnico o caro esto es completamente incorrecto. Ejecutar tu propio nodo completo puede ser gratis y tan fácil como descargar una aplicación. Sólo no use un disco duro.



## Requisitos minimos

Requisitos de nodo de Bitcoin

Bitcoin.org declara oficialmente que los requisitos mínimos para ejecutar un Nodo Bitcoin son:

    Sistema operativo: Windows / Mac / Linux
    CPU: Básicamente cualquier cosa, desde un Raspberry Pi hasta Core i7
    RAM: 2 GB.
    Espacio de disco: 7 GB.
    Conexión en Internet: 0,4 Mbps. Banda de ancho
    Descargar cuota: 20 GB por mes
    Subir cuota: 200 GB al mes

Sin embargo, para obtener una buena experiencia lo más importante es asegurarte de usar una SSD (ya sea de 2,5 o M.2) que sea de 1 TB o más y que también tenga suficiente memoria RAM, preferiblemente 8 GB o más.

El IBD requiere un gran número de lectura/escritura en el almacenamiento. Si estás usando un disco duro mecánico te vas a pasar mal en nosotros. Estamos hablando de semanas de espera. Utilice una SSD y se hará en un día o tres en su lugar.

En cuanto al espacio en disco, la cifra de 7 GB es para los nodos que se ejecutan en el Modo Porrado y no es realmente la mejor experiencia, ya que se pierde en gran parte de los beneficios de seguridad y privacidad. Todo el blockchain es de 565 GB y crece a unos 50 GB al año. Por lo tanto, un viaje de 1 TB debe durar 6 años más o menos, lo cual no es terrible. Si desea probar realmente en el futuro su nodo una unidad de 2 TB le dará suficiente espacio de almacenamiento para un buen 20 años de operación





## Tu propio Nodo

+ 
+ El tamaño actual de la base de datos de Bitcoin supera los 100GB y sigue creciendo cada día. Así que si intentas instalarte un Nodo de Bitcoin ten un poco de paciencia porque dependiendo de la velocidad de tu conexión de Internet, puedes tardar hora  s o incluso días e  n descargarla completamente. Asegúrate primero de tener mas de 100GB libres en tu disco duro.



¿Que necesitas para crear un nuevo nodo de Bitcoin y añadirlo a la red? Tan simple como instalar en tu PC de sobremesa un programa que puedes descargar de Internet. Si eres desarrollador de software, y quieres analizar su código fuente y compilarlo por ti mismo, lo tienes disponible en [este repositorio](https://github.com/bitcoin/bitcoin.git) de Github. Si lo único que quieres es descargar un binario precompilado y probarlo, lo tienes en [este enlace](https://bitcoin.org/es/descargar).

Asignas un wallet a ese nodo. Y eso es todo. Acabas de convertir a tu PC, a tu portátil, o incluso a tu Raspberry Pi, en un nuevo Nodo de la red Bitcoin. El software que has instalado se encargará del resto.




Para configurar el wallet en Bitcoin Core antes de empezar a minar, necesitas asegurarte de que Bitcoin Core esté instalado y correctamente sincronizado con la red de Bitcoin. A continuación se describen los pasos para configurar un wallet y comenzar a minar con Bitcoin Core:
Pasos para Configurar el Wallet en Bitcoin Core

    Instalación y Sincronización de Bitcoin Core:
        Descarga e instala Bitcoin Core desde el sitio web oficial.
        Inicia Bitcoin Core y permite que se sincronice completamente con la red de Bitcoin. Esto puede tardar algún tiempo, ya que necesita descargar toda la blockchain.

    Crear o Usar un Wallet:
        Bitcoin Core viene con un wallet integrado. Si es la primera vez que lo utilizas, se creará un wallet automáticamente.
        Si ya tienes un wallet, asegúrate de que esté cargado en Bitcoin Core.

    Obtener una Dirección de Bitcoin:
        Abre Bitcoin Core y ve a la pestaña "Recibir" para generar una nueva dirección de Bitcoin.
        Copia la dirección generada. Esta será la dirección a la que se enviarán las recompensas de minería.

    Configurar la Dirección de Recompensa en el Archivo de Configuración:
        Abre el archivo de configuración de Bitcoin Core (bitcoin.conf). Si no existe, créalo en el directorio de datos de Bitcoin Core.
        Añade la siguiente línea al archivo bitcoin.conf, reemplazando TU_DIRECCION con la dirección de Bitcoin que copiaste:

        makefile

        mineraddress=TU_DIRECCION

Ejemplo del archivo bitcoin.conf

El archivo bitcoin.conf puede encontrarse generalmente en:

    Windows: C:\Users\TuUsuario\AppData\Roaming\Bitcoin\
    macOS: ~/Library/Application Support/Bitcoin/
    Linux: ~/.bitcoin/

Ejemplo de un archivo bitcoin.conf con la dirección configurada:

conf

server=1
rpcuser=tu_usuario_rpc
rpcpassword=tu_contraseña_rpc
rpcport=8332
mineraddress=1A2b3C4d5E6f7G8h9I0jK1L2M3N4O5P6Q

Configuración para Minería

Para minar utilizando Bitcoin Core, necesitarás configurar tu software de minería para conectarse a tu nodo Bitcoin Core. Bitcoin Core no realiza minería directamente; en su lugar, puedes usar software de minería que se comunique con Bitcoin Core.

    Instalar Software de Minería:
        Descarga e instala software de minería como CGMiner, BFGMiner, o cualquier otro compatible.

    Configurar el Software de Minería:
        Configura tu software de minería para conectarse a tu nodo Bitcoin Core usando RPC (Remote Procedure Call).
        Proporciona los detalles del RPC (usuario, contraseña, dirección y puerto) que configuraste en bitcoin.conf.

Ejemplo de Configuración de CGMiner

sh

cgminer -o http://127.0.0.1:8332 -u tu_usuario_rpc -p tu_contraseña_rpc --coinbase-addr 1A2b3C4d5E6f7G8h9I0jK1L2M3N4O5P6Q

En este ejemplo, 127.0.0.1 es la dirección local donde Bitcoin Core está ejecutándose, 8332 es el puerto RPC, y 1A2b3C4d5E6f7G8h9I0jK1L2M3N4O5P6Q es la dirección de Bitcoin donde se enviarán las recompensas.
Conclusión

Configurar un wallet en Bitcoin Core antes de empezar a minar implica asegurarse de que tienes una dirección de Bitcoin para recibir las recompensas y configurar esa dirección en tu archivo bitcoin.conf. Luego, utiliza software de minería que se comunique con tu nodo Bitcoin Core para minar bloques y recibir recompensas en la dirección especificada.




## Coste de tener un nodo

Bitcoin Nodos tienen dos costos, su costo inicial de hardware, cubierto por debajo, y los costos actuales debidos a la energía e Internet. Los nodos completos se ejecutan generalmente en hardware de clase de escritorio, como un ordenador portátil viejo / mini-tránsito o en hardware de baja potencia, como un Raspberry Pi.

Un ordenador portátil o computadora de escritorio podría utilizar 15-30 kWh al mes, mientras que un Raspberry Pis sólo usará alrededor de 5-7 kWh por mes. Además, espere que su nodo use aproximadamente 20-50 GB de descarga y 30-200 GB de datos de carga al mes. Se recomendó tener una conexión de banda ancha sin límite de datos.

Si su poder cuesta por ejemplo $0.10 / kWh y ya paga por Internet, una estimación razonable podría significar que un nodo completo podría costar $0.50 $ 2 por mes para los costos de energía más lo que usted paga por el hardware cuesta por adelantado.










## Beneficios de ejecutar tu propio bitcoin node
  
 Aumento de la privacidad: Cuando se conecta a un nodo se conoce todos sus saldos y transacciones. Al ejecutar su propio nodo, esta información privada no será compartida con terceros
 Aumento de la seguridad: Cuando alguien le envía bitcoins su nodo completo verificará la transacción, así como toda la red Bitcoin asegurando que no se le ha alimentado información falsa o que se le envía bitcoins fraudulentos
 Para fortalecer el Bitcoin: Con cada nodo completo añadido, se incrementa la descentralización y la resiliencia de la red. Su nodo ejecuta su código y con esa elección de código, usted vota por cómo debe ejecutarse Bitcoin. Si se produce un cambio en Bitcoin Core y   no estás de acuerdo con ello, puedes elegir no actualizarte, votando con tu nodo y ayudando a fortalecerlo contra los ataques 

Para Ayudar a otros: Ejecutar tu propio nodo te permite que otros clientes ligeros (wallets) se conecten a ella y se beneficien de los beneficios de seguridad y privacidad mencionados anteriormente. Si usted tiene familia o amigos que no pueden dirigir su propio no  do, usted puede ayudarlos permitiéndoles conectarse con los tuyos

Para aprender: Mientras se ejecuta un nodo no requiere mucho esfuerzo, también puede sumérsión profunda en las muchas opciones y datos que tiene para aprender más sobre cómo funciona la propia Red Bitcoin

Para ejecutar software de procesamiento de pagos autónomos completos como BTCPay Server. Con este software libre puede recibir pagos de cualquier Bitcoin o Wallet relástre directamente a su nodo completo sin ningún tercero como un banco o Visa. Si eres un negocio e  sto significa que ya no tienes que esperar días o semanas para que tus fondos se liquiden, paguen honorarios ridículos a los bancos y se aseguren de que usted y sus clientes la información sea privada. pero le ahorrará mucho en las comisiones de transacción.







## Despedida

De momento esto es todo. Nos vemos en el proximo post.

Pulso la tecla ESC, dos puntos wq!



