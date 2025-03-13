#!/bin/sh

pgrep -x polybar
status=$?
if test $status -eq 0
then
  pkill polybar && bspc config -m focused top_padding 0
else
  $HOME/bin/launch-polybar.sh && bspc config -m focused top_padding 35
fi
