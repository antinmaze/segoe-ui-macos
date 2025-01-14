#!/bin/bash

/**
 * Segoe-UI Font Installer
 * This script will install Segoe-UI Font on your macOS
*/

# Color
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'


# Font repository
FONT_REPO="https://github.com/antinmaze/segoe-ui-macos/blob/master/font"

# Destination directory
DEST_DIR="$HOME/Library/Fonts"

# List of the SEGOE fonts to download
SEGOE_FONTS=(
    "segoeui.ttf"
    "segoeuib.ttf"
    "segoeuii.ttf"
    "segoeuiz.ttf"
    "segoeuil.ttf"
    "seguili.ttf"
    "segoeuisl.ttf"
    "seguisli.ttf"
    "seguisb.ttf"
    "seguisbi.ttf"
)


/**
 * Cekkoneksi is the function to check internet connection
 */
function cekkoneksi(){
    echo -e "$BLUE [ * ] Checking for internet connection"
    sleep 1
    echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "$RED [ X ]$BLUE Internet Connection ➜$RED OFFLINE!\n";
        echo -e "$RED Sorry, you really need an internet connection...."
        exit 0
    else
        echo -e "$GREEN [ ✔ ]$BLUE Internet Connection ➜$GREEN CONNECTED!\n";
        sleep 1
    fi
}

/**
 * Cekwget is the function to check wget
 */
function cekfont(){
    echo -e "$BLUE [ * ] Checking for Segoe-UI Font"
    sleep 1
    fc-list | grep -i "Segoe UI" >/dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]$BLUE Segoe-UI Font ➜$GREEN INSTALLED\n"
        sleep 1
    else
        echo -e "$RED [ X ]$BLUE Segoe-UI Font ➜$RED NOT INSTALLED\n"
        continueFont
    fi
}

/**
 * ContinueFont is the function to continue the font installation
 */
function continueFont(){
    echo -e "$LGREEN Do you want to install Segoe-UI Font? (y)es, (n)o :"
    read  -p ' ' INPUT
    case $INPUT in
    [Yy]* ) fontinstall;;
    [Nn]* ) end;;
    * ) echo -e "$RED\n Sorry, try again."; continueFont;;
  esac
}


function fontinstall(){
    # Check directory permissions
    if [ ! -d "$DEST_DIR" ]; then
        mkdir -p "$DEST_DIR"
    fi

    # Downloading the fonts
    for font in "${SEGOE_FONTS[@]}"; do
        echo "_____________________________ $font _____________________________ "
        curl "$FONT_REPO/$font" -o "$DEST_DIR/$font"
    done

    echo -e "$GREEN\n Font installed on $LBLUE'$DEST_DIR'"
}

/**
 * End is the end function
 */
function end(){
    echo -e "$LPURPLE\n Bye..... ;)"
    exit 0
}

/**
 * Banner is the banner function
 */
function banner(){
    echo -e "$LYELLOW" ""
    echo -e "                                         _    __            _   "
    echo -e "                                        (_)  / _|          | |  "
    echo -e "  ___  ___  __ _  ___   ___        _   _ _  | |_ ___  _ __ | |_ "
    echo -e " / __|/ _ \/ _  |/ _ \ / _ \  __  | | | | | |  _/ _ \|  _ \| __|"
    echo -e " \__ \  __/ (_| | (_) |  __/ (__) | |_| | | | || (_) | | | | |_ "
    echo -e " |___/\___|\__, |\___/ \___|       \__,_|_| |_| \___/|_| |_|\__|"
    echo -e "            __/ |                                               "
    echo -e "           |___/             $LPURPLE mrbvrz$LCYAN -$RED https://hasansuryaman.com        "
    echo ""
    echo -e "$LYELLOW ---------------------------------------------------------------"
    echo ""
}

main(){
    clear
    banner
    cekkoneksi
    #cekwget
    cekfont
}

main
