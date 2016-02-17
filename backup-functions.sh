#!/bin/bash

# Logging Functions ----------------------
# found on http://urbanautomaton.com/blog/2014/09/09/redirecting-bash-script-output-to-syslog/

readonly SCRIPT_NAME=$(basename $0)

log() {
  echo "$@"
  logger -p user.notice -t $SCRIPT_NAME "$@"
}

err() {
  echo "$@" >&2
  logger -p user.error -t $SCRIPT_NAME "$@"
}

# Returncode Testing ---------------------

exitOnError() {
	if [ $? -ne 0 ]; then
		err "$1"
		exit $2	
	fi 
}
