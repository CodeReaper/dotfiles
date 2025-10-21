include .env
ifeq ($(origin ZONE),undefined)
$(error ZONE is not set)
endif

define BREW
brew ls --versions $(1) > /dev/null || brew install $(1);

endef

define CASK
brew ls --cask --versions $(1) > /dev/null || brew install --cask $(1);

endef

BREWS = asdf brotli lz4 tree watch
PERSONAL_BREWS = colima docker docker-buildx docker-compose docker-credential-helper
WORK_BREWS = azure-cli wget
CASKS = visual-studio-code

brew-install:
	$(foreach brew,$(BREWS),$(call BREW,$(brew)))
ifeq ($(ZONE),PERSONAL)
	$(foreach brew,$(PERSONAL_BREWS),$(call BREW,$(brew)))
endif
# 	$(foreach cask,$(CASKS),$(call CASK,$(cask)))

brew-list:
	brew list --installed-on-request
	brew list --cask
