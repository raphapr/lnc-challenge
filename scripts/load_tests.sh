#!/bin/bash
#===============================================================================
#
#          FILE: load_test.sh
# 
#         USAGE: ./load_test "http://localhost"
# 
#   DESCRIPTION: Web server load testing and returns maximum throughput
# 
#       OPTIONS: ---
#  DEPENDENCIES: wrk
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Raphael P. Ribeiro
#       CREATED: 12-03-2017 16:09
#===============================================================================

ADDR=$1

if [[ $# -eq 0 ]] ; then
    ADDR="http://localhost"
fi

tput=$(wrk -t18 -c200 -d30s $ADDR | tail -2 | head -1 | awk '{print $2 }')

echo "Maximum throughput: $tput requests/sec"
