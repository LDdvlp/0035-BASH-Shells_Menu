#!/usr/bin/env bash
set -euo pipefail

# Résoudre le répertoire racine du projet
ROOT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 || exit
  pwd
)"


# Charger .env si présent
if [ -f "$ROOT_DIR/.env" ]; then
  # shellcheck disable=SC1091
  . "$ROOT_DIR/.env"
else
  echo "⚠️  Attention : fichier .env introuvable."
  echo "Créez-le avec : cp .env.example .env"
fi


# Charger les bannières ASCII
# shellcheck disable=SC1091
. "$ROOT_DIR/lib/ascii.sh"

pause() {
    read -rp "Strike a pause when ready... " _
}

detect_environment() {
    # Très simple pour l'instant : on démarre depuis Git Bash
    local env="Git Bash (Windows)"

    if grep -qi microsoft /proc/version 2>/dev/null; then
        env="WSL (Linux sous Windows)"
    fi

    echo "$env"
}

print_env_info() {
    local chosen="$1"
    local current_env
    current_env="$(detect_environment)"

    echo
    echo "=== Environment & Shell info ==="
    echo " Current environment : $current_env"
    echo " Current SHELL       : ${SHELL:-unknown}"
    echo " Selected profile    : $chosen"
    echo " PWD                 : $PWD"
    echo " HOME                : $HOME"
    echo
}

show_utilities_menu() {
    echo
    echo "Utilities Menu"
    echo "--------------"
    echo "1) System Info (utils/sys-info.sh)"
    echo "0) Retour au menu principal"
    echo

    read -rp "Choix utilitaire : " u_choice
    case "$u_choice" in
        1)
            if [ -x "$ROOT_DIR/utils/sys-info.sh" ]; then
                "$ROOT_DIR/utils/sys-info.sh"
            else
                echo "Utilitaire sys-info introuvable ou non exécutable."
                pause
            fi
            ;;
        0|"")
            ;;
        *)
            echo "Choix inconnu."
            pause
            ;;
    esac
}


handle_shell_choice() {
    local choice="$1"

    clear
    echo "Bienvenue dans Git Bash bash."
    echo

    case "$choice" in
        1)
            print_ascii_banner "gitbash-bash"
            print_env_info "Git Bash · Bash"
            pause
            show_utilities_menu
            ;;
        2)
            print_ascii_banner "gitbash-zsh"
            print_env_info "Git Bash · Zsh"
            pause
            show_utilities_menu
            ;;
        3)
            print_ascii_banner "wsl-bash"
            print_env_info "WSL · Bash"
            echo "Lancement de WSL Bash (distro : ${WSL_DEFAULT_DISTRO:-Ubuntu})..."
            echo
            echo "Après l'affichage du MOTD WSL, tu verras :"
            echo "  Strike a pause when ready..."
            echo
            pause
            # On lance WSL Bash dans le même terminal
            wsl.exe -d "${WSL_DEFAULT_DISTRO:-Ubuntu}" --cd ~ bash
            ;;
        4)
            print_ascii_banner "wsl-zsh"
            print_env_info "WSL · Zsh"
            echo "Lancement de WSL Zsh (distro : ${WSL_DEFAULT_DISTRO:-Ubuntu})..."
            echo
            echo "Après l'affichage du MOTD WSL, tu verras :"
            echo "  Strike a pause when ready..."
            echo
            pause
            # On lance Zsh dans WSL (si installé)
            wsl.exe -d "${WSL_DEFAULT_DISTRO:-Ubuntu}" --cd ~ zsh
            ;;
        5)
            echo "Lancement Windows PowerShell..."
            pause
            powershell.exe -NoLogo
            ;;
        6)
            echo "Lancement PowerShell (pwsh) si installé..."
            pause
            pwsh.exe || echo "pwsh.exe introuvable."
            ;;
        7)
            echo "Lancement CMD..."
            pause
            cmd.exe
            ;;
        8)
            echo "Stay in Git Bash (on ne change rien, retour au prompt)."
            pause
            exit 0
            ;;
        *)
            echo "Choix inconnu."
            pause
            ;;
    esac
}


main_menu() {
    while true; do
        clear
        echo "Bienvenue dans Git Bash bash."
        echo
        echo "Menu Principal"
        echo "1. Git Bash Bash"
        echo "2. Git Bash ZSH"
        echo "3. WSL Bash"
        echo "4. WSL ZSH"
        echo "5. Windows PowerShell"
        echo "6. PowerShell"
        echo "7. CMD"
        echo "8. Stay in Git Bash"
        echo

        read -rp "Votre choix : " choice
        handle_shell_choice "$choice"
    done
}

main_menu
