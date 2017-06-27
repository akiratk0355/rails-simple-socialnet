MAL_PROJECT_DIR ?= $(TOP)

ALL_TARGETS += MAL_all
CLEAN_TARGETS += MAL_clean

SYSPKG_APT_INST_FILES += $(wildcard $(MAL_PROJECT_DIR)/syspkg/*.aptinst)

MAL_STAMP := $(MAL_PROJECT_DIR)/rails-testapp.stamp


# rbenv build definitions
MAL_RBENV_PATH := $(MAL_PROJECT_DIR)/rbenv
MAL_RBENV_BIN := $(MAL_RBENV_PATH)/bin/rbenv
MAL_RBENV_SRC := $(MAL_PROJECT_DIR)/tools/rbenv.tar

MAL_RUBY_VERSION = ruby-2.2.6
MAL_RUBY_PKG := $(MAL_RUBY_VERSION).tar.gz
MAL_RUBY_URL := http://cache.ruby-lang.org/pub/ruby/2.2/$(MAL_RUBY_PKG)

MAL_RUBY_PKG_PATH := $(MAL_RBENV_PATH)/$(MAL_RUBY_PKG)
MAL_RUBY_SRC_PATH := $(MAL_RBENV_PATH)/$(MAL_RUBY_VERSION)
MAL_RUBY_DST_PATH := $(MAL_RBENV_PATH)/versions/$(MAL_RUBY_VERSION)
MAL_RUBY_BIN := $(MAL_RUBY_DST_PATH)/bin/ruby

MAL_GEM_STAMP := $(MAL_PROJECT_DIR)/Gemfile.lock

#
# Main targets
#

.PHONY: MAL_all MAL_clean

MAL_all: $(MAL_STAMP) ;

MAL_clean:
	rm -fr $(MAL_STAMP) $(MAL_RBENV_PATH) $(MAL_GEM_STAMP)


$(MAL_RUBY_PKG_PATH):
ifdef MAL_RBENV_ROOT
	mkdir -p $(MAL_RBENV_ROOT) || true
	tar -C $(MAL_RBENV_ROOT) -xf $(MAL_RBENV_SRC)
	rm -fr $(MAL_RBENV_PATH)
	ln -s $(MAL_RBENV_ROOT)/rbenv $(MAL_RBENV_PATH)
else
	tar -C $(MAL_PROJECT_DIR) -xf $(MAL_RBENV_SRC)
endif
	curl -z $(MAL_RUBY_PKG_PATH) -o $(MAL_RUBY_PKG_PATH) $(MAL_RUBY_URL)

$(MAL_RUBY_SRC_PATH): $(MAL_RUBY_PKG_PATH)
	( cd $(MAL_RBENV_PATH) && tar -xzf $(MAL_RUBY_PKG) )

$(MAL_RUBY_BIN): $(MAL_RUBY_PKG_PATH) | $(MAL_RUBY_SRC_PATH)
	( cd $(MAL_RUBY_SRC_PATH) && \
	  ./configure --prefix=$(abspath $(MAL_RUBY_DST_PATH)) $(MAL_CONFIGURE_FLAGS) && \
	  $(MAKE) install )
	RBENV_ROOT=$(abspath $(MAL_RBENV_PATH)) $(MAL_RBENV_BIN) global $(MAL_RUBY_VERSION)

MAL_RUBY_SRCS = $(wildcard $(MAL_PROJECT_DIR)/dummy/*.rb) \

$(MAL_RUBY_DST_PATH)/bin/bundler: $(MAL_RUBY_BIN)
	RBENV_ROOT=$(abspath $(MAL_RBENV_PATH)) $(MAL_RBENV_BIN) exec gem install bundler
	
$(MAL_GEM_STAMP): $(MAL_RUBY_BIN) $(MAL_PROJECT_DIR)/Gemfile $(MAL_RUBY_DST_PATH)/bin/bundler
	( cd $(MAL_PROJECT_DIR) && RBENV_ROOT=$(abspath $(MAL_RBENV_PATH)) $(abspath $(MAL_RBENV_BIN)) exec bundle update )
	@touch $@
	
$(MAL_STAMP): $(MAL_RUBY_BIN) $(MAL_GEM_STAMP) $(MAL_RUBY_SRCS)
	@touch $@

