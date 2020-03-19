#!/bin/sh -l
set -x

initialize() {
    ACTOR=$1
    VERSION=$2
    cd ~
    mkdir texlivefiles
    cd texlivefiles
    git init
    git config user.name "${ACTOR}"
    git config user.email "tex4gm@gmail.com"
    git config http.sslVerify false
    mv /app/texlive .
    git add .
    git commit -m "$VERSION"
    git tag -a $VERSION -m "$VERSION"
}

push() {
    ACTOR=$1
    TOKEN=$2
    VERSION=$3
    git remote add origin https://${ACTOR}:${TOKEN}@github.com/TeX-for-Gmail/TeX-Live-Files.git
    git push origin master -f
    git push origin $VERSION
}

initialize $2 $4

if [ "$1" = "push" ]; then
    push $2 $3 $4
else
    echo "Dry run completed. Push command is not issued!"
fi
