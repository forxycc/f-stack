TOPDIR?=${CURDIR}/../..

ifneq ($(shell pkg-config --exists libdpdk && echo 0),0)
$(error "no installation of DPDK found, maybe you shuld export environment variable `PKG_CONFIG_PATH`")
endif

TARGET=libffcompat.a

#DEBUG=-O0 -gdwarf-2 -g3

include ${TOPDIR}/tools/opts.mk
ifneq (${MK_INET6_SUPPORT},"no")
CFLAGS+= -DINET6
endif

PKGCONF ?= pkg-config

DPDK_CFLAGS= -g -Wall -Werror -Wno-deprecated-declarations $(shell $(PKGCONF) --cflags libdpdk)

CFLAGS+= ${DPDK_CFLAGS} -I${CURDIR}/include

ifeq (${CROSS_COMPILE}, aarch64-linux-gnu-)
CFLAGS+= -include${ARM_TOOLCHAN}/aarch64-linux-gnu/libc/usr/include/sys/user.h
CC = aarch64-linux-gnu-gcc
endif

CFLAGS+= -I${TOPDIR}/lib -D__BSD_VISIBLE -DFSTACK

SRCS=$(wildcard *.c)
OBJS=$(patsubst %.c,%.o,${SRCS})

all: ${TARGET}

${TARGET}: ${OBJS}
	ar -cqs $@ ${OBJS}

${OBJS}: %.o: %.c
	${CC} -c $< ${CFLAGS} -o $@ 


.PHONY: clean
clean:
	rm -f *.o ${TARGET}
