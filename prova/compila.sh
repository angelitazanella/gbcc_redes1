#!/bin/bash

DIR=`pwd`
DOCKER="gelirettore/latex-thesis:1.1"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file.tex>"
    exit 1
fi

FILE=$1
echo "Compiling $FILE"
docker run --name prova --rm -it -v $DIR:/home/latex $DOCKER /bin/bash -c "cd /home/latex && pdflatex -interaction=nonstopmode $FILE"