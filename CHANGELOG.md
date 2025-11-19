# Changelog – 0035-BASH-Shells_Menu

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

## [v0.1.0] - Base stable

- Ajout du squelette du projet 0035-BASH-Shells_Menu
- Mise en place du `Makefile` :
  - `make lint` (ShellCheck)
  - `make env-check`
  - `make utils-links`
  - `make run`
- Mise en place du pipeline CI (`.github/workflows/ci.yml`) :
  - Lancement automatique sur `push` et `pull_request`
  - Installation de `shellcheck`
  - Exécution de `make lint`
- Ajout de `.env.example` et de la gestion de `.env`
- Ajout de `tools/check_env.sh` pour valider `.env`
- Ajout de `tools/setup_utils_symlinks.sh` pour créer des symlinks vers les projets UTILS externes
- Mise en place de la structure de base du README et de la roadmap.

Prochaines versions prévues :
- **v0.2.0** : Utilities Menu
- **v0.3.0** : intégration avancée WSL
- **v0.4.0** : UX avancée du menu
- **v1.0.0** : version stable avec tests automatisés et installateur.
