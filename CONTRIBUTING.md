# Contribuer à 0035-BASH-Shells_Menu

Merci de ton intérêt pour ce projet 🎉

## 💡 Principes généraux

- Le projet vise une **architecture professionnelle** (CI/CD, tests, qualité)
- Le code doit rester **lisible**, **documenté** et **portable** (Git Bash / WSL)
- Les scripts Shell doivent passer **ShellCheck** sans erreurs (warnings tolérés si justifiés)

## 🛠️ Pré-requis

- Git
- Bash
- make
- shellcheck (localement, recommandé)
- Optionnel : WSL (Ubuntu), Zsh

## 🔄 Workflow Git recommandé

1. Fork du dépôt (ou nouvelle branche locale si tu es owner)
2. Création d’une branche de feature :
   ```bash
   git checkout -b feat/ma-feature
   ```
3. Développement + tests locaux :
   ```bash
   make all
   make run
   ```
4. Commit(s) propre(s) avec messages explicites :
   ```bash
   git commit -m "feat: add new utility X"
   ```
5. Push de ta branche et ouverture d’une Pull Request.

## ✅ Règles de code

- Scripts Shell :
  - `set -euo pipefail` en début de fichier (sauf cas particulier justifié)
  - Fonctionnement correct en Git Bash et en WSL quand c’est prévu
  - Pas de chemins codés en dur : utiliser `.env` quand c’est pertinent
- Noms de fichiers/projets :
  - Préfixe numéroté type `00xx-BASH-...` pour les utilitaires externes
- Pas de secrets dans le dépôt :
  - `.env` est ignoré par Git
  - `.env.example` sert de modèle documentaire

## 🧪 Tests & CI

- Avant de pousser :
  ```bash
  make lint
  ```
- La CI GitHub exécute automatiquement `make lint` sur chaque `push` / PR.
- Merci de corriger les éventuelles erreurs remontées avant de demander une revue.

## 🗺️ Roadmap

Voir le fichier [`README.md`](README.md) et [`CHANGELOG.md`](CHANGELOG.md) pour les objectifs de versions (v0.2.0, v0.3.0, etc.).

Bon hack !
