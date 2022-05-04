PKG_NAME=ex_ample
MIX_ENV?=prod
BUILD_DIR=_build/$(MIX_ENV)
REL_DIR=$(BUILD_DIR)/rel/$(PKG_NAME)

PKG_SRC_DIR=_pkg_src
TMP_DIR=tmp
PKG_PLIST=$(TMP_DIR)/pkg-plist

LOCAL_DIR=$(PKG_SRC_DIR)/usr/local
LIBEXEC_DIR=$(LOCAL_DIR)/libexec/$(PKG_NAME)
BIN_DIR=$(LOCAL_DIR)/bin
BIN=$(BIN_DIR)/$(PKG_NAME)

package : $(PKG_PLIST)
	pkg create -M +MANIFEST -r $(PKG_SRC_DIR)/ -p $(PKG_PLIST)

$(PKG_PLIST) : $(LIBEXEC_DIR) $(BIN)
	mkdir -p $(TMP_DIR)
	rm -f $(PKG_PLIST)

	find $(PKG_SRC_DIR) -type f | sed 's#$(PKG_SRC_DIR)##' > $(PKG_PLIST)
	find $(PKG_SRC_DIR) -type l | sed 's#$(PKG_SRC_DIR)##' >> $(PKG_PLIST)

$(BIN):
	mkdir -p $(BIN_DIR)
	rm -f $(BIN)
	ln -s /usr/local/libexec/$(PKG_NAME)/bin/$(PKG_NAME) $(BIN)

$(LIBEXEC_DIR) : $(BUILD_DIR)
	@rm -rf $(.TARGET)
	@mkdir -p $(LIBEXEC_DIR)
	cp -R $(REL_DIR)/  $(.TARGET)

$(BUILD_DIR):
	MIX_ENV=$(MIX_ENV) mix release

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(PKG_SRC_DIR)
	rm -f $(PKG_NAME)*.pkg
	rm -f $(PKG_PLIST)
