#!/bin/bash

# Nos vamos al directorio donde tenemos la pagina estatica, en este caso es el directorio /home/francisco/Documentos/Implantacion/pagina_hugo

cd /home/francisco/pagina_hugo

# Generamos los elementos necesarios de nuestra pagina estatica.

hugo -D

# Añadimos todos los ficheros nuvos que hemos creado, en caso de que no haya ningun fichero que añadir no añadira nada.

git add *

# Nos pide que introduzcamos la descripcion del commit que vamos subir a nuestro repositorio en github

echo "Dime el mensaje del commit:"
read commit

# Crea el commit con el mensaje que hemos metido

git commit -m "$commit"
