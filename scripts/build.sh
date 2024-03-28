#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)

cd ${PROJECT_DIR}

mvn --batch-mode --errors compile
result=$?
if [ ! ${result} -eq 0 ]; then
    echo "build failed"
    echo "Error: $0[${LINENO}] result: ${result}"
    exit 1
fi


echo "Success"

