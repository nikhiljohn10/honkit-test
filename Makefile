help:
	@echo
	@echo "Usage: make command [LANG=<language_short_code>]"
	@echo
	@echo "    LANG : Language short codes are found in LANGS.md. Default is 'en'(English)."
	@echo "           ( Refer $(LANG_FILE) for short codes of Languages avaiable. )"
	@echo
	@echo "Commands:"
	@echo "  help      - Display make command list."
	@echo "  dev       - Setup project and start the development server with debugging enabled."
	@echo "  check     - Check for root directory for various dependencies."
	@echo "  setup     - Setup the temporary language and install node dependencies for the development. Default is 'en'"
	@echo "  build     - Build the honkit project."
	@echo "  build-dev - Build the honkit project with debug log."
	@echo "  serve     - Start honkit server locally for development."
	@echo "  clean     - Clean the project directory."

check: package.json book.json LANGS.md
	@if ! which node 1> /dev/null; then\
		echo "Node.js not found. Please install/reinstall Node.js. NVM is recommended for installation(https://github.com/nvm-sh/nvm).";\
	fi

clean:
	@rm -rf _book node_modules package-lock.json yarn.lock

setup: check
	@(yarn install 2> /dev/null || npm install) && echo "Project is ready for development.";\

build: setup
	@npx honkit build

build-dev: setup
	@npx honkit build --log=debug

serve: setup
	@npx honkit serve

dev: setup
	@npx honkit serve --log=debug --reload

.PHONY: help check clean setup build build-dev serve dev
