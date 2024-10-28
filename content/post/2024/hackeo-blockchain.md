---
title: Hackeo de la blockchain
date: 2024-09-21
image: "/img/posts/hacker-blockchain.webp"
categories: ["criptomonedas"]
tags: [ "bitcoin", "blockchain"]
draft: false
featured: true
---

# Introducción

En el articulo anterior he explorado conceptos básicos sobre [la blockchain de Bitcoin](/posts/blockchain/).

Continuando con la secuencia de articulos sobre Bitcoin, en este articulo analizo un intento de hackeo de la blockchain protagonizado por un astuto hacker ruso con amplios conocimientos técnicos y una gran determinación. Veamos de lo que es capaz.

## El ataque

En una oscura habitación, un habilidoso hacker ruso se dispone a vulnerar la blockchain de Bitcoin. Tiene clara su estrategia: modificar la dirección de una transacción para redirigir los fondos a su propia dirección fraudulenta. ¿Podrá lograrlo?

### Merkle Root

Para llevar a cabo su plan, lo primero que hace es alterar la dirección de destino de una transacción, por ejemplo, la transacción TX_666 dentro del bloque número 58.

Al cambiar un solo bit de la transacción, debe recalcular el campo *Merkle Root*, que actúa como el resumen criptográfico de todas las transacciones (*TX_List*) dentro del bloque. El hacker ruso está un paso mas cerca de hackear la blockchain.

Aunque recalcular el campo *Merkle Root* mediante el algoritmo SHA-256 es sencillo en términos de costo computacional, esta modificación desata una cascada de problemas más complejos que tendrá que afrontar el hacker.

### Nonce

El cambio del *Merkle Root* altera directamente el hash SHA-256 de la cabecera del bloque. Esto significa que el campo *Nonce* del bloque deja de ser válido, ya que el hash del bloque debe cumplir con las condiciones impuestas por el campo *Difficulty*, es decir, tener una cantidad específica de ceros iniciales.

El hacker ruso, lejos de rendirse, sigue adelante.

Decide modificar el campo *Difficulty* para establecer un valor ridículamente bajo, como 1, lo que reduciría drásticamente la dificultad del problema criptográfico. En un entorno real, un cambio en el *Difficulty* sería detectado de inmediato por los nodos de la red, pero, por el momento, asumimos que ningún nodo se percata de esta alteración.

Con el *Difficulty* reducido, el hacker tiene un segundo para recalcular el *Nonce* antes de que el campo *Timestamp* (la marca de tiempo) cambie. Afortunadamente para él, con la dificultad tan baja, un segundo es más que suficiente para encontrar un *Nonce* que cumpla con las condiciones requeridas.

### Previous Hash

Sin embargo, alterar la cabecera de un bloque tiene efectos en cadena. Al modificar el hash de la cabecera, automáticamente se invalida el campo *Previous Hash* de todos los bloques posteriores en la blockchain.

El hacker empieza a darse cuenta de la magnitud del problema. Para que su ataque tenga éxito, no solo debe modificar el bloque objetivo, sino que también tiene que recalcular el Nonce de todos los bloques posteriores. Y todo ello tiene que hacerlo en menos de un segundo, lo cual requiere una capacidad computacional colosal, imposible de lograr.

### Ultimo bloque

Pese a las dificultades, el hacker no se da por vencido.

Decide cambiar de enfoque y atacar el bloque más nuevo creado en la blockchain. Al tratarse del último bloque, no necesitaría recalcular el *Nonce* de bloques posteriores, lo que facilita considerablemente su ataque.

Con sus potentes herramientas, logra modificar una transacción del último bloque y recalcula el Nonce de manera exitosa, cumpliendo con los requisitos del campo *Difficulty*. En su pantalla aparece el resultado esperado, y por un momento, cree haber triunfado.

### La descentralización

No obstante, el hacker comete un error fundamental: ha olvidado que la blockchain de Bitcoin no se controla por un solo nodo de Bitcoin. Miles de nodos distribuidos por todo el mundo se encargan de verificar continuamente la integridad de la red.

Poco después de intentar propagar su bloque modificado, los nodos de la red empiezan a comparar su copia del bloque con las versiones legítimas. La discrepancia es detectada casi de inmediato, y su bloque fraudulento es rechazado sin contemplaciones.

Con su ataque frustrado, el hacker se da cuenta de que no hay manera de vulnerar la blockchain sin tener el control de al menos el 51% de los nodos. Finalmente, acepta la derrota.

## Despedida

Este articulo ha analizado un intento de hackeo a la blockchain. Este ataque fallido ha ilustrado cómo la blockchain no solo es resistente a los intentos de manipulación, sino que también destaca la importancia de su naturaleza distribuida como la base de su seguridad.

La robustez del diseño descentralizado de la blockchain de Bitcoin garantiza que ningún actor malintencionado pueda alterar su integridad sin el consenso de la mayoría de la red.

En el próximo articulo voy a hablar sobre la minería de Bitcoin, un proceso fundamental para añadir bloques nuevos a la blockchain.

Siempre estoy atento al [canal de Telegram](https://t.me/lateclaescape) donde leo tus comentarios e intento resolver cualquier duda que tengas. Se aceptan criticas, sugerencias e incluso ideas para crear artículos nuevos.

Muchas gracias por leerme, y nos vemos en el próximo articulo.

Pulso la tecla ESC, dos puntos wq!
