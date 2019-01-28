#!/usr/bin/sh
#
# Check OpenGrok indexer logs in the last 24 hours for any signs of serious
# trouble.
#

if (( $# != 1 )); then
        print -u2 "usage: $0 <project_name>"
        exit 1
fi

project_name=$1

typeset -r log_dir="${SNAP_COMMON}/log/$project_name/"
if [[ ! -d $log_dir ]]; then
        print -u2 "cannot open log directory $log_dir"
        exit 1
fi

# Check the last log file.
if grep SEVERE "$log_dir/opengrok0.0.log"; then
        exit 1
fi
