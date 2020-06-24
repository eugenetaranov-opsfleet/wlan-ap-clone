.PHONY: all opensync clean purge

all:
	./dock-run.sh ./build.sh $(TARGET) $(SDK_URL)

opensync:
	./dock-run.sh make -C openwrt package/feeds/opensync/opensync/clean
	./dock-run.sh make -j$(nproc) V=s -C openwrt package/feeds/opensync/opensync/compile TARGET=$(TARGET) OPENSYNC_SRC=$(shell pwd)

clean:
	./dock-run.sh make -C openwrt package/feeds/opensync/opensync/clean

purge:
	cd openwrt && rm -rf * && rm -rf .*
	rm -rf ./example/build
	@echo Done
