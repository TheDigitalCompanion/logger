# Makefile for logger 

CC = gcc
LIBS  = -ldl

all: logger.so detect start

logger.so:  logger.c std_libc.h
	$(CC) -shared -O2 -fPIC logger.c -ologger.so $(LIBS)

detect: detect.c std_libc.h
	$(CC) detect.c -o detect $(LIBS)

start: start.c std_libc.h
	$(CC) start.c -o start $(LIBS)

install: all 
	install -m 755 logger.so /lib/logger.so; \
	./install.sh

std_libc.h: check_std_libc.sh
	./check_std_libc.sh

test: all
	./detect
	./start ./detect

clean:
	rm -f detect logger.so start std_libc.h 

