BREWS = asdf brotli lz4 tree watch
PERSONAL_BREWS = colima docker docker-buildx docker-compose docker-credential-helper
WORK_BREWS = azure-cli wget

CASKS = visual-studio-code
PERSONAL_CASKS =
WORK_CASKS =

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

install:
	@$(foreach brew,$(BREWS),$(call BREW,$(brew)))
ifeq ($(ZONE),PERSONAL)
	@$(foreach brew,$(PERSONAL_BREWS),$(call BREW,$(brew)))
endif
ifeq ($(ZONE),WORK)
	@$(foreach brew,$(WORK_BREWS),$(call BREW,$(brew)))
endif

# 	@$(foreach cask,$(CASKS),$(call CASK,$(cask)))
# ifeq ($(ZONE),PERSONAL)
# 	@$(foreach cask,$(PERSONAL_CASKS),$(call CASK,$(cask)))
# endif
# ifeq ($(ZONE),WORK)
# 	@$(foreach cask,$(WORK_CASKS),$(call CASK,$(cask)))
# endif

	brew tap | grep 'domt4/autoupdate' > /dev/null || \
		brew tap domt4/autoupdate
	brew autoupdate status | grep installed || \
		brew autoupdate start 43200 --upgrade --cleanup --immediate --ac-only

list:
	brew list --installed-on-request
	brew list --cask
