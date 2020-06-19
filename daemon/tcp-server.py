#!/usr/bin/python3
import os
import socket
import threading
import time
import signal
import sys

PORT = 5678
PID_FILE_DIR = "/var/run/sample-tcp-server"
PID_FILE_NAME = "tcp-server.pid"
PID_FILE = "%s/%s" % (PID_FILE_DIR, PID_FILE_NAME)
EXIT = False
GREET = os.environ.get("GREET", "Hello!")

def signal_handler(signum, stack):
    EXIT = True

def server():
    os.makedirs(PID_FILE_DIR, exist_ok=True)
    if os.path.isfile(PID_FILE):
        raise Exception("Already running")
    
    with open(PID_FILE, "w") as f:
        f.write(str(os.getpid()))
    
    print("Create Socket")
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(('', PORT))
    s.listen(5)

    try:
        while True:
            if EXIT:
                raise Exception("Stop daemon due to receive signal")
            
            (con, addr) = s.accept()
            t = threading.Thread(
                target=handler,
                args=(con, addr),
                daemon=False
            )
            t.start()
    except Exception as e:
        sys.stderr.write("%s\n" % e)
    finally:
        print("Close Socket")
        s.close()
        os.remove(PID_FILE)
        return

def handler(con, addr):
    con.send(("%s, This is %s!\n" % (GREET, socket.gethostname())).encode())
    con.close()

if __name__ == '__main__':
    signal.signal(signal.SIGINT, handler)
    signal.signal(signal.SIGTERM, handler)
    server()
    
