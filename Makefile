include .env
ifeq ($(origin ZONE),undefined)
$(error ZONE is not set)
endif

CODE := /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code

install: install-rosetta install-brew install-brews install-casks install-autoupdate install-apps install-code-extensions

install-rosetta:
	arch -arch x86_64 uname -m | grep x86_64 > /dev/null || \
		softwareupdate --install-rosetta --agree-to-license

install-brew:
	which brew > /dev/null || { \
		echo "Install brew via pkg from https://github.com/Homebrew/brew/releases/latest"; \
		exit 1; \
	}

install-brews:
	brew install asdf
	brew install brotli
	brew install lz4
	brew install mas
	brew install tree
	brew install watch
ifeq ($(ZONE),PERSONAL)
	brew install colima
	brew install docker
	brew install docker-buildx
	brew install docker-compose
	brew install docker-credential-helper
endif
ifeq ($(ZONE),WORK)
	brew install azure-cli
	brew install wget
endif

install-casks:
	brew install --cask chatgpt
	brew install --cask discord
	brew install --cask hush
	brew install --cask rectangle
	brew install --cask spotify
	brew install --cask visual-studio-code
ifeq ($(ZONE),PERSONAL)
	brew install --cask steam
	brew install --cask tor-browser
	brew install --cask vlc
endif

install-autoupdate:
	brew tap | grep 'domt4/autoupdate' > /dev/null || \
		brew tap domt4/autoupdate
	brew autoupdate status | grep installed || \
		brew autoupdate start 43200 --upgrade --cleanup --immediate --ac-only

install-apps:
	mas install 1160517834 # whiteboard
	mas install 1561604170 # nightshift - safari extension
	mas install 425424353 # The Unarchiver
	mas install 497799835 # Xcode
ifeq ($(ZONE),PERSONAL)
	mas install 409203825 # Numbers
endif

install-code-extensions:
	$(CODE) \
		--install-extension bierner.markdown-mermaid \
		--install-extension dbankier.vscode-quick-select \
		--install-extension eamodio.gitlens \
		--install-extension editorconfig.editorconfig \
		--install-extension enkia.tokyo-night \
		--install-extension esbenp.prettier-vscode \
		--install-extension golang.go \
		--install-extension hashicorp.terraform \
		--install-extension mechatroner.rainbow-csv \
		--install-extension ms-kubernetes-tools.vscode-kubernetes-tools \
		--install-extension redhat.vscode-yaml \
		--install-extension streetsidesoftware.code-spell-checker
ifeq ($(ZONE),WORK)
# sleep to avoid overloading poorly implemented extension system
	@sleep 2
	$(CODE) \
		--install-extension grafana.grafana-alloy \
		--install-extension ms-dotnettools.csdevkit \
		--install-extension redhat.ansible
endif

list:
	brew list --installed-on-request
	brew list --cask
	mas list
	$(CODE) --list-extensions
