#!/bin/bash

# Script para eliminar espacios de todos los archivos en el directorio actual

# Habilitar manejo de nombres con espacios en los for loops
IFS=$'\n'

echo "Procesando archivos en el directorio actual..."

# Recorrer todos los archivos del directorio actual
for archivo in *; do
    # Verificar que es un archivo (no directorio) y que no es este script
    if [ -f "$archivo" ] && [ "$archivo" != "${0##*/}" ]; then
        # Eliminar todos los espacios del nombre
        nuevo_nombre=$(echo "$archivo" | tr -d ' ')
        
        # Solo renombrar si el nombre cambió
        if [ "$archivo" != "$nuevo_nombre" ]; then
            # Verificar si ya existe un archivo con el nuevo nombre
            if [ -e "$nuevo_nombre" ]; then
                echo "¡Advertencia: No se puede renombrar '$archivo' a '$nuevo_nombre' porque ya existe!"
            else
                mv -v "$archivo" "$nuevo_nombre"
            fi
        fi
    fi
done

echo "Proceso completado."

# Restaurar IFS por defecto
unset IFS