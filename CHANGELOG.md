# Changelog – 0035-BASH-Shells_Menu

## [v0.2.6] – 2025-11-21

### 📘 Documentation
- docs: modify README

### 🔁 CI/CD
- ci(cd): fix changelog script execution
- ci(cd): auto-update CHANGELOG on tagged releases
- ci(cd): add contents write permission for auto-release
- ci(cd): add auto-release workflow and version/release badges

### 🧹 Chores
- chore(changelog): make generate_changelog executable




Toutes les modifications notables sont documentées ici, par version.

## [v0.1.1] – 2025-11-XX

### Added
- Workflow CD (`cd.yml`) avec création automatique de Release GitHub.
- Génération d’archives tar.gz et zip lors des tags `v*`.
- Badges Version & Release dans le README.
- Section Conventional Commits avec exemples concrets.

### Changed
- README enrichi (CI/CD, roadmap, conventions de commit).

---

## [v0.1.0] – 2025-11-XX

### Added
- Squelette du projet 0035-BASH-Shells_Menu.
- `Makefile` avec :
  - `make lint`
  - `make env-check`
  - `make utils-links`
  - `make run`
- Pipeline CI (`ci.yml`) : ShellCheck sur les scripts.
- `.env.example` + gestion `.env`.
- `tools/check_env.sh` pour valider `.env`.
- `tools/setup_utils_symlinks.sh` pour créer automatiquement les symlinks vers les projets UTILS externes.

---

## [v0.2.0] – Utilities Menu (à venir)

### Planned
- Menu Utilities qui liste les projets UTILS et permet de les lancer.
- Gestion du retour vers le menu principal.

...
