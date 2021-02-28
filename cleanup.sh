#!/bin/bash

find . -name "*.o" |xargs -r rm
find . -name "*.a" |xargs -r rm
rm -rf dpdk/cross-build
rm -rf dpdk/build
rm -rf tools/sbin/*
rm -rf example/helloworld
rm -rf example/helloworld_epoll
