#!/bin/sh

   
clib=`ldd /bin/bash | grep libc.so.6 | awk '{print $3}'`
wdir=`pwd`

test "$wdir" != "" && test "$clib" != "" && test -f $clib || exit

echo "#ifndef _STD_LIBC_H" > std_libc.h
echo "#define _STD_LIBC_H" >> std_libc.h
echo "" >> std_libc.h
echo "#define STD_LIBC_PATH \"$clib\"" >> std_libc.h
echo "#define LOGGER_PATH \"$wdir\"" >> std_libc.h
echo "" >> std_libc.h
echo "#endif" >> std_libc.h
