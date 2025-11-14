#!/usr/bin/env bash
set -euo pipefail

REQUIRED_VARS=(
  DOCUMENT_ROOT_WINDOWS
  DOCUMENT_ROOT_WSL
  UTILS_BASE_DIR
  WSL_DEFAULT_DISTRO
)

ROOT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 || exit
  pwd
)"

if [ ! -f "$ROOT_DIR/.env" ]; then
  echo "❌ ERREUR : fichier .env introuvable."
  echo "Créez-le à partir de .env.example"
  exit 1
fi

# Charger .env
# shellcheck disable=SC1091
. "$ROOT_DIR/.env"

# Vérifier les variables obligatoires
for var in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!var:-}" ]; then
    echo "❌ Variable manquante : $var"
    exit 1
  fi
done

echo "✅ .env OK"
