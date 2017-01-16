#!/usr/bin/env bash

if [[ -n $OWNCLOUD_PORT_80_TCP_ADDR ]] 
then
	OC_SERVER=$OWNCLOUD_PORT_80_TCP_ADDR
fi

OC_URL=$OC_SERVER
if [[ -n $OC_ROOT ]]
then
	OC_URL=$OC_SERVER/$OC_ROOT
fi

echo "Testing http://$OC_URL/status.php ... "
while [ "200" != $(curl --write-out %{http_code} --silent --output /dev/null http://$OC_URL/status.php) ]
do
	echo -n "."
	sleep 1
done

exec bin/smash $*
