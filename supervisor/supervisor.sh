#!/bin/bash

mkdir -p logs

# Wrap the 'supervisorctl' command
OPTIONS="$@"
CONF_FILE="supervisor/supervisord.conf"
if [ ! -e /data/data/com.termux/files/usr/tmp/supervisor.sock ]; then
    supervisord -c $CONF_FILE
fi
supervisorctl -c $CONF_FILE $OPTIONS

