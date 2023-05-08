#!/bin/bash

# Reemplaza estas variables con la ruta de tu imagen EWF y el punto de montaje deseado
EWF_IMAGE_PATH="/ruta/a/tu/imagen.ewf"
MOUNT_POINT="/ruta/al/punto/de/montaje"

# Monta la imagen EWF
EWF_MOUNT_TMP="$(mktemp -d)"
sudo ewfmount "$EWF_IMAGE_PATH" "$EWF_MOUNT_TMP"

# Obtiene el dispositivo loop asociado
LOOP_DEVICE=$(sudo losetup --show -f -P "${EWF_MOUNT_TMP}/ewf1")

# Monta el dispositivo loop en el punto de montaje
sudo mkdir -p "$MOUNT_POINT"
sudo mount -o ro "${LOOP_DEVICE}p1" "$MOUNT_POINT"

echo "Imagen EWF montada en $MOUNT_POINT"

# Desmonta la imagen EWF y el dispositivo loop al salir
cleanup() {
    sudo umount "$MOUNT_POINT"
    sudo losetup -d "$LOOP_DEVICE"
    sudo umount "$EWF_MOUNT_TMP"
    rm -r "$EWF_MOUNT_TMP"
}

trap cleanup EXIT
