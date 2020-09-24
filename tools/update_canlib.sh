#!/bin/sh
# updates avr-can-lib
for dirname in */ ; do
    echo "updating ${dirname}"
    \mv -f ${dirname}firmware/lib/avr-can-lib/src/config.h config.h
    \rm -rf ${dirname}firmware/lib/avr-can-lib
    \cp -r ~/ZeniteSolar/2019/MCB19/firmware/lib/avr-can-lib ${dirname}firmware/lib
    \mv -f config.h ${dirname}firmware/lib/avr-can-lib/src/config.h

    cd ${dirname}
    git pull
    git add firmware/lib/avr-can-lib
    git commit -m "avr-can-lib updated"
    git push origin master
    cd ../
done

