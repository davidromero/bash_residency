#!/bin/bash

check_is_running(){
	
	if [[ -z $(pgrep $1) ]]; then
		echo "No process Running"
	else
		echo "$1" "is already running"
	fi	
}


check_is_running firefox

check_is_running lambda

check_is_running calibre

check_is_running idea
