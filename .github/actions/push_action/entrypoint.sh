#!/bin/sh -l
set -x

push() {
    ACTOR=$1
    TOKEN=$2
    VERSION=$3
    cd ~
    # git clone --depth 1 https://github.com/TeX-for-Gmail/TeX-Live-Files.git texlivefiles
    mkdir texlivefiles
    cd texlivefiles
    git init
    git config user.email "tex4gm@gmail.com"
    git config user.name "tex4gmail"
    git config http.sslVerify false
    mv /app/texlive .
    git add .
    git commit -m "$VERSION"
    git tag -a $VERSION -m "$VERSION"
    git remote add origin https://${ACTOR}:${TOKEN}@github.com/TeX-for-Gmail/TeX-Live-Files.git
    git push origin master -f
    git push origin $VERSION
}

if [ "$1" = "push" ]; then
    push $2 $3 $4
else
    echo "Push command is not issued!"
fi
