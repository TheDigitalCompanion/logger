#!/bin/sh

#installation script for logger (for system wide installs)
#Run as root!

[ -x /lib/logger.so ] && {
  touch /etc/ld.so.preload
  [ -w /etc/ld.so.preload ] && {
    [ `grep -c '/lib/logger.so'    /etc/ld.so.preload` == 0 ] && {
      echo     "/lib/logger.so" >> /etc/ld.so.preload
      echo "Installed"
    } || echo "logger already installed... updated to newest version"
  }   || echo "Failed, are you installing this as root?"
}     || echo "Failed, are you installing this as root?"
