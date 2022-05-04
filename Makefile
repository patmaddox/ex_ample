PKG_NAME=ex_ample
MIX_ENV?=prod
BUILD_DIR=_build/$(MIX_ENV)
REL_DIR=$(BUILD_DIR)/rel/$(PKG_NAME)

PKG_PLIST=pkg-plist

STAGEDIR=_stage
LOCAL_DIR=$(STAGEDIR)/usr/local
LIBEXEC_DIR=$(LOCAL_DIR)/libexec/$(PKG_NAME)
BIN_DIR=$(LOCAL_DIR)/bin
BIN=$(BIN_DIR)/$(PKG_NAME)

$(PKG_PLIST) : $(LIBEXEC_DIR) $(BIN)
	rm -f $(PKG_PLIST)

	find $(STAGEDIR) -type f | sed 's#$(STAGEDIR)/##' > $(PKG_PLIST)
	find $(STAGEDIR) -type l | sed 's#$(STAGEDIR)/##' >> $(PKG_PLIST)

$(BIN):
	mkdir -p $(BIN_DIR)
	rm -f $(.TARGET)
	ln -s /usr/local/libexec/$(PKG_NAME)/bin/$(PKG_NAME) $(.TARGET)

$(LIBEXEC_DIR) : $(BUILD_DIR)
	@rm -rf $(.TARGET)
	@mkdir -p $(.TARGET)
	cp -R $(REL_DIR)/  $(.TARGET)

$(BUILD_DIR):
	MIX_ENV=$(MIX_ENV) mix release

clean:
#	rm -rf $(STAGEDIR)
	rm -rf $(BUILD_DIR)
	rm -f $(PKG_NAME)*.pkg
	rm -f $(PKG_PLIST)
