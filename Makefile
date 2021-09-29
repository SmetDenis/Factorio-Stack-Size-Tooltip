.PHONY: build
.DEFAULT_GOAL := build

MOD_VERSION := $(shell cat ./info.json | jq -r '.version')
MOD_ALIAS   := $(shell cat ./info.json | jq -r '.name')
MOD_PATH    := "/Users/smetdenis/Library/Application Support/factorio/mods/$(MOD_ALIAS)_$(MOD_VERSION)"

build:
	@echo "\033[0;33m>>> >>> >>> >>> >>> >>> >>> >>> \033[0;30;46m Building New Package v$(MOD_VERSION) \033[0m"
	@rm    -fr ./build
	@mkdir -p  ./build
	@rsync -av `pwd` `pwd`/build            \
        --exclude build                     \
        --exclude .git                      \
        --exclude .idea                     \
        --exclude .gitignore                \
        --exclude $(MOD_ALIAS).zip
	cd ./build; zip -r9q $(MOD_ALIAS).zip *
	@mv `pwd`/build/$(MOD_ALIAS).zip `pwd`/$(MOD_ALIAS).zip
	@echo "It's ready"


install:
	@make build
	@echo "\033[0;33m>>> >>> >>> >>> >>> >>> >>> >>> \033[0;30;46m Install package \033[0m"
	@rm -fr $(MOD_PATH)
	@cp -r ./build/Factorio-Stack-Size-Tooltip $(MOD_PATH)
	@echo "Start the game and check the result"
