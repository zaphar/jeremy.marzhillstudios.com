#!/bin/bash
#===============================================================================
#
#          FILE:  submit.sh
# 
#         USAGE:  ./submit.sh 
# 
#   DESCRIPTION:  Sync the webpage with the remote server to publish to
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Jeremy Wall (jw), jeremy@marzhillstudios.com
#       COMPANY:  Marzhillstudios.com
#       VERSION:  1.0
#       CREATED:  07/09/2010 21:51:59 CDT
#      REVISION:  ---
#===============================================================================

wd=$(dirname $0)

rsync --rsh=ssh --delete --checksum --recursive $* \
   $wd/generated/* zaphar.xen.prgmr.com:/home/jwall/www
