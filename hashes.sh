#!/bin/bash

echo "Inicio: $(date)"

counter=0

read -p "Ingrese el nombre del archivo: " file
read -p "Ingrese la ruta de la carpeta donde se guardarán los archivos: " folder
ext=".txt"

if [ ! -f "$file" ]; then
    echo "El archivo no existe"
    exit 1
fi

if [ ! -d "$folder" ]; then
    echo "La carpeta no existe"
    exit 1
fi

md5() {
    counter=$((counter+1))
    echo "Calculando md5 ($counter): ["
    {
        time md5sum "$file" | cut -d ' ' -f 1
    } | pv -l -s $(stat -c %s "$file") > "$folder/$file.md5$ext"
    echo "] Done!"
}

sha1() {
    counter=$((counter+1))
    echo "Calculando sha1 ($counter): ["
    {
        time sha1sum "$file" | cut -d ' ' -f 1
    } | pv -l -s $(stat -c %s "$file") > "$folder/$file.sha1$ext"
    echo "] Done!"
}

sha256() {
    counter=$((counter+1))
    echo "Calculando sha256 ($counter): ["
    {
        time sha256sum "$file" | cut -d ' ' -f 1
    } | pv -l -s $(stat -c %s "$file") > "$folder/$file.sha256$ext"
    echo "] Done!"
}

sha512() {
    counter=$((counter+1))
    echo "Calculando sha512 ($counter): ["
    {
        time sha512sum "$file" | cut -d ' ' -f 1
    } | pv -l -s $(stat -c %s "$file") > "$folder/$file.sha512$ext"
    echo "] Done!"
}

md5
echo ""
sha1
echo ""
sha256
echo ""
sha512

echo "Total de cálculos de hash: $counter"
echo "Final: $(date)"
