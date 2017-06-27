TOP := .

all: _all

include Ruby.mk

_all: $(ALL_TARGETS)
clean: $(CLEAN_TARGETS)
