SHELL := /usr/bin/env bash

# Liste des scripts a analyser
SCRIPTS := \
	bin/menu.sh \
	lib/ascii.sh \
	tools/inspect_rc.sh \
	utils/sys-info.sh \
	menu.sh

.PHONY: all env-check lint test run

all: env-check lint

env-check:
	@echo "==> Verification .env"
	./tools/check_env.sh

lint:
	@echo "==> Running shellcheck"
	shellcheck -x $(SCRIPTS)

test:
	@echo "==> No automated tests yet"
	@echo "    Please test manually with: make run"

run:
	@echo "==> Starting main menu"
	./bin/menu.sh

.PHONY: utils-links

utils-links:
	@echo "==> Creating symlinks in UTILS_BASE_DIR"
	./tools/setup_utils_symlinks.sh
 