# 0035-BASH-Shells_Menu

Un menu de sélection de Shell multi-environnements (Git Bash, WSL Bash, Zsh, PowerShell, CMD)
avec gestion d’environnement, ASCII Art, pause MOTD, intégration d’utilitaires externes
et pipeline CI/CD complet.

---

## 🚀 Statut du projet

[![CI](https://github.com/LDdvlp/0035-BASH-Shells_Menu/actions/workflows/ci.yml/badge.svg)](https://github.com/LDdvlp/0035-BASH-Shells_Menu/actions/workflows/ci.yml)
[![CD](https://github.com/LDdvlp/0035-BASH-Shells_Menu/actions/workflows/cd.yml/badge.svg)](https://github.com/LDdvlp/0035-BASH-Shells_Menu/actions/workflows/cd.yml)

Version courante : **v0.1.0**  
État : **Base stable (CI/CD + symlinks + env-check + lint)**

---

## 🎯 Objectifs du projet

- Sélectionner le Shell voulu au lancement :
  - Git Bash → Bash  
  - Git Bash → Zsh  
  - WSL → Bash  
  - WSL → Zsh  
  - Windows PowerShell  
  - PowerShell (pwsh)  
  - CMD  
  - Rester dans Git Bash

- Afficher l’environnement et le shell choisi en **ASCII Art**
- Ajouter une **pause MOTD** pour WSL : “Strike a pause when ready”
- Intégrer un menu **Utilities** basé sur des mini-projets externes
- Centraliser les chemins dans un fichier `.env`
- Gérer les symlinks automatiquement via PowerShell
- Fournir une architecture professionnelle :
  - CI (lint, checks)
  - CD (validation/tagging)
  - Makefile command runner
  - Tests futurs (bats)

---

## 📦 Structure du projet (cible)

```text
0035-BASH-Shells_Menu/
│
├── bin/
│   └── menu.sh
├── lib/
│   ├── ascii.sh
│   └── helpers.sh
├── utils/
│   └── sys-info.sh
│
├── tools/
│   ├── inspect_rc.sh
│   ├── check_env.sh
│   └── setup_utils_symlinks.sh   ← Génère les symlinks UTILS
│
├── .env.example
├── menu.sh
├── Makefile
├── README.md
└── CHANGELOG.md
```

Dépôt externe UTILS (symlinks) :

```text
/d/General/04-DocumentRoot/0-document_root/UTILS/
├── 0012-BASH-cas-Converts_phrases_to_programming_casings@
├── 0013-BASH-diceware-Diceware_on_CLI@
├── 0023-BASH-rr-Removes_-_Raccourci_of_the_filenames_in_folder@
├── 0028-BASH-sshutilities-SSH_Utilities@
└── 0029-BASH-startssh-Starts _SSH_and_loads_private_key@
```

---

## ⚙️ Installation rapide

### 1. Cloner le dépôt

```bash
git clone https://github.com/LDdvlp/0035-BASH-Shells_Menu.git
cd 0035-BASH-Shells_Menu
```

### 2. Créer et configurer `.env`

```bash
cp .env.example .env
```

Adapter ensuite les chemins selon ta machine (Windows / WSL).

### 3. Vérifier la configuration

```bash
make env-check
```

### 4. Créer les symlinks UTILS

```bash
make utils-links
```

---

## 🧰 Commandes Makefile

| Commande          | Description |
|------------------|-------------|
| `make all`       | Vérifie `.env` + lance le lint |
| `make lint`      | Lint ShellCheck sur les scripts |
| `make env-check` | Vérifie que `.env` est présent et cohérent |
| `make utils-links` | Crée les symlinks dans `UTILS_BASE_DIR` via PowerShell (Windows) |
| `make run`       | Lance le menu principal (`bin/menu.sh`) |

---

## 📐 Conventional Commits

Ce projet suit la spécification **Conventional Commits**.  
Types et **exemples concrets** utilisés dans le projet :

### ▶️ **feat** — nouvelle fonctionnalité
```text
feat(menu): add WSL ASCII art header
```

### 🛠️ **fix** — correction de bug
```text
fix(utils): handle missing project folder in symlink generator
```

### 📘 **docs** — documentation
```text
docs: update README with CI/CD badges
```

### 🎨 **style** — mise en forme
```text
style(menu): align ASCII art blocks
```

### 🔧 **refactor** — amélioration de code sans changer son comportement
```text
refactor(utils): simplify symlink detection logic
```

### ⚡ **perf** — optimisation
```text
perf(menu): accelerate shell detection logic
```

### 🧪 **test** — tests automatisés
```text
test(menu): add tests for menu option parsing
```

### 🔁 **ci** — modifications à l’intégration continue
```text
ci: update shellcheck version in CI
```

### 🧹 **chore** — maintenance interne
```text
chore(repo): move LICENSE and CONTRIBUTING.md from lib/ to root
```

---

## 🛣️ Roadmap

### v0.1.0 – Base stable ✅
- CI (ShellCheck)
- Makefile
- `.env` + `.env.example`
- Générateur de symlinks UTILS

### v0.2.0 – Utilities Menu
- Menu qui liste les projets UTILS
- Exécution des scripts de chaque utilitaire
- Retour propre au menu principal

### v0.3.0 – WSL Integration
- Gestion Bash/Zsh auto
- Pause MOTD propre
- Retour auto menu

### v0.4.0 – UX Menu
- Couleurs
- Navigation fléchée (↑ ↓)
- ASCII avancé

### v1.0.0 – Release stable
- Tests BATS
- Packaging
- Installateur automatique (`install.sh`)

---

## 🧑‍💻 Auteur

**Loïc Drouet (LDdvlp)**  
Développeur Web & Shell, multi-environnements (Windows / WSL / Linux).

---

## 📜 Licence

Ce projet est publié sous licence MIT. Voir le fichier [`LICENSE`](LICENSE).
