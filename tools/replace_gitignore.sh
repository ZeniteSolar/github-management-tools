#!/bin/sh
# replace .gitignore
for dirname in */ ; do
    echo "updating ${dirname}"
    cd ${dirname}
    git stash
    git pull

    \rm -f firmware/.gitignore
    \cp -f .gitignore firmware/.gitignore

    git add firmware/.gitignore
    git commit -m ".gitignore updated"
    git push origin master
    cd ../
done

