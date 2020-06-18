#!/bin/bash

SERVICE_FILE_NAME=sample-tcp-server.service
systemctl stop ${SERVICE_FILE_NAME}
unlink /etc/systemd/system/${SERVICE_FILE_NAME}
systemctl daemon-reload
