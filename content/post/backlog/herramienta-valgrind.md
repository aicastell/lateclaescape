---
title: La herramienta valgrind
date: 2024-01-19
image: "/img/posts/la-tecla-esc.jpg"
categories: [ "tools" ]
tags: [ "valgrind" ]
draft: true
featured: true
---




 Usando valgrind + memcheck como debugger
Linus Torvalds declaró en este post su postura contraria al uso de debuggers en el kernel, argumentando que son herramientas usadas por los malos desarrolladores que, lejos de aprender de sus errores, se concentran en resolver el problema sin profundizar en la causa real del error. Y por tanto, prefiere mantenerlos lejos del desarrollo del kernel. Desde luego que tiene mucha razón (palabra de Linus).

Mi postura, no tan radical, aunque totalmente de acuerdo con sus argumentos. Es deseable desarrollar con sumo cuidado e intentar evitar todos los fallos durante la codificación, pues detectarlos a posteriori en ocasiones puede ser complicado. Sin embargo, puede que tengamos que analizar algun core de código que no hemos escrito nosotros. Y en una línea que nunca en la vida debería fallar. ¿Que esta ocurriendo?. ¿Que hacemos ahora? Es en estos casos cuando necesitamos ayuda de lo que yo llamo "las fuerzas especiales".


En este post os voy a explicar como usar el debugger valgrind con la herramienta memcheck para detectar 5 errores comunes en la programación de C/C++. Lo vemos en estos 5 test:

Test 1: Detección de una perdida de memoria:

03 int main()
04 {
05     char *x = malloc(100); /* memory leak */
06     return 0;
07 }
$ gcc -g test1.c -o test1
$ valgrind --tool=memcheck --leak-check=yes ./test1
==8458== 100 bytes in 1 blocks are definitely lost in loss record 1 of 1
==8458==    at 0x4C265AE: malloc (vg_replace_malloc.c:207)
==8458==    by 0x40051D: main (test1.c:5)



Test 2: Detectar escrituras fuera de los limites de la memoria reservada:

03 int main()
04 {
05     char *x = malloc(10);
06     x[10] = 'a'; /* write out of bounds */
07     return 0;
08 }
$ gcc -g test2.c -o test2
$ valgrind --tool=memcheck --leak-check=yes ./test2
==17039== Invalid write of size 1
==17039==    at 0x40052A: main (test2.c:6)
==17039==  Address 0x519d03a is 0 bytes after a block of size 10 alloc'd
==17039==    at 0x4C265AE: malloc (vg_replace_malloc.c:207)
==17039==    by 0x40051D: main (test2.c:5)



Test 3: Detectar el uso de variables sin inicializar:

03 int main()
04 {
05     int x;
06     if (x == 0) /* uninitialised variable */
07         printf("x is zero");
08     return 0;
09 }
$ gcc -g test3.c -o test3
$ valgrind --tool=memcheck --leak-check=yes ./test3
==17070== Conditional jump or move depends on uninitialised value(s)
==17070==    at 0x400518: main (test3.c:6)



Test 4: Intentar liberar una zona de memoria que no ha sido reservada:

03 int main(void)
04 {
05     char * str;
06     free(str); /* free not allocated */
07     return 0;
08 }
$ gcc -g test4.c -o test4
$ valgrind --tool=memcheck --leak-check=yes ./test4
==17092== Conditional jump or move depends on uninitialised value(s)
==17092==    at 0x4C25265: free (vg_replace_malloc.c:323)
==17092==    by 0x40051C: main (test4.c:6)



Test 5: delete en C++ mal hecho:

01 int main(void)
02 {
03     char * str = new char[10];
04     delete str; // instead of: delete [] v;
05     return 0;
06 }
$ g++ -g test5.c -o test5
$ valgrind --tool=memcheck --leak-check=yes ./test5
==17116== Mismatched free() / delete / delete []
==17116==    at 0x4C24DAD: operator delete(void*) (vg_replace_malloc.c:342)
==17116==    by 0x40067A: main (test5.cpp:4)



Hemos visto que valgrind es una herramienta de mucha ayuda para un desarrollador de C/C++ que sin duda nos ayudará a resolver muchos bugs. No obstante, tambien tiene sus limitaciones, por ejemplo que memcheck no comprueba los limites en los arrays estaticos, y por tanto no detecta este error:

01 int main()
02 {
03     char x[10];
04     x[11] = 'a'; /* not detected! */
05     return 0;
06 }



No obstante, debemos recordar las palabras de Linus. Los debugger son para los malos programadores. Y nosotros queremos ser buenos programadores. Asi que debemos aprender de nuestros errores e intentar que no vuelvan a repetirse en el futuro. Si seguis estos consejos, los debuggers tienen los días contados :-) En todo caso, para mi, el mejor debugger que ha existido y que siempre existirá es el printf (en C) o el cout (en C++). 
