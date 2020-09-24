#!/bin/sh
# updates avr-can-lib
for dirname in */ ; do
    echo "updating ${dirname} with message: $1"

    cd ${dirname}
    git pull
    cd ../
done

