PKG_NAME=ex_ample
MIX_ENV?=prod
BUILD_DIR=_build/$(MIX_ENV)
REL_DIR=$(BUILD_DIR)/rel/$(PKG_NAME)

PKG_PLIST=pkg-plist

STAGEDIR=_stage
LIBEXEC_DIR=$(PREFIX)/libexec
BIN=$(PREFIX)/bin/$(PKG_NAME)

all : $(PKG_PLIST)

install : all
	cp -R $(REL_DIR) $(LIBEXEC_DIR)
	ln -s $(LIBEXEC_DIR)/$(PKG_NAME)/bin/$(PKG_NAME) $(BIN)

$(PKG_PLIST) : $(BUILD_DIR)
	rm -f $(PKG_PLIST)

	find $(STAGEDIR) -type f | sed 's#$(STAGEDIR)/##' > $(PKG_PLIST)
	find $(STAGEDIR) -type l | sed 's#$(STAGEDIR)/##' >> $(PKG_PLIST)

$(BUILD_DIR):
	MIX_ENV=$(MIX_ENV) mix release

clean:
#	rm -rf $(STAGEDIR)
	rm -rf $(BUILD_DIR)
	rm -f $(PKG_NAME)*.pkg
	rm -f $(PKG_PLIST)
