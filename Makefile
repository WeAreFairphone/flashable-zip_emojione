# Makefile by Roberto M.F. (Roboe)
# https://github.com/WeAreFairphone/flashabe-zip_emojione

SOURCE       := ./src/
SOURCEFILES  := $(shell find $(SOURCE) 2> /dev/null | sort)

FLASHABLEZIP := ./build/emojione.zip
RELEASENAME  := "emojione-v2_%Y-%m-%d.zip"

EMOJIONE_VERSION := 2.2.7
EMOJIONE_FONT    := ./assets/emojione-android_$(EMOJIONE_VERSION).ttf
EMOJIONE_URL     := https://github.com/Ranks/emojione/raw/v$(EMOJIONE_VERSION)/assets/fonts/emojione-android.ttf
EMOJIONE_DEST    := ./src/emojione-android.ttf


.PHONY: all build clean release
all: build

build: $(FLASHABLEZIP)
$(FLASHABLEZIP): $(SOURCEFILES) $(EMOJIONE_FONT)
	@echo "Building flashable ZIP..."
	@mkdir -pv `dirname $(FLASHABLEZIP)`
	@cp -f "$(EMOJIONE_FONT)" "$(EMOJIONE_DEST)"
	@rm -f "$(FLASHABLEZIP)"
	@cd "$(SOURCE)" && zip \
	"../$(FLASHABLEZIP)" . \
	--recurse-path \
	--exclude '*.asc' '*.xml'
	@echo "Result: $(FLASHABLEZIP)"

$(EMOJIONE_FONT):
	@echo "Downloading emojione..."
	@mkdir -pv `dirname $(EMOJIONE_FONT)`
	@curl \
	-L "$(EMOJIONE_URL)" \
	-o "$(EMOJIONE_FONT)" \
	--connect-timeout 30

clean:
	@echo Removing built files...
	rm -f "$(EMOJIONE_DEST)"
	rm -f "$(FLASHABLEZIP)"
	@# only remove dir if it's empty:
	@rmdir -p `dirname $(FLASHABLEZIP)` 2>/dev/null || true

release: $(FLASHABLEZIP)
	@mkdir -pv release
	cp "$(FLASHABLEZIP)" "release/$$(date +$(RELEASENAME))"
