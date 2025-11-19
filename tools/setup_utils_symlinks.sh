#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 || exit
  pwd
)"

# Charger .env
if [ -f "$ROOT_DIR/.env" ]; then
  # shellcheck disable=SC1091
  . "$ROOT_DIR/.env"
else
  echo "ERROR: .env not found. Create it from .env.example."
  exit 1
fi

: "${DOCUMENT_ROOT_WINDOWS:?DOCUMENT_ROOT_WINDOWS not set in .env}"
: "${UTILS_BASE_DIR:?UTILS_BASE_DIR not set in .env}"

mkdir -p "$UTILS_BASE_DIR"

# List of numbered shell projects to expose via symlinks
PROJECTS=(
  "0012-BASH-cas-Converts_phrases_to_programming_casings"
  "0013-BASH-diceware-Diceware_on_CLI"
  "0023-BASH-rr-Removes_-_Raccourci_of_the_filenames_in_folder"
  "0028-BASH-sshutilities-SSH_Utilities"
  "0029-BASH-startssh-Starts _SSH_and_loads_private_key"
)

if uname | grep -qi 'mingw'; then
  echo "Using PowerShell to create Junctions in UTILS_BASE_DIR"

  # Construire le script PowerShell dans une variable
  ps_script=$(cat <<PSSCRIPT
\$docRoot  = "$DOCUMENT_ROOT_WINDOWS"
\$utilsDir = "$UTILS_BASE_DIR"

if (-not (Test-Path \$utilsDir)) {
  New-Item -ItemType Directory -Path \$utilsDir | Out-Null
}

\$projects = @(
  "0012-BASH-cas-Converts_phrases_to_programming_casings",
  "0013-BASH-diceware-Diceware_on_CLI",
  "0023-BASH-rr-Removes_-_Raccourci_of_the_filenames_in_folder",
  "0028-BASH-sshutilities-SSH_Utilities",
  "0029-BASH-startssh-Starts _SSH_and_loads_private_key"
)

foreach (\$p in \$projects) {
  \$target = Join-Path \$docRoot \$p
  \$link   = Join-Path \$utilsDir \$p

  if (-not (Test-Path \$target)) {
    Write-Host "SKIP: \$p (target not found: \$target)"
    continue
  }

  if (Test-Path \$link) {
    Write-Host "REMOVE: \$link"
    Remove-Item \$link -Force -Recurse
  }

  Write-Host "LINK: \$p -> \$target"
  New-Item -ItemType Junction -Path \$link -Target \$target | Out-Null
}
PSSCRIPT
)

  # Lancer PowerShell avec ce script
  powershell.exe -NoLogo -NoProfile -Command "$ps_script"

else
  echo "Non-Windows environment: using ln -s (WSL/Linux)"

  for p in "${PROJECTS[@]}"; do
    target="$DOCUMENT_ROOT_WSL/$p"
    link="$UTILS_BASE_DIR/$p"

    if [ ! -d "$target" ]; then
      echo "SKIP: $p (no dir $target)"
      continue
    fi

    [ -e "$link" ] && rm -rf "$link"
    ln -s "$target" "$link"
    echo "LINK: $p -> $target"
  done
fi

echo "Done."
