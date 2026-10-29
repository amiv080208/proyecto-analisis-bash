#!/bin/bash

temporal=$1
destino=$2

if [ $# -ne 2 ]; then
    echo "Uso: bash organizacion.sh <carpeta_temporal> <destino>"
    exit 1
fi

if [ ! -d "$temporal" ]; then
    echo "Error: la carpeta temporal no existe"
    exit 1
fi

mkdir -p "$destino/py"
mkdir -p "$destino/txt"
mkdir -p "$destino/jpg"
mkdir -p "$destino/pdf"
mkdir -p "$destino/otros"
mkdir -p "$destino/png"
mkdir -p "$destino/csv"
mkdir -p "$destino/jpeg"

find "$temporal" -type f \
    ! -path "*/__MACOSX/*" \
    ! -name ".DS_Store" \
    ! -name "._*" \
    -print0 | while IFS= read -r -d '' archivo
do
    nombre=$(basename "$archivo")
    extension="${nombre##*.}"
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    case "$extension" in
        py|txt|jpg|jpeg|png|csv|pdf)
            carpeta="$extension"
            ;;
        *)
            carpeta="otros"
            ;;
    esac

    cp "$archivo" "$destino/$carpeta/"
done
