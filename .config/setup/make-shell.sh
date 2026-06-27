#!/bin/sh
tput dim
trap 'tput sgr0' EXIT
[ "$1" = "-c" ] && shift
eval "$1"
