#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
SERVICE_FILE_NAME=sample-tcp-server.service
SERVICE_FILE=${SCRIPT_DIR}/${SERVICE_FILE_NAME}
TEMPLATE=$(sed "s,DAEMON_PATH,$SCRIPT_DIR,g" << EOF
[Unit]
Description=Sample TCP Server

[Service]
Type=simple
EnvironmentFile=/tmp/sample-tcp-server/env
ExecStart=DAEMON_PATH/tcp-server.py
ExecStop=/usr/bin/pkill -F /tmp/ocf_sample/ocf_sample.pid

[Install]
WantedBy=multi-user.target
EOF
)

mkdir -p /tmp/sample-tcp-server
touch /tmp/sample-tcp-server/env
echo -e "${TEMPLATE}" > /${SERVICE_FILE}
ln -s ${SERVICE_FILE} /etc/systemd/system/${SERVICE_FILE_NAME}
systemctl daemon-reload
