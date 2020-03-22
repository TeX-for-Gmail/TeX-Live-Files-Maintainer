#!/bin/sh -l
set -x

initialize() {
    ACTOR=$1
    VERSION=$2
    REPO_HOME=~/texlivefiles

    mkdir $REPO_HOME
    cd $REPO_HOME
    # Set up git
    git init
    git config user.name "${ACTOR}"
    git config user.email "tex4gm@gmail.com"
    git config http.sslVerify false

    # Move texlive installation to $REPO_HOME
    mv /app/texlive .

    # Make sure that pdftex.map is not a symlink
    rm -f $REPO_HOME/texlive/texmf-var/fonts/map/pdftex/updmap/pdftex.map
    cp $REPO_HOME/texlive/texmf-var/fonts/map/pdftex/updmap/pdftex_dl14.map $REPO_HOME/texlive/texmf-var/fonts/map/pdftex/updmap/pdftex.map

    # Create index
    cd $REPO_HOME/texlive
    node /make_http_index.js > $REPO_HOME/index.json

    # Commit
    cd $REPO_HOME
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
