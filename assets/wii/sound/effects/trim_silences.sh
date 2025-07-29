#!/bin/bash

# Recorre todos los archivos MP3 en la carpeta actual
for file in *.mp3; do
    # Verifica si hay archivos MP3
    if [[ -f "$file" ]]; then
        echo "Procesando: $file"

        # Crea un nombre temporal para el archivo procesado
        temp_file="temp_$file"

        # Usa ffmpeg con silenceremove para eliminar silencios al inicio y final con umbral de -50dB
        ffmpeg -i "$file" -af "silenceremove=start_periods=1:start_duration=0:start_threshold=-50dB, silenceremove=stop_periods=1:stop_duration=0:stop_threshold=-50dB" -y "$temp_file"

        # Verifica si ffmpeg se ejecutó correctamente
        if [[ $? -eq 0 ]]; then
            # Reemplaza el archivo original con el procesado
            mv "$temp_file" "$file"
            echo "Completado: $file"
        else
            echo "Error al procesar: $file"
            rm -f "$temp_file"
        fi
    fi
done

echo "Proceso finalizado."
