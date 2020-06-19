#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DAEMON_DIR=/usr/bin
SERVICE_FILE_NAME=sample-tcp-server.service
SERVICE_FILE=${SCRIPT_DIR}/${SERVICE_FILE_NAME}
TEMPLATE=$(sed "s,DAEMON_PATH,$DAEMON_DIR,g" << EOF
[Unit]
Description=Sample TCP Server

[Service]
Type=simple
EnvironmentFile=/var/run/sample-tcp-server/env
ExecStart=DAEMON_PATH/tcp-server.py
ExecStop=/usr/bin/pkill -F /var/run/sample-tcp-server/tcp-server.pid

[Install]
WantedBy=multi-user.target
EOF
)

cp ${SCRIPT_DIR}/tcp-server.py ${DAEMON_DIR}/tcp-server.py
mkdir -p /var/run/sample-tcp-server
touch /var/run/sample-tcp-server/env
echo -e "${TEMPLATE}" > /${SERVICE_FILE}
cp ${SERVICE_FILE} /lib/systemd/system/${SERVICE_FILE_NAME}
systemctl daemon-reload

