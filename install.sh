#!/usr/bin/env bash
set -euo pipefail

# Script d'installation de base pour 0035-BASH-Shells_Menu
# - Vérifie les prérequis
# - Copie .env.example vers .env si nécessaire
# - Vérifie .env
# - Crée les symlinks UTILS
# - (optionnel) configure ~/.menu-shells

ROOT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 || exit
  pwd
)"

echo "==> Installation 0035-BASH-Shells_Menu"
echo "Root dir: $ROOT_DIR"
echo

if ! command -v make >/dev/null 2>&1; then
  echo "ERROR: make not found. Please install make first."
  exit 1
fi

if ! command -v bash >/dev/null 2>&1; then
  echo "ERROR: bash not found. This project requires Bash."
  exit 1
fi

# Créer .env si nécessaire
if [ ! -f "$ROOT_DIR/.env" ]; then
  if [ -f "$ROOT_DIR/.env.example" ]; then
    echo "==> .env not found, creating from .env.example"
    cp "$ROOT_DIR/.env.example" "$ROOT_DIR/.env"
    echo "Edit .env to match your environment (paths, WSL distro, etc.)."
  else
    echo "ERROR: .env and .env.example not found."
    exit 1
  fi
else
  echo "==> .env already present"
fi

echo
echo "==> Running env-check"
( cd "$ROOT_DIR" && make env-check )

echo
echo "==> Creating UTILS symlinks (if configured)"
( cd "$ROOT_DIR" && make utils-links || echo 'WARN: utils-links failed, check .env and projects paths.' )

echo
echo "==> Installation finished."
echo "You can now run:"
echo "  make run"
echo "or from Git Bash:"
echo "  smenu    (si une fonction smenu est configurée dans ~/.bashrc)"
