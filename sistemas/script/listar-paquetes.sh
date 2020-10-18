#!/bin/bash

#En el siguiente script vamos a conseguir la lista de paquetes instalados introduciendo como parametro el repositorio que queremos
#consultar.

#Definimos la variable repo que es donde vamos a guardar el parametro de entrada de nuestro script, en este caso sera el repositorio
#que vamos a consultar.

repo=$1

#En esta parte es donde vamos a difenciar las dos formas de consultar los paquetes que tenemos ya que podemos introdocir el repositorio
#de dos formas distintas.

#Si introducimos el repositorio con http://(nombre-repositorio) comprobara el parametro que hemos introducido Ej: http://deb.debian.org

if [[ $var1 == *"http"* ]]; then #comprobamos si empieza por la cadena http://
    repo="${repo:7}" #guardamos en la variable repo el parametro sin la cadena inicial http://

    for p in $(dpkg -l | grep '^ii' | cut -d ' ' -f 3);
    do 
    apt-cache showpkg $p | head -3 | grep -v '^Versions' | paste - - ; done | grep $repo | awk '{print $2}' 

#Si la cadena no empieza por http:// no hacemos la comprobacion y entramos en el codigo para la consulta de los paquetes Ej: security.debian.org.

else
    for p in $(dpkg -l | grep '^ii' | cut -d ' ' -f 3);
    do 
    apt-cache showpkg $p | head -3 | grep -v '^Versions' | paste - - ; done | grep $repo | awk '{print $2}'
fi
