
#!/bin/bash
destino=$1
analizados=0
archivos_cv2=0
archivos_pyside6=0

echo ""
echo " AUDITORÍA DE CÓDIGO PYTHON"
echo ""

# Buscar los archivos .py de la carpeta codigo.
while IFS= read -r -d '' archivo; do

    analizados=$((analizados + 1))

    echo ""
    echo "Archivo: $archivo"

    # Buscar cv2.
    echo "Coincidencias con cv2:"

    if grep -n -F -- "cv2" "$archivo"; then
        echo "Resultado: se encontró cv2."
        archivos_cv2=$((archivos_cv2 + 1))
    else
        resultado=$?

        if [ "$resultado" -eq 1 ]; then
            echo "Resultado: no se encontró cv2."
        else
            echo "Error: no se pudo leer el archivo al buscar cv2."
        fi
    fi

    # Buscar PySide6.
    echo "Coincidencias con PySide6:"

    if grep -n -F -- "PySide6" "$archivo"; then
        echo "Resultado: se encontró PySide6."
        archivos_pyside6=$((archivos_pyside6 + 1))
    else
        resultado=$?

        if [ "$resultado" -eq 1 ]; then
            echo "Resultado: no se encontró PySide6."
        else
            echo "Error: no se pudo leer el archivo al buscar PySide6."
        fi
    fi

done < <(find "$destino/py" -type f -name '*.py' -print0)

echo ""
echo " RESUMEN FINAL"
echo ""

echo "Archivos Python analizados: $analizados"
echo "Archivos que contienen cv2: $archivos_cv2"
echo "Archivos que contienen PySide6: $archivos_pyside6"

echo ""
echo "Directorio de resultados: $destino"

# Informar si hubo problemas durante la clasificación.

echo "Proceso completado correctamente."
exit 0
