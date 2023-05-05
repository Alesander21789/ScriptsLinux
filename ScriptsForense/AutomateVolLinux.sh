#!/bin/bash

# Script para analizar procesos, ficheros abiertos, sockets, conexiones de red, registros de eventos y otros detalles del sistema utilizando Volatility 2.6

# Verificar si Volatility está instalado
if ! command -v  python2.7 vol.py &> /dev/null
then
    echo -e "\033[34mVolatility no está instalado. Por favor, instale Volatility 2.6 antes de continuar.\033[0m"
    exit
fi


else
    # Verificar si el archivo de volcado de memoria existe
    if [ ! -f "$1" ]
    then
        echo -e "\033[34mEl archivo de volcado de memoria no existe. Por favor, proporcione un archivo válido.\033[0m"
        exit
    fi

    # Verificar si el perfil de LinuxUbuntu_5_4_0-148-generic_profilex está instalado
    if ! python2.7 vol.py --info | grep -q "LinuxUbuntu_5_4_0-148-generic_profilex64"
    then
        echo -e "\033[34mEl perfil de LinuxUbuntu_5_4_0-148-generic_profilex64 no está instalado. Por favor, instale el perfil antes de continuar.\033[0m"
        exit
    fi

    # Crear un directorio para guardar los archivos de salida
    if [ ! -d "volatility_output" ]
    then
        mkdir volatility_output
    fi

    # Definir una función para analizar cada tipo de información
    function analizar {
        echo -e "\033[34mAnalizando $1...\033[0m"
        python2.7 vol.py -f "$2" --profile LinuxUbuntu_5_4_0-148-generic_profilex64 $3 > volatility_output/$4.txt
    }

    # Analizar los procesos
    analizar "procesos" "$1" "pslist" "procesos"

    # Analizar los ficheros abiertos
    analizar "ficheros abiertos" "$1" "filescan" "ficheros_abiertos"

    # Analizar los sockets
    analizar "sockets" "$1" "sockets" "sockets"

    # Analizar las conexiones de red
    analizar "conexiones de red" "$1" "connections" "conexiones_red"

    # Analizar los registros de eventos
    analizar "registros de eventos" "$1" "evtlogs" "registros_eventos"

    # Analizar los controladores
    analizar "controladores" "$1" "driverscan" "controladores"

    # Analizar la actividad de red
    read -p "¿Desea analizar la actividad de red? (s/n) " respuesta
    if [ "$respuesta" == "s" ]
    then
        echo -e "\033[34mAnalizando la actividad de red...\033[0m"
         python2.7 vol.py -f "$1" --profile LinuxUbuntu_5_4_0-148-generic_profilex64 netscan > volatility_output/actividad_red.txt
    fi

    # Analizar la actividad del sistema de archivos
    read -p "¿Desea analizar la actividad del sistema de archivos? (s/n) " respuesta
    if [ "$respuesta" == "s" ]
    then
        echo -e "\033[34mAnalizando la actividad del sistema de archivos...\033[0m"
         python2.7 vol.py -f "$1" --profile LinuxUbuntu_5_4_0-148-generic_profilex64 filescan > volatility_output/actividad_archivos.txt
    fi

    # Analizar la actividad del registro del sistema
    read -p "¿Desea analizar la actividad del registro del sistema? (s/n) " respuesta
    if [ "$respuesta" == "s" ]
    then
        echo -e "\033[34mAnalizando la actividad del registro del sistema...\033[0m"
         python2.7 vol.py -f "$1" --profile LinuxUbuntu_5_4_0-148-generic_profilex64 printkey > volatility_output/actividad_registro.txt
    fi

    echo -e "\033[34mLos resultados se han guardado en el directorio volatility_output.\033[0m"

    # Generar un informe HTML
    read -p "¿Desea generar un informe HTML con los resultados? (s/n) " respuesta
    if [ "$respuesta" == "s" ]
    then
        echo -e "\033[34mGenerando informe HTML...\033[0m"
         python2.7 vol.py report -f "$1" --profile LinuxUbuntu_5_4_0-148-generic_profilex64 --output-file volatility_output/informe.html
    fi

    # Preguntar si se desea filtrar los archivos de salida por una palabra clave
    read -p "¿Desea filtrar los archivos de salida por una palabra clave? (s/n) " respuesta

    if [ "$respuesta" == "s" ]
    then
        # Pedir la palabra clave a buscar
        read -p "Por favor, introduzca la palabra clave: " palabra_clave

        # Filtrar los archivos de salida por la palabra clave y mostrar la salida en pantalla
        echo -e "\033[34mResultados de la búsqueda:\033[0m"
        grep -r "$palabra_clave" volatility_output/*.txt
    fi
fi
