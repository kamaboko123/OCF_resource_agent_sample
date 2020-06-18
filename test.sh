#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [ `whoami` != 'root' ]; then
    echo "You need to be root to perform this command."
    exit -1
fi

echo "--- Install sample-tcp-server-daemon ---"
${SCRIPT_DIR}/daemon/install.sh
echo

echo "--- Test OCF script with sample-tcp-server-daemon ---"
sudo ocf-tester -n sample -o greet=Hi ./sample-script
echo

echo "--- Uninstall sample-tcp-server-daemon ---"
${SCRIPT_DIR}/daemon/uninstall.sh
echo "--- Test finished ---"

