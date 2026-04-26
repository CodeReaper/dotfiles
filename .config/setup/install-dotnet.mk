# cspell:disable

CURFILE := $(lastword $(MAKEFILE_LIST))
VERSIONFILE := .versions

all:
	@-rm -f /tmp/versions /tmp/dotnet-*.tar.gz

	curl -sfL https://builds.dotnet.microsoft.com/dotnet/release-metadata/releases-index.json \
		| jq -r '."releases-index"[] | select(."support-phase" == "active") | ."latest-sdk"' \
		| sort -V \
		| tee /tmp/versions

	cmp -s /tmp/versions ~/.dotnet/$(VERSIONFILE) 2>/dev/null && true || make -f $(CURFILE) install-dotnet

install-dotnet:
	make -f $(CURFILE) download-dotnet || make -f $(CURFILE) restore-dotnet

	@sh -c 'export PATH="$$PATH:$$(realpath ~/.dotnet/)" \
		&& export DOTNET_ROOT=$$(realpath ~/.dotnet/) \
		&& dotnet --list-sdks \
		&& dotnet --info'

restore-dotnet:
	test -d ~/.dotnet.backup
	rm -rf ~/.dotnet
	mv ~/.dotnet.backup ~/.dotnet

download-dotnet:
	@-rm -rf ~/.dotnet.backup
	-mv ~/.dotnet ~/.dotnet.backup

	< /tmp/versions xargs -n1 -I{} \
		curl -sfLo /tmp/dotnet-{}.tar.gz \
		https://builds.dotnet.microsoft.com/dotnet/Sdk/{}/dotnet-sdk-{}-$(shell uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/osx/')-$(shell uname -m).tar.gz

	mkdir -p ~/.dotnet

	< /tmp/versions xargs -n1 -I{} \
		tar -xzf /tmp/dotnet-{}.tar.gz -C ~/.dotnet/

ifneq ($(shell uname -s),Linux)
	xattr -r -d com.apple.quarantine ~/.dotnet
endif

	mv /tmp/versions ~/.dotnet/$(VERSIONFILE)
