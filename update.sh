#!/bin/bash

# Configuración
repo="carjavi/releases-manager-git"  # ← Cambia esto por tu repositorio real
archivo="install_file.sh"
archivo_tmp="/tmp/$archivo"

# Verificar conexión a GitHub
echo "Verificando conexión a Internet..."
if ! curl -s --head https://github.com | grep "200 OK" > /dev/null; then
    echo "❌ No hay conexión a GitHub. Verifica tu conexión a Internet."
    exit 1
fi

# Obtener todos los tags (versiones)
tags=$(curl -s "https://api.github.com/repos/$repo/tags" | grep -Po '"name": "\K.*?(?=")')
if [ -z "$tags" ]; then
    echo "❌ No se encontraron versiones (tags) en el repositorio."
    exit 1
fi

# Determinar la versión más reciente (primer tag en la lista)
latest_tag=$(echo "$tags" | head -n 1)

# Mostrar menú para elegir versión
echo "✅ Conectado. Estas son las versiones disponibles:"
select tag in $tags; do
    if [ -n "$tag" ]; then
        echo "Versión seleccionada: $tag"
        break
    else
        echo "Opción inválida. Intenta de nuevo."
    fi
done

# Comparar con la última versión
if [ "$tag" != "$latest_tag" ]; then
    echo "⚠️ Has seleccionado una versión anterior: $tag"
    echo "ℹ️ La versión más reciente disponible es: $latest_tag"
else
    echo "✅ Estás instalando la última versión disponible."
fi

# Descargar archivo install.sh desde esa versión
url="https://raw.githubusercontent.com/$repo/$tag/$archivo"
wget -q "$url" -O "$archivo_tmp"

# Verificar descarga
if [ ! -s "$archivo_tmp" ]; then
    echo "❌ Error al descargar el archivo: $url"
    exit 1
fi

# Dar permisos y ejecutar
chmod +x "$archivo_tmp"
echo "▶️ Ejecutando instalación..."
"$archivo_tmp"
status=$?

# Borrar archivo si fue exitoso
if [ $status -eq 0 ]; then
    echo "✅ Instalación exitosa. Eliminando archivo temporal..."
    rm -f "$archivo_tmp"
else
    echo "❌ La instalación falló. El archivo no será eliminado: $archivo_tmp"
fi
