---
title: La transacción coinbase
date: 2024-07-26
image: "/img/posts/bitcoin-consensus-mechanism.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "bloque de transacciones", "mempool" ]
draft: true
featured: true
---


La transaction coinbase es especial, la que introduce bitcoin nuevos en la red tras cada bloque minado. Por tanto, hablar sobre ella cuando proceda.


+ A diferencia de las transacciones normales que transfieren Bitcoin entre usuarios, la transacción coinbase es la primera transacción dentro de cada bloque de Bitcoin y tiene características únicas:
+ 
+ 
+ Creación de Nuevos Bitcoin: La transacción coinbase es la única manera en la que se crean nuevos Bitcoin. Es la transacción que otorga la recompensa por bloque al minero que resuelve el problema criptográfico y añade un nuevo bloque a la cadena. Esta recompensa incluye   una cantidad fija de nuevos Bitcoin, que es cómo se introducen nuevas monedas en circulación.
+ 
+ 
+ Recompensa por Bloque: La recompensa por bloque consta de dos partes:
+ 
+     Subsidio de Bloque: Esta es la cantidad fija de nuevos Bitcoin creados y otorgados al minero. El subsidio se reduce a la mitad aproximadamente cada cuatro años en un evento llamado "halving". Actualmente, el subsidio es de 6.25 Bitcoin por bloque (después del últim  o halving en 2020). 
+     Tarifas de Transacción: Además del subsidio, el minero también recibe todas las tarifas asociadas con las transacciones incluidas en el bloque. Estas tarifas son pagadas por los usuarios que realizan transacciones y se suman a la recompensa total que recibe el mine  ro.
+ 
+ Sin Entradas Previas: A diferencia de las transacciones regulares que requieren entradas (outputs no gastados de transacciones anteriores), la transacción coinbase no tiene entradas previas. En su lugar, se crea de la nada, lo que simboliza la creación de nuevos Bitcoi  n.
+ 
+ 
+ Campo de Datos Extra: La transacción coinbase también incluye un campo especial llamado "coinbase data" o "scriptSig". Este campo puede contener datos arbitrarios y a menudo se utiliza para identificar al minero o incluir mensajes. En el bloque génesis (el primer bloqu  e de Bitcoin), por ejemplo, Satoshi Nakamoto incluyó un mensaje en el campo coinbase: "The Times 03/Jan/2009 Chancellor on brink of second bailout for banks."
+ 
+ 
+ Importancia en la Blockchain: La transacción coinbase es esencial porque inicia el proceso de validación del bloque. Sin ella, no habría incentivo para que los mineros continuaran asegurando la red y procesando transacciones. Es un mecanismo clave que asegura que los m  ineros sean recompensados por su trabajo.
+ 



+ 
+     Creación de Nuevos Bitcoin: La transacción coinbase es la única manera en la que se crean nuevos Bitcoin. Es la transacción que otorga la recompensa por bloque al minero que resuelve el problema criptográfico y añade un nuevo bloque a la cadena. Esta recompensa inc  luye una cantidad fija de nuevos Bitcoin, que es cómo se introducen nuevas monedas en circulación.
+ 
+     Recompensa por Bloque: La recompensa por bloque consta de dos partes:
+     ¦   Subsidio de Bloque: Esta es la cantidad fija de nuevos Bitcoin creados y otorgados al minero. El subsidio se reduce a la mitad aproximadamente cada cuatro años en un evento llamado "halving". Actualmente, el subsidio es de 6.25 Bitcoin por bloque (después del ú  ltimo halving en 2020).
+     ¦   Tarifas de Transacción: Además del subsidio, el minero también recibe todas las tarifas asociadas con las transacciones incluidas en el bloque. Estas tarifas son pagadas por los usuarios que realizan transacciones y se suman a la recompensa total que recibe el   minero. 
+ 
+     Sin Entradas Previas: A diferencia de las transacciones regulares que requieren entradas (outputs no gastados de transacciones anteriores), la transacción coinbase no tiene entradas previas. En su lugar, se crea de la nada, lo que simboliza la creación de nuevos Bi  tcoin.
+ 
+     Campo de Datos Extra: La transacción coinbase también incluye un campo especial llamado "coinbase data" o "scriptSig". Este campo puede contener datos arbitrarios y a menudo se utiliza para identificar al minero o incluir mensajes. En el bloque génesis (el primer b  loque de Bitcoin), por ejemplo, Satoshi Nakamoto incluyó un mensaje en el campo coinbase: "The Times 03/Jan/2009 Chancellor on brink of second bailout for banks." 
+ 
+     Importancia en la Blockchain: La transacción coinbase es esencial porque inicia el proceso de validación del bloque. Sin ella, no habría incentivo para que los mineros continuaran asegurando la red y procesando transacciones. Es un mecanismo clave que asegura que l  os mineros sean recompensados por su trabajo.
+ 
+ Resumen:
+ 
+ La transacción coinbase es un elemento crucial en la arquitectura de Bitcoin, proporcionando a los mineros la recompensa que motiva el procesamiento de transacciones y el mantenimiento de la red. Al crear nuevos Bitcoin y distribuir las tarifas de transacción, la trans  acción coinbase asegura que el sistema permanezca operando de manera descentralizada y segura. 



