#!/bin/sh
# replaces can_ids.h
\rm -f can_ids.h
wget https://raw.githubusercontent.com/ZeniteSolar/CAN_IDS/master/can_ids.h
for dirname in */ ; do
    echo "updating ${dirname}"
    \rm -f ${dirname}firmware/src/can_ids.h
    \cp -f can_ids.h ${dirname}firmware/src/can_ids.h
done

