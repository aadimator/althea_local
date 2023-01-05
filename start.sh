#!/bin/bash
set -eux

if ! modprobe wireguard ; then
	echo "The container can't load modules into the host kernel"
	echo "Please install WireGuard https://www.wireguard.com/ and load the kernel module using 'sudo modprobe wireguard'"
	exit 1
fi


REPOFOLDER=althea_rs
pushd $REPOFOLDER
git archive --format=tar.gz -o ../rita.tar.gz --prefix=althea_rs/ HEAD
popd

# Remove container if it exists
docker rm althea_local | true
time docker build -t rita-test .
docker run --name althea_local --privileged -it --env-file ./env.list -v $(pwd):/home/althea_local rita-test /bin/bash
rm rita.tar.gz
