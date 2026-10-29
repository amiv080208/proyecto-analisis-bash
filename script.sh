#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: ./script.sh <archivo.zip> <directorio_destino>"
    exit 1
fi
temporal=$(bash validacion.sh "$1" "$2")
if [ $? -ne 0 ]; then
    echo "Error: falló la validación o descompresión del ZIP."
    exit 1
fi
echo "Organizando archivos..."

if ! bash organizar.sh "$temporal" "$2"; then
    echo "Error: no se pudieron organizar los archivos."
    exit 1
fi

echo "Archivos organizados correctamente."

trap 'rm -rf -- "$temporal"' EXIT

echo "Archivos organizados correctamente."

echo "Iniciando auditoría de archivos Python..."

if ! bash auditoria.sh "$2"; then
    echo "Error: falló la auditoría."
    exit 1
fi

echo "Proyecto finalizado correctamente."
