#!/bin/bash
envsubst < adapter.ini.template > /fanuc/adapter.ini
./adapter debug adapter.ini
