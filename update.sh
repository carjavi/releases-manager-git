#!/bin/bash

# Configuración
repo="carjavi/releases-manager-git"  # ← Cambia esto por tu repositorio real
archivo="install_file.sh"
archivo_tmp="/tmp/$archivo"

# Verificar conexión a raw.githubusercontent.com
echo "Verificando acceso a raw.githubusercontent.com..."
if ! curl -s https://raw.githubusercontent.com > /dev/null; then
    echo "❌ No se puede acceder a raw.githubusercontent.com. Revisa tu conexión o firewall."
    exit 1
fi

# Obtener todas las versiones (tags)
tags=$(curl -s "https://api.github.com/repos/$repo/tags" | grep -Po '"name": "\K.*?(?=")')
if [ -z "$tags" ]; then
    echo "❌ No se encontraron versiones en el repositorio."
    exit 1
fi

# Determinar la versión más reciente
latest_tag=$(echo "$tags" | head -n 1)

# Mostrar menú
echo "Selecciona una versión para instalar:"
select tag in $tags; do
    if [ -n "$tag" ]; then
        echo "Versión seleccionada: $tag"
        break
    else
        echo "Opción inválida. Intenta de nuevo."
    fi
done

# Avisar si no es la última
if [ "$tag" != "$latest_tag" ]; then
    echo "⚠️  Has seleccionado una versión anterior ($tag). Última versión disponible: $latest_tag"
else
    echo "✅ Estás instalando la última versión."
fi

# Descargar install.sh desde el tag seleccionado
url="https://raw.githubusercontent.com/$repo/$tag/$archivo"
wget -q "$url" -O "$archivo_tmp"

# Verificar descarga
if [ ! -s "$archivo_tmp" ]; then
    echo "❌ Error al descargar el archivo desde: $url"
    exit 1
fi

# Dar permisos de ejecución
chmod +x "$archivo_tmp"

# Ejecutar como superusuario
echo "▶️ Ejecutando instalación como superusuario..."
sudo "$archivo_tmp"
status=$?

# Borrar si fue exitoso
if [ $status -eq 0 ]; then
    echo "✅ Instalación completada. Eliminando archivo temporal..."
    rm -f "$archivo_tmp"
else
    echo "❌ Instalación fallida. Archivo no eliminado: $archivo_tmp"
fi
