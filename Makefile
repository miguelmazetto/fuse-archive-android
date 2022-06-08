
override LDFLAGS += -L$(JNIOUTDIR) -lfuse -pthread -larchive -lcrypto -lexpat -llzo2 -llzma -lzstd -llz4 -lcharset -lbz2 -lz
override CXXFLAGS += -I$(LIBARCHIVE_INC) -I$(LIBFUSE_INC) -D_FILE_OFFSET_BITS=64 -static-libstdc++

prefix=/usr
bindir=$(prefix)/bin

all: out/fuse-archive

check: all
	go run test/go/check.go

clean:
	rm -rf out

install: all
	mkdir -p "$(DESTDIR)$(bindir)"
	install out/fuse-archive "$(DESTDIR)$(bindir)"

uninstall:
	rm "$(DESTDIR)$(prefix)/bin/fuse-archive"

out/fuse-archive: src/main.cc
	mkdir -p out
	$(CXX) $(CXXFLAGS) $(pkgcflags) $< $(LDFLAGS) $(pkglibs) -o $@

.PHONY: all check clean
