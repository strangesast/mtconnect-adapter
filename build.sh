#!/bin/bash
docker buildx build --platform=linux/arm/v7,linux/amd64 -f Dockerfile -t strangesast/mtconnect-adapter --push .
