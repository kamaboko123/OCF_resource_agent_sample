TEMPLATE=$(sed "s,DAEMON_DIR,$DAEMON_DIR,g" << EOF
[Unit]
Description=Sample TCP Server

[Service]
Type=simple
EnvironmentFile=/var/run/sample-tcp-server/env
ExecStart=DAEMON_DIR/tcp-server.py
ExecStop=/usr/bin/pkill -F /var/run/sample-tcp-server/tcp-server.pid

[Install]
WantedBy=multi-user.target
EOF
)

echo "${TEMPLATE}"

