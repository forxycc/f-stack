TOPDIR=..

ifeq ($(FF_PATH),)
	FF_PATH=${TOPDIR}
endif

ifneq ($(shell pkg-config --exists libdpdk && echo 0),0)
$(error "no installation of DPDK found, maybe you shuld export environment variable `PKG_CONFIG_PATH`")
endif

PKGCONF ?= pkg-config

CFLAGS += -O -gdwarf-2 $(shell $(PKGCONF) --cflags libdpdk)
CFLAGS += -I${FF_PATH}/lib

LIBS+= $(shell $(PKGCONF) --static --libs libdpdk)
LIBS+= -L${FF_PATH}/lib -Wl,--whole-archive,-lfstack,--no-whole-archive
LIBS+= -Wl,--no-whole-archive -lrt -lm -ldl -pthread 

ifeq (${CROSS_COMPILE}, aarch64-linux-gnu-)
LIBS+= ${OPENSSL_PATH}/lib/libcrypto.a
CC = aarch64-linux-gnu-gcc
else
LIBS+= -lcrypto -lnuma 
endif

TARGET="helloworld"
all:
	$(CC) ${CFLAGS} -o ${TARGET} main.c ${LIBS}
	$(CC) ${CFLAGS} -o ${TARGET}_epoll main_epoll.c ${LIBS}

.PHONY: clean
clean:
	rm -f *.o ${TARGET} ${TARGET}_epoll
