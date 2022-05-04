PKG_NAME=ex_ample
MIX_ENV?=prod
BUILD_DIR=_build/$(MIX_ENV)
REL_DIR=$(BUILD_DIR)/rel/$(PKG_NAME)

PKG_PLIST=pkg-plist

STAGEDIR=_stage
LOCAL_DIR=$(STAGEDIR)$(PREFIX)
LIBEXEC_DIR=$(LOCAL_DIR)/libexec/$(PKG_NAME)
BIN_DIR=$(LOCAL_DIR)/bin
BIN=$(BIN_DIR)/$(PKG_NAME)

build:
	MIX_ENV=$(MIX_ENV) mix release
	find $(REL_DIR) -type f | sed 's#$(REL_DIR)/##' > $(PKG_PLIST)

install:
	mkdir -p $(LIBEXEC_DIR)
	cp -R $(REL_DIR)/ $(LIBEXEC_DIR)
	mkdir -p $(BIN_DIR)
	ln -s $(LIBEXEC_DIR)/bin/$(PKG_NAME) $(BIN)

#clean:
#	rm -rf $(STAGEDIR)
#	rm -rf $(BUILD_DIR)
#	rm -f $(PKG_NAME)*.pkg
#	rm -f $(PKG_PLIST)
