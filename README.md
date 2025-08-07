<p align="center"><img src="https://techstack-generator.vercel.app/github-icon.svg" width="200"   alt=" " /></p>
<h1 align="center"> Releases Manager GIT </h1> 
<h4 align="right">Ago 25</h4>

<p>
  <img src="https://img.shields.io/badge/OS-Linux%20GNU-yellowgreen">
  <img src="https://img.shields.io/badge/OS-Windows%2011-blue">
  <img src="https://img.shields.io/badge/Hardware-Raspberry%20ver%204-red">
</p>

<br>

# Table of contents
- [Table of contents](#table-of-contents)
- [Summary](#summary)
- [Descargar Archivo de update](#descargar-archivo-de-update)
- [Archivo instalador (install\_file.sh)](#archivo-instalador-install_filesh)
- [Troubleshooting](#troubleshooting)

<br>

# Summary
Administrador de versiones de archivos con Git (git-project-s-timeline). Archivo de prueba.

# Descargar Archivo de update
Este archivo se encarga de buscar todas las versiones de Releases en la cuenta de Github y mostrarte un menu para que tu desidas que version instalar.
```bash 
curl -O https://raw.githubusercontent.com/carjavi/releases-manager-git/main/update.sh 
```

<br>

update.sh:
```bash 
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
 
```

# Archivo instalador (install_file.sh)
Este es el archivo que instala las diferentes configuraciones que fueron creadas por cada versión. Este archivo es solo de ejemplo y prueba. Diferentes formas de descargarlo para su edición: 
```bash       
curl -O https://raw.githubusercontent.com/carjavi/releases-manager-git/main/install_file.sh
wget https://raw.githubusercontent.com/carjavi/releases-manager-git/main/install_file.sh
Invoke-WebRequest 'https://raw.githubusercontent.com/carjavi/releases-manager-git/main/install_file.sh' -OutFile ./install_file.sh # Only Windows


curl -o- https://raw.githubusercontent.com/carjavi/releases-manager-git/main/install_file.sh | bash # Download and Run

```
<br>

install_file.sh:
```bash  
#!/usr/bin/env bash

# Define colors
readonly ANSI_RED="\033[0;31m"
readonly ANSI_GREEN="\033[0;32m"
readonly ANSI_YELLOW="\033[0;33m"
readonly ANSI_RASPBERRY="\033[0;35m"
readonly ANSI_ERROR="\033[1;37;41m"
readonly ANSI_RESET="\033[m"

# Outputs a welcome message
function display_welcome() {
echo -e "${ANSI_RASPBERRY}\n"
echo -e "                            d8b                   d8b" 
echo -e "                            Y8P                   Y8P"
echo -e "                                                     "
echo -e " .d8888b  8888b.  888d888  8888  8888b.  888  888 888"
echo -e "d88P'        '88b 888P'    '888     '88b 888  888 888" 
echo -e "888      .d888888 888       888 .d888888 Y88  88P 888" 
echo -e "Y88b.    888  888 888       888 888  888  Y8bd8P  888" 
echo -e " 'Y8888P 'Y888888 888       888 'Y888888   Y88P   888" 
echo -e "                            888                      " 
echo -e "                           d88P                      " 
echo -e "                         888P'                       " 
echo -e "                                                     "
echo -e "${ANSI_GREEN}"
echo -e "The Quick Installer will guide you through a few easy steps${ANSI_RESET}"
echo -e "\033[1;32m***************************************************************$*\033[m"
echo -e "\n\n"
}

# calling Titulo 
display_welcome
    
echo -e "${ANSI_GREEN}carjavi Install: $1${ANSI_RESET}"

echo -e "\033[1;32m***************************************************************$*\033[m"

echo
echo "------------------------------"
echo "version: 1.0.2"
echo "------------------------------"
echo
```

<br>

# Troubleshooting
> :warning: **Warning:** Si hay algún error puede que necesites correrlo nuevamente!

<br>


<br>

---
Copyright &copy; 2022 [carjavi](https://github.com/carjavi). <br>
```www.instintodigital.net``` <br>
carjavi@hotmail.com <br>
<p align="center">
    <a href="https://instintodigital.net/" target="_blank"><img src="./img/developer.png" height="100" alt="www.instintodigital.net"></a>
</p>


