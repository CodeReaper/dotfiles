# cspell:disable

include .env
ifeq ($(origin ZONE),undefined)
$(error ZONE is not set)
endif

CODE := /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code

all: setup install

setup:
# Setup: correctly place git directory
	-test -d .git && ! test -d .stowed && mv .git .stowed
	$(MAKE) setup-defaults

setup-defaults: # see https://macos-defaults.com

# Global: disable minimize windows
	defaults write -g NSUserKeyEquivalents -dict-add Minimize '\0'
# Global: disable fn-button emoji picker
	defaults write com.apple.HIToolbox AppleFnUsageType -int 0
# Global: disable caps lock
	defaults -currentHost write -g \
		com.apple.keyboard.modifiermapping.0-0-0 \
		-array '<dict><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer><key>HIDKeyboardModifierMappingDst</key><integer>7</integer></dict>'
# Global: expand save panel by default
	defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
	defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
# Global: enable full keyboard access for all controls (e.g. enable tab in modal dialogs)
	defaults write -g AppleKeyboardUIMode -int 3
# Global: disable smart quotes as they’re annoying when typing code
	defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
# Global: disable smart dashes as they’re annoying when typing code
	defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
# Global: use scroll gesture with the ctrl (^) modifier key to zoom
	defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true

# Finder: show ~/library
	chflags nohidden ~/Library
# Finder: show extenions
	defaults write -g AppleShowAllExtensions -bool true
# Finder: show hidden files
	defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: show path bar
	defaults write com.apple.finder ShowPathbar -bool true
# Finder: show files in list view
	defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
# Finder: full posix path in finder windows
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Finder: show status bar in finder
	defaults write com.apple.finder ShowStatusBar -bool true
# Finder: new windows start at home directory
	defaults write com.apple.finder NewWindowTarget -string PfHm
	defaults write com.apple.finder NewWindowTargetPath -string 'file:///$$HOME'
# Finder: only search the current direcotry
	defaults write com.apple.finder FXDefaultSearchScope -string SCcf
# Finder: disable warning for changing extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keyboard: enable repeating key while pressed
	defaults write -g ApplePressAndHoldEnabled -bool false
# Keyboard: disable autocorrect
	defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
# Keyboard: disable auto-capitalization
	defaults write -g NSAutomaticCapitalizationEnabled -bool false
# Keyboard: set a shorter delay until key repeat
	defaults write -g InitialKeyRepeat -int 15
# Keyboard: set a fast keyboard repeat rate
	defaults write -g KeyRepeat -int 2
# Keyboard: disable replace double-space with period-space
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true

# Dock: automatically hide and show the dock
	defaults write com.apple.dock autohide -bool true
# Dock: dock on the left
	defaults write com.apple.dock orientation -string left
# Dock: disable recents
	defaults write com.apple.dock show-recents -bool false
# Dock: show only active
	defaults write com.apple.dock static-only -bool true

# Hot corners: disable all
	defaults write com.apple.dock wvous-tl-corner -int 0
	defaults write com.apple.dock wvous-tr-corner -int 0
	defaults write com.apple.dock wvous-bl-corner -int 0
	defaults write com.apple.dock wvous-br-corner -int 0

install: install-rosetta install-brew install-brews install-casks install-autoupdate install-asdf install-apps install-code-extensions
ifeq ($(ZONE),WORK)
	make install-dotnet
endif

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
	brew install gh
	brew install go
	brew install helm
	brew install hugo
	brew install kind
	brew install kubernetes-cli
	brew install kustomize
	brew install lz4
	brew install mas
	brew install shellcheck
	brew install shfmt
	brew install swiftlint
	brew install tree
	brew install watch
	brew install yq
	brew install anomalyco/tap/opencode-v2
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
	brew list --cask discord >/dev/null 2>&1 || brew install --cask discord
	brew list --cask hush >/dev/null 2>&1 || brew install --cask hush
	brew list --cask macpass >/dev/null 2>&1 || brew install --cask macpass
	brew list --cask rectangle >/dev/null 2>&1 || brew install --cask rectangle
	brew list --cask spotify >/dev/null 2>&1 || brew install --cask spotify
	brew list --cask visual-studio-code >/dev/null 2>&1 || brew install --cask visual-studio-code
	brew list --cask macdirstat >/dev/null 2>&1 || brew install --cask macdirstat
ifeq ($(ZONE),PERSONAL)
	brew list --cask steam >/dev/null 2>&1 || brew install --cask steam
	brew list --cask tor-browser >/dev/null 2>&1 || brew install --cask tor-browser
	brew list --cask vlc >/dev/null 2>&1 || brew install --cask vlc
endif
ifeq ($(ZONE),WORK)
	brew list --cask slack >/dev/null 2>&1 || brew install --cask slack
	brew list --cask rocket-chat >/dev/null 2>&1 || brew install --cask rocket-chat
endif

install-autoupdate:
	brew tap | grep 'domt4/autoupdate' > /dev/null || \
		brew tap domt4/autoupdate
	brew trust --command domt4/autoupdate/autoupdate
	brew autoupdate status | grep installed || \
		brew autoupdate start 43200 --upgrade --cleanup --immediate --ac-only

install-asdf:
	asdf plugin add nodejs
	asdf plugin add python
	asdf plugin add terraform
	asdf install

install-apps:
	mas install 1160517834 # whiteboard
	mas install 1561604170 # nightshift - safari extension
	mas install 425424353 # The Unarchiver
	mas install 497799835 # Xcode
ifeq ($(ZONE),PERSONAL)
	mas install 361304891 # Numbers
endif

install-code-extensions:
	$(CODE) \
		--install-extension bierner.markdown-mermaid \
		--install-extension DavidAnson.vscode-markdownlint \
		--install-extension dbankier.vscode-quick-select \
		--install-extension eamodio.gitlens \
		--install-extension editorconfig.editorconfig \
		--install-extension enkia.tokyo-night \
		--install-extension esbenp.prettier-vscode \
		--install-extension github.vscode-github-actions \
		--install-extension golang.go \
		--install-extension hashicorp.terraform \
		--install-extension mechatroner.rainbow-csv \
		--install-extension mkhl.shfmt \
		--install-extension ms-kubernetes-tools.vscode-kubernetes-tools \
		--install-extension redhat.vscode-xml \
		--install-extension redhat.vscode-yaml \
		--install-extension sst-dev.opencode \
		--install-extension streetsidesoftware.code-spell-checker \
		--install-extension timonwong.shellcheck \
		--install-extension wayou.vscode-todo-highlight
ifeq ($(ZONE),WORK)
# sleep to avoid overloading poorly implemented extension system
	@sleep 2
	$(CODE) \
		--install-extension grafana.grafana-alloy \
		--install-extension ms-dotnettools.csdevkit \
		--install-extension redhat.ansible
endif

install-dotnet:
	make -f .config/setup/install-dotnet.mk

install-skills:
	@mkdir -p .agents/vendor/skills/
# 	DISABLED:
# 	test -d .agents/vendor/repositories/spf13/go-skills || git clone https://github.com/spf13/go-skills.git .agents/vendor/repositories/spf13/go-skills
# 	git -C .agents/vendor/repositories/spf13/go-skills pull
# 	ln -sf $(CURDIR)/.agents/vendor/repositories/spf13/go-skills/go $(CURDIR)/.agents/vendor/skills/go

list:
	brew list --installed-on-request
	brew list --cask
	mas list
	$(CODE) --list-extensions
	asdf plugin list
