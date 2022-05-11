PKG_NAME=ex_ample
MIX_ENV?=prod
BUILD_DIR=_build
REL_DIR=$(BUILD_DIR)/$(MIX_ENV)/rel/$(PKG_NAME)

STAGEDIR=_stage
TMP_DIR=tmp
PKG_PLIST=$(TMP_DIR)/pkg-plist

LOCAL_DIR=$(STAGEDIR)/usr/local
LIBEXEC_DIR=$(LOCAL_DIR)/libexec/$(PKG_NAME)
BIN_DIR=$(LOCAL_DIR)/bin
BIN=$(BIN_DIR)/$(PKG_NAME)

all : test release

release : $(REL_DIR)

$(REL_DIR) : deps
	MIX_ENV=$(MIX_ENV) mix release

test : deps
	mix test

deps:
	mix deps.get

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(STAGEDIR)
	rm -f $(PKG_NAME)*.pkg
	rm -f $(PKG_PLIST)

package : $(PKG_PLIST)
	pkg create -M +MANIFEST -r $(STAGEDIR)/ -p $(PKG_PLIST)

$(PKG_PLIST) : $(LIBEXEC_DIR) $(BIN)
	@mkdir -p $(TMP_DIR)
	@rm -f $(PKG_PLIST)
	find $(STAGEDIR) -type f -or -type l | sed 's%$(STAGEDIR)%%' > $(PKG_PLIST)

$(BIN):
	@mkdir -p $(BIN_DIR)
	@rm -f $(BIN)
	ln -s /usr/local/libexec/$(PKG_NAME)/bin/$(PKG_NAME) $(BIN)

$(LIBEXEC_DIR) : $(REL_DIR)
	@rm -rf $(LIBEXEC_DIR)
	@mkdir -p $(LIBEXEC_DIR)
	cp -R $(REL_DIR)/  $(LIBEXEC_DIR)
