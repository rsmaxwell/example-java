#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/target

. ${BUILD_DIR}/buildinfo

cd ${PROJECT_DIR}

mvn --batch-mode --errors compile -Dproject.version=${VERSION}
