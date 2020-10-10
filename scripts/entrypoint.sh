#!/bin/sh
FOCAS_SERVICE_NAME="${FOCAS_SERVICE_NAME:-fanuc}"
FOCAS_HOST="${FOCAS_HOST:-localhost}"
adapter_config=$(pwd)/$FOCAS_SERVICE_NAME.ini
if [ ! -f $adapter_config ]; then
	envsubst < default.ini > $adapter_config
fi
echo using adapter config: $adapter_config
adapter_fanuc -c $adapter_config
