#!/usr/bin/env bash
set -euo pipefail

# Usage :
#   tools/generate_changelog.sh <VERSION> [<PREVIOUS_TAG>]
#
# Exemple :
#   tools/generate_changelog.sh v0.2.8 v0.2.7

VERSION="${1:-}"
PREV_TAG="${2:-}"

if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <VERSION> [<PREVIOUS_TAG>]" >&2
  exit 1
fi

# Déterminer la plage de commits
if [[ -n "$PREV_TAG" ]]; then
  RANGE="${PREV_TAG}..${VERSION}"
else
  # Pas de tag précédent : on prend tout ce qui mène à VERSION
  RANGE="${VERSION}"
fi

# Récupérer les messages de commit (sans merges)
mapfile -t COMMITS < <(git log --no-merges --pretty=format:'%s' "$RANGE" || true)

if (( ${#COMMITS[@]} == 0 )); then
  echo "Aucun commit trouvé pour la plage ${RANGE}, rien à ajouter au changelog."
  exit 0
fi

# Regrouper par type conventional commit
feats=()
fixes=()
docs=()
refactors=()
chores=()
cis=()
tests=()
perfs=()
styles=()
others=()

for msg in "${COMMITS[@]}"; do
  case "$msg" in
    feat* )      feats+=("$msg") ;;
    fix* )       fixes+=("$msg") ;;
    docs* )      docs+=("$msg") ;;
    refactor* )  refactors+=("$msg") ;;
    chore* )     chores+=("$msg") ;;
    ci* )        cis+=("$msg") ;;
    test* )      tests+=("$msg") ;;
    perf* )      perfs+=("$msg") ;;
    style* )     styles+=("$msg") ;;
    * )          others+=("$msg") ;;
  esac
done

today=$(date +"%Y-%m-%d")

# Construire le bloc markdown pour cette version
tmp_block="$(mktemp)"

{
  echo "## [${VERSION}] – ${today}"
  echo

  if (( ${#feats[@]} )); then
    echo "### ✨ Features"
    for m in "${feats[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#fixes[@]} )); then
    echo "### 🐛 Fixes"
    for m in "${fixes[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#docs[@]} )); then
    echo "### 📘 Documentation"
    for m in "${docs[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#refactors[@]} )); then
    echo "### 🧩 Refactoring"
    for m in "${refactors[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#perfs[@]} )); then
    echo "### ⚡ Performance"
    for m in "${perfs[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#tests[@]} )); then
    echo "### 🧪 Tests"
    for m in "${tests[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#cis[@]} )); then
    echo "### 🔁 CI/CD"
    for m in "${cis[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#chores[@]} )); then
    echo "### 🧹 Chores"
    for m in "${chores[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#styles[@]} )); then
    echo "### 🎨 Style"
    for m in "${styles[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  if (( ${#others[@]} )); then
    echo "### 🔎 Autres"
    for m in "${others[@]}"; do
      echo "- ${m}"
    done
    echo
  fi

  echo "---"
  echo
} > "$tmp_block"

# Intégrer dans CHANGELOG.md en préservant l’entête existante
changelog="CHANGELOG.md"
tmp_changelog="$(mktemp)"

if [[ -f "$changelog" ]]; then
  header_file="$(mktemp)"
  tail_file="$(mktemp)"
  found_first_version=0

  # On découpe : entête (avant le premier "## [") et reste
  while IFS= read -r line; do
    if [[ $found_first_version -eq 0 && "$line" == "## ["* ]]; then
      found_first_version=1
      printf '%s\n' "$line" >> "$tail_file"
    elif [[ $found_first_version -eq 0 ]]; then
      printf '%s\n' "$line" >> "$header_file"
    else
      printf '%s\n' "$line" >> "$tail_file"
    fi
  done < "$changelog"

  {
    cat "$header_file"
    echo
    cat "$tmp_block"
    cat "$tail_file"
  } > "$tmp_changelog"

  rm -f "$header_file" "$tail_file"
else
  {
    echo "# Changelog – 0035-BASH-Shells_Menu"
    echo
    echo "Toutes les modifications notables sont documentées ici, par version."
    echo
    cat "$tmp_block"
  } > "$tmp_changelog"
fi

mv "$tmp_changelog" "$changelog"
rm -f "$tmp_block"

echo "CHANGELOG.md mis à jour pour ${VERSION}"
