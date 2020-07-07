#!/bin/bash
envsubst < adapter.ini.template > adapter.ini
./adapter debug adapter.ini
