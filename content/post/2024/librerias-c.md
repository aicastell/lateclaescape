---
title: Librerías en C
date: 2024-01-19
image: /img/posts/la-tecla-esc.jpg
categories: [ "tecnología" ]
tags: [ "lenguaje C", "libreria" ]
draft: true
featured: true
---



 Organizar un proyecto en C con librerias
Los programadores newbies en Linux podeis aprovechar este post para aprender a compilar y a usar vuestras librerías en C. Encontrareis muchos manuales en Internet mucho mas extensos y elaborados que este, pero yo lo que quiero transmitiros son conocimientos de forma rapida, para que lo pilleis a la primera sin necesidad de que perdais mucho tiempo. Así que, sin anestesia, nos ponemos manos a la obra:



Información de background

Segun programamos, encontramos funciones que se usan en muchas partes de nuestro codigo. Nos interesa tenerlas en un directorio separado, compiladas y listas para poder usarlas siempre que queramos. Las ventajas de esto son enormes:
- Evitamos los continuos copy/paste (código mas compacto)
- Reducimos tiempo de compilacion (solo se compilan una vez)
- Aumentamos fiabilidad con el tiempo de uso (mas probadas, menos bugs)

La librería estara compuesta por uno o mas ficheros .c fuentes y uno o mas ficheros .h de cabeceras. Veamos un ejemplo:

$ cat milib.h
#ifndef _MI_LIB_H
#define _MI_LIB_H
int suma(int a, int b);
int resta(int a, int b);
#endif

$ cat milib.c
int suma(int a, int b) { return a+b; }
int resta(int a, int b) { return a-b; }



Librerías estáticas vs librerías dinámicas

En linux podemos hacer dos tipos de librerías:
- Librerias estáticas
- Librerias dinámicas

Las librerías estaticas se añaden a la imagen de nuestro ejecutable. Una vez hecha esta operación, la librería puede borrarse y el código sigue funcionando, ya que nuestro binario resultante contiene todo lo que necesita de la librería.

Las librerías dinámicas no se añaden a la imagen de nuestro ejecutable. El ejecutable debe buscar la librería siempre que la necesite, y por tanto, la librería dinámica no puede borrarse, o nuestro programa dejaría de funcionar.

La elección del tipo de librería que debeis usar depende de la naturaleza del proyecto desarrollado. Es una eleccion en la que debeis valorar ventajas e inconvenientes, y llegar a un compromiso entre ambas:
- Ejecutable estatico ocupa mas espacio
- Ejecutable estatico es mas facil de instalar en otro PC
- Ejecutable estatico es mas rapido
- Ejecutable dinamico aprovecha mejoras de la librería compatible con el código del programa
- Ejecutable dinamico requiere refactorización con cambios incompatibles

En Linux (en general Unix) las librerías estáticas se nombran con la extension .a (libmia.a) y las librerías dinámicas se nombran con la extension .so (libmia.so).

Receta para construir y usar una librería estática

Partimos de nuestro programa miprograma.c y de los fuentes de nuestra libreria milib.c.

$ cat miprograma.c
#include 
int main(void) {
    printf("%d\n", suma(10,10));
    printf("%d\n", resta(10,10));
}



Veamos los pasos necesarios para construir y hacer uso de una librería estática:
- Obtener los ficheros objeto .o de todos los fuentes .c de nuestra libreria

$ gcc -c milib.c -o milib.o


- Crear la libreria .a

$ ar -rv libmia.a milib.o


- Compilar nuestro programa, linkando con la libreria estatica

$ gcc -o miprograma miprograma.c -I. -L. -Bstatic -lmia


Observar que -Bstatic -lmia indica que se debe coger la libreria libmia.a. El prefijo lib y la extension .a ya las pone automaticamente el compilador gcc. La opción -Bstatic afecta a todas las librerías que van detrán en la línea de compilación.

Receta para compilar y usar una librería dinámica

Partimos de nuestro programa miprograma.c y de los fuentes de nuestra libreria milib.c. Veamos los pasos necesarios para construir y hacer uso de una librería dinámica:
- Obtener los ficheros objeto .o de todos los fuentes .c de nuestra libreria

$ gcc -c milib.c -o milib.o


- Crear la libreria .so

$ ld -o libmia.so milib.o -shared


- Compilar nuestro programa, linkando con la libreria dinámica

$ gcc -o miprograma miprograma.c -I. -L. -Bdynamic -lmia


Observar que -Bdynamic -lmia indica que se debe coger la libreria libmia.so El prefijo lib y la extension .so ya las pone automaticamente el compilador gcc. La opción -Bdynamic afecta a todas las librerías que van detrán en la línea de compilación.

El comando ldd sirve para ver las librerias dinamicas con las que se ha linkado un programa. Por ejemplo:

$ ldd miprograma
linux-gate.so.1 =>  (0xbfffe000)
libmia.so => not found
libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0xb7e6f000)
/lib/ld-linux.so.2 (0xb7faa000)


Como vemos en el ejemplo, el programa no encuentra la libreria libmia.so. Hay que decirle al programa donde estan las librerías dinámicas. Para ello definimos la variable de entorno LD_LIBRARY_PATH de esta manera:

$ export LD_LIBRARY_PATH=/path/a/miprograma
$ ldd miprograma
linux-gate.so.1 =>  (0xbfffe000)
libmia.so => /path/a/miprograma/libmia.so (0xb7f2f000)
libc.so.6 => /lib/tls/i686/cmov/libc.so.6 (0xb7df7000)
/lib/ld-linux.so.2 (0xb7f34000)



Cierre del post

Es hora de que practiqueis vosotros, os tomeis un tiempo para probar este ejemplo y asimilar los conceptos, y empeceis a aplicar estos conocimientos en vuestros futuros proyectos.

Yo me despido del blog hasta despues del verano. Hoy cumplo 33 años y quiero aprovechar la ocasión para dedicarle este post a todos mis lectores, y en especial a aquellos que se acuerden de felicitarme. Os agradezco a todos las felicitaciones, pero yo lo que quiero son regalos little bit frikies! ;-) Que paseis un buen verano y nos leemos en Septiembre! :-) 1
