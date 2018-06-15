# Makefile by Roberto M.F. (Roboe)
# https://github.com/WeAreFairphone/flashabe-zip_emojione

SOURCE       := ./src/
SOURCEFILES  := $(shell find $(SOURCE) 2> /dev/null | sort)

EMOJIONE_VERSION := 2.2.7
EMOJIONE_FONT    := ./assets/emojione-android_$(EMOJIONE_VERSION).ttf
EMOJIONE_URL     := https://github.com/Ranks/emojione/raw/v$(EMOJIONE_VERSION)/assets/fonts/emojione-android.ttf
EMOJIONE_DEST    := ./src/emojione-android.ttf

FLASHABLEZIP := ./build/emojione.zip
RELEASENAME  := $(shell date +"emojione-v$(EMOJIONE_VERSION)_%Y-%m-%d.zip")
RELEASEZIP   := release/$(RELEASENAME)

.PHONY: all build clean release install
all: build

build: $(FLASHABLEZIP)
$(FLASHABLEZIP): $(SOURCEFILES) $(EMOJIONE_FONT)
	@echo "Building flashable ZIP..."
	@mkdir -pv "$(@D)"
	@cp -f "$(EMOJIONE_FONT)" "$(EMOJIONE_DEST)"
	@rm -f "$@"
	@cd "$(SOURCE)" && zip \
		"../$@" . \
		--recurse-path \
		--exclude '*.asc' '*.xml'
	@echo "Result: $@"

$(EMOJIONE_FONT):
	@echo "Downloading emojione..."
	@mkdir -pv "$(@D)"
	@curl \
		-L "$(EMOJIONE_URL)" \
		-o "$@" \
		--connect-timeout 30

clean:
	@echo Removing built files...
	rm -f "$(EMOJIONE_DEST)"
	rm -f "$(FLASHABLEZIP)"
	@# only remove dir if it's empty:
	@rmdir -p `dirname $(FLASHABLEZIP)` 2>/dev/null || true

release: $(RELEASEZIP)
$(RELEASEZIP): $(FLASHABLEZIP)
	@mkdir -pv "$(@D)"
	@echo -n "Release file: "
	@cp -v "$(FLASHABLEZIP)" "$@"

install: $(FLASHABLEZIP)
	@echo "Waiting for ADB sideload mode"
	@adb wait-for-sideload
	@adb sideload $(FLASHABLEZIP)
