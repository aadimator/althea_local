#!/bin/bash
set -euxo pipefail
PATH=$PATH:$HOME/.cargo/bin
# Loads module if not loaded and available, does nothing if already loaded and fails if not available
set +e
sudo modprobe wireguard
# cargo install diesel_cli
sudo cp $(which diesel) /usr/bin
# we need to start the database again in the namespace, so we have to kill it out here
# this sends sigint which should gracefully shut it down but terminate existing connections
sudo killall -2 postgres
# clean up the mail from last time
rm -rf mail/
set -e

chmod +x /althea_rs/integration-tests/deps/network-lab /althea_rs/integration-tests/deps/network-lab/network-lab.sh

exec "$@"