#!/bin/bash

# Reemplaza esto con la ruta a tu imagen de RAM de Linux
RAM_IMAGE="./imagenesRam/uno.lime"

# Reemplaza esto con el perfil apropiado para tu imagen de RAM de Linux
PROFILE="LinuxUbuntu_5_4_0-148-generic_profilex64"

RUTA_VOLATILITY="."

# Verificar si Volatility está instalado
if ! command -v $RUTA_VOLATILITY python2.7 vol.py &> /dev/null
then
    color_rojo="\033[91m"
    color_normal="\033[0m"
    echo -e "${color_rojo}Volatility no está instalado. Por favor, instale Volatility 2.6 antes de continuar.${color_normal}"
    exit
fi

# Comprueba si la imagen de RAM y la ruta de Volatility existen
if [ ! -f "$RAM_IMAGE" ]; then
  color_rojo="\033[91m"
  color_normal="\033[0m"
  echo -e "${color_rojo}El archivo de volcado de memoria no existe. Por favor, proporcione un archivo válido.${color_normal}"
  exit 1
fi

# Verificar si el perfil de LinuxUbuntu_5_4_0-148-generic_profilex está instalado
if ! python2.7 vol.py --info | grep -q "LinuxUbuntu_5_4_0-148-generic_profilex64"
then
    color_rojo="\033[91m"
    color_normal="\033[0m"
    echo -e "${color_rojo}El perfil de LinuxUbuntu_5_4_0-148-generic_profilex64 no está instalado. Por favor, instale el perfil antes de continuar.${color_normal}"
    exit
fi

# Crear un directorio para guardar los archivos de salida
if [ ! -d "$RUTA_VOLATILITY" ]
then
    mkdir $RUTA_VOLATILITY
fi

# Comandos de Volatility
volatility_commands=(
  "linux_pslist"
  "linux_psaux"
  "linux_pstree"
  "linux_netstat"
  "linux_bash"
  "linux_lsmod"
  "linux_mount"
  "linux_find_file"
  "linux_proc_maps"
  "linux_dump_map"
)

# Crea un directorio para guardar los resultados
mkdir -p volatility_results

# Ejecuta los comandos de Volatility
for cmd in "${volatility_commands[@]}"; do
  color_azul="\033[94m"
  color_normal="\033[0m"
  echo -e "${color_azul}Ejecutando: $cmd${color_normal}"
  resultado=$(python2.7 vol.py -f "$RAM_IMAGE" --profile="$PROFILE" "$cmd")
  salida=$(echo "$resultado" | grep --color=auto "$cmd\|<palabra clave>")
  echo "$salida" | tee -a "$RUTA_VOLATILITY/output_$cmd.txt"
  echo -e "${color_azul}Resultado guardado en: $RUTA_VOLATILITY/output_$cmd.txt${color_normal}"
  echo ""
done

# Generar un informe HTML
read -p "${color_azul}¿Desea generar un informe HTML con los resultados? (s/n) ${color_normal}" respuesta
if [ "$respuesta" == "s" ]
then
    echo -e "${color_azul}Generando informe HTML...${color_normal}"
    python2.7 vol.py report -f "$1" --profile LinuxUbuntu_5_4_0-148-generic_profilex64 --output-file volatility_output/informe.html
fi

# Preguntar si se desea filtrar los archivos de salida por una palabra clave
read -p "${color_azul}¿Desea filtrar los archivos de salida por una palabra clave? (s/n) ${color_normal}" respuesta

if [ "$respuesta" == "s" ]
then
    # Pedir la palabra clave a buscar
    read -p "${color_azul}Por favor, introduzca la palabra clave: ${color_normal}" palabra_clave

    # Filtrar los archivos de salida por la palabra clave y guardar la salida en un archivo
    echo -e "${color_azul}Resultados de la búsqueda:${color_normal}"
    grep -r "$palabra_clave" $RUTA_VOLATILITY/*.txt | tee filtrado.txt
fi

echo -e "${color_azul}Análisis de Volatility completado.${color_normal}"
