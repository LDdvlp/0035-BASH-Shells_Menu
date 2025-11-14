SHELL := /usr/bin/env bash

# Liste des scripts à analyser
SCRIPTS := \
	bin/menu.sh \
	lib/ascii.sh \
	tools/inspect_rc.sh \
	utils/sys-info.sh \
	menu.sh

.PHONY: all lint test run

all: env-check lint

lint:
	@echo "==> Running shellcheck"
	shellcheck -x $(SCRIPTS)

test:
	@echo "==> No automated tests yet."
	@echo "    Pour l'instant, teste visuellement avec :"
	@echo "      ./bin/menu.sh  ou  smenu dans Git Bash"

run:
	@echo "==> Lancement du menu principal"
	./bin/menu.sh

env-check:
	@echo "==> Vérification .env"
	./tools/check_env.sh
