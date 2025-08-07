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
echo "version: 1.0.1"
echo "------------------------------"
echo