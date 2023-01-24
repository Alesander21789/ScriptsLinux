#!/bin/bash

# Comprobar si se ha proporcionado un argumento (nombre del script)
if [ $# -eq 0 ]
then
    echo "No se ha proporcionado un argumento. Por favor, proporcione el nombre del script que desea a�adir al path."
    exit 1
fi

# Obtener la ruta absoluta del script proporcionado
script_path=$(readlink -f $1)

# Comprobar si el script existe
if [ ! -f "$script_path" ]
then
    echo "El script proporcionado no existe."
    exit 1
fi

# Obtener la variable de entorno PATH
path=$PATH

# A�adir la ruta del script al path (si ya no existe)
if [[ ":$path:" != *":$script_path:"* ]]
then
    export PATH="$script_path:$path"
    echo "Se ha a�adido el script al path."
    # Guardar la variable de entorno PATH en un archivo de configuraci�n
    echo "export PATH=$PATH" >> ~/.bashrc
    echo "Se ha guardado la variable de entorno PATH en el archivo de configuraci�n."
else
    echo "El script ya se encuentra en el path."
fi
