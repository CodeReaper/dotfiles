# handle extensions too:
# - ms-dotnettools.vscode-dotnet-runtime
# - redhat.ansible
# - ms-dotnettools.csharp (perhaps)
# - ms-dotnettools.csdevkit
# - streetsidesoftware.code-spell-checker
# - EditorConfig.EditorConfig
# - eamodio.gitlens
# - golang.go
# - Grafana.grafana-alloy
# - hashicorp.terraform
# - ms-kubernetes-tools.vscode-kubernetes-tools
# - bierner.markdown-mermaid
# - esbenp.prettier-vscode
# - dbankier.vscode-quick-select
# - mechatroner.rainbow-csv
# - redhat.vscode-yaml

# https://stackoverflow.com/a/49612562/190599 multi commands

BREWS = asdf brotli lz4 mas tree watch
PERSONAL_BREWS = colima docker docker-buildx docker-compose docker-credential-helper
WORK_BREWS = azure-cli wget

CASKS = chatgpt discord hush rectangle spotify visual-studio-code
PERSONAL_CASKS = steam tor-browser vlc
WORK_CASKS =

include .env
ifeq ($(origin ZONE),undefined)
$(error ZONE is not set)
endif

define BREW
brew install $(1);

endef

define CASK
brew install --cask $(1);

endef

install: install-rosetta install-brew install-brews install-casks install-autoupdate install-apps

install-rosetta:
	arch -arch x86_64 uname -m | grep x86_64 > /dev/null || \
		softwareupdate --install-rosetta --agree-to-license

install-brew:
	which brew > /dev/null # FIXME: needs to install brew, if missing

install-brews:
	$(foreach brew,$(BREWS),$(call BREW,$(brew)))
ifeq ($(ZONE),PERSONAL)
	$(foreach brew,$(PERSONAL_BREWS),$(call BREW,$(brew)))
endif
ifeq ($(ZONE),WORK)
	$(foreach brew,$(WORK_BREWS),$(call BREW,$(brew)))
endif

install-casks:
	$(foreach cask,$(CASKS),$(call CASK,$(cask)))
ifeq ($(ZONE),PERSONAL)
	$(foreach cask,$(PERSONAL_CASKS),$(call CASK,$(cask)))
endif
ifeq ($(ZONE),WORK)
	$(foreach cask,$(WORK_CASKS),$(call CASK,$(cask)))
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

list:
	brew list --installed-on-request
	brew list --cask
	mas list
