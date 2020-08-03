#!/bin/bash
#nc adapter0 7878 | pv --line-mode --average-rate --timer > /dev/null
#timeout 20s nc adapter0 7878 | wc -l
if (($((timeout --foreground --preserve-status 20s nc localhost 7878) | wc -l) > 0))
then
	exit 0
else
	exit 1
fi
