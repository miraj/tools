#!/bin/bash

usage ()
{
	echo
	echo "Usage:"
    echo "   $0  <options>"
	echo

}

file=''
verbose=no
debug=no

while [[ $# -ne 0 ]] 
do

	case $1 in
		-f)
			file=$2
			shift
			;;
		-v)
			verbose=yes
			;;
		-d)
			debug=yes
			;;
		 *)
            echo Unknown option:  $arg
			;;
	esac
	shift
done


[[ $file == '' ]] && { echo File Must be specified; usage; exit 2; }

## More validations to be done here 


