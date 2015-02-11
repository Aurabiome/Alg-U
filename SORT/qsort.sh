#!/bin/bash
 
filter () {
	f="$1"; shift
	for e in "$@"; do
		if $f "$e"; then
			echo -n "$e "
		fi
	done
}
 
qsort () {
	if [ $# -gt 1 ]; then
		p="$1"; shift
		qsort $(filter "test $p -lt" "$@")
		echo -n "$p "
		qsort $(filter "test $p -ge" "$@")
	elif [ $# -eq 1 ]; then
		echo -n "$1 "
	fi
}
 
qsort 10 3 5 2 20
