#!/bin/bash

for arg in $*
do
	case $arg in
		-f)
			file=
		-t)
			force="yes"
			;;
	esace

done

