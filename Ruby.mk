SSN_PROJECT_DIR ?= $(TOP)

ALL_TARGETS += SSN_all
CLEAN_TARGETS += SSN_clean

SSN_STAMP := $(SSN_PROJECT_DIR)/rails-simple-socialnet.stamp


# rbenv build definitions
SSN_RBENV_PATH := $(SSN_PROJECT_DIR)/rbenv
SSN_RBENV_BIN := $(SSN_RBENV_PATH)/bin/rbenv
SSN_RBENV_SRC := $(SSN_PROJECT_DIR)/tools/rbenv.tar

SSN_RUBY_VERSION = ruby-2.2.6
SSN_RUBY_PKG := $(SSN_RUBY_VERSION).tar.gz
SSN_RUBY_URL := http://cache.ruby-lang.org/pub/ruby/2.2/$(SSN_RUBY_PKG)

SSN_RUBY_PKG_PATH := $(SSN_RBENV_PATH)/$(SSN_RUBY_PKG)
SSN_RUBY_SRC_PATH := $(SSN_RBENV_PATH)/$(SSN_RUBY_VERSION)
SSN_RUBY_DST_PATH := $(SSN_RBENV_PATH)/versions/$(SSN_RUBY_VERSION)
SSN_RUBY_BIN := $(SSN_RUBY_DST_PATH)/bin/ruby

SSN_GEM_STAMP := $(SSN_PROJECT_DIR)/Gemfile.lock

#
# Main targets
#

.PHONY: SSN_all SSN_clean

SSN_all: $(SSN_STAMP) ;

SSN_clean:
	rm -fr $(SSN_STAMP) $(SSN_RBENV_PATH) $(SSN_GEM_STAMP)


$(SSN_RUBY_PKG_PATH):
ifdef SSN_RBENV_ROOT
	mkdir -p $(SSN_RBENV_ROOT) || true
	tar -C $(SSN_RBENV_ROOT) -xf $(SSN_RBENV_SRC)
	rm -fr $(SSN_RBENV_PATH)
	ln -s $(SSN_RBENV_ROOT)/rbenv $(SSN_RBENV_PATH)
else
	tar -C $(SSN_PROJECT_DIR) -xf $(SSN_RBENV_SRC)
endif
	curl -z $(SSN_RUBY_PKG_PATH) -o $(SSN_RUBY_PKG_PATH) $(SSN_RUBY_URL)

$(SSN_RUBY_SRC_PATH): $(SSN_RUBY_PKG_PATH)
	( cd $(SSN_RBENV_PATH) && tar -xzf $(SSN_RUBY_PKG) )

$(SSN_RUBY_BIN): $(SSN_RUBY_PKG_PATH) | $(SSN_RUBY_SRC_PATH)
	( cd $(SSN_RUBY_SRC_PATH) && \
	  ./configure --prefix=$(abspath $(SSN_RUBY_DST_PATH)) $(SSN_CONFIGURE_FLAGS) && \
	  $(MAKE) install )
	RBENV_ROOT=$(abspath $(SSN_RBENV_PATH)) $(SSN_RBENV_BIN) global $(SSN_RUBY_VERSION)

SSN_RUBY_SRCS = $(wildcard $(SSN_PROJECT_DIR)/dummy/*.rb) \

$(SSN_RUBY_DST_PATH)/bin/bundler: $(SSN_RUBY_BIN)
	RBENV_ROOT=$(abspath $(SSN_RBENV_PATH)) $(SSN_RBENV_BIN) exec gem install bundler
	
$(SSN_GEM_STAMP): $(SSN_RUBY_BIN) $(SSN_PROJECT_DIR)/Gemfile $(SSN_RUBY_DST_PATH)/bin/bundler
	( cd $(SSN_PROJECT_DIR) && RBENV_ROOT=$(abspath $(SSN_RBENV_PATH)) $(abspath $(SSN_RBENV_BIN)) exec bundle update )
	@touch $@
	
$(SSN_STAMP): $(SSN_RUBY_BIN) $(SSN_GEM_STAMP) $(SSN_RUBY_SRCS)
	@touch $@
