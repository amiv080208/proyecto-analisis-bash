if [ $# -ne 2 ]; then
    echo "Uso: ./script.sh <archivo.zip> <directorio_destino>"
    exit 1
fi
archivo_zip=$1
destino=$2
if [ ! -f "$archivo_zip" ]; then
    echo "Error: el archivo ZIP no existe"
    exit 1
fi
temporal=$(mktemp -d)
if ! unzip -q "$archivo_zip" -d "$temporal"; then
    echo "Error: no se pudo descomprimir el ZIP"
    exit 1
fi
echo "$temporal"
