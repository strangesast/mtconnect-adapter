#!/bin/bash
docker run --rm --volume $(pwd)/fanuc/adapter.ini:/adapter.ini -p "7878:7878" strangesast/mtconnect-adapter /adapter_fanuc -c /adapter.ini
