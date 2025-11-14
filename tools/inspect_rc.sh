#!/usr/bin/env bash
set -euo pipefail

echo "=== Git Bash : $HOME/.bashrc ==="
if [ -f "$HOME/.bashrc" ]; then
    sed -n '1,160p' "$HOME/.bashrc"
else
    echo "(pas de ~/.bashrc)"
fi

echo
echo "=== Git Bash : $HOME/.zshrc ==="
if [ -f "$HOME/.zshrc" ]; then
    sed -n '1,160p' "$HOME/.zshrc"
else
    echo "(pas de ~/.zshrc)"
fi

echo
echo "=== WSL (distro par défaut) : ~/.bashrc & ~/.zshrc ==="
if command -v wsl.exe >/dev/null 2>&1; then
    wsl.exe -e bash -lc '
        echo "-- /etc/os-release (résumé) --"
        head -n 5 /etc/os-release 2>/dev/null || echo "pas de /etc/os-release"
        echo
        echo "-- ~/.bashrc --"
        sed -n "1,160p" ~/.bashrc 2>/dev/null || echo "pas de ~/.bashrc"
        echo
        echo "-- ~/.zshrc --"
        sed -n "1,160p" ~/.zshrc 2>/dev/null || echo "pas de ~/.zshrc"
    '
else
    echo "(wsl.exe introuvable, pas dinspection WSL)"
fi
