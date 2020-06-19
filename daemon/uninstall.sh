#!/bin/bash

DAEMON_DIR=/usr/bin
SERVICE_FILE_NAME=sample-tcp-server.service
systemctl stop ${SERVICE_FILE_NAME}
rm /lib/systemd/system/${SERVICE_FILE_NAME}
systemctl daemon-reload

rm ${DAEMON_DIR}/tcp-server.py
rm -r /var/run/sample-tcp-server

