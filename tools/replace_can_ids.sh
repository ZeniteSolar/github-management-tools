#!/bin/sh
# replaces can_ids.h
for dirname in */ ; do
    echo "updating ${dirname}"
    \rm -f ${dirname}firmware/src/can_ids.h
    \cp -f makelibs.sh ${dirname}firmware/makelibs.sh

    cd ${dirname}
    git pull
    git add firmware/src/can_ids.h
    git add firmware/makelibs.sh
    git commit -m "makelibs updated"
    git push origin master
    cd ../
done

