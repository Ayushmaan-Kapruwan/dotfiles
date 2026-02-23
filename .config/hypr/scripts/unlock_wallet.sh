#!/bin/bash
export XDG_RUNTIME_DIR=/run/user/$(id -u)
echo "yourpassword" | kwallet-query -p kdewallet

