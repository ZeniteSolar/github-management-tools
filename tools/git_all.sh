#!/bin/sh
# updates avr-can-lib
for dirname in */ ; do
    echo "updating ${dirname} with message: $1"

    cd ${dirname}firmware
    make clean
    cd ../
    git pull
    \rm -f firmware/src/can_ids.h
    git add firmware/src
    git commit -m "$1"
    git push origin master
    cd ../
done

