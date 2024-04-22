#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
SOURCE_DIR=${PROJECT_DIR}/src
BUILD_DIR=${PROJECT_DIR}/target
DIST_DIR=${PROJECT_DIR}/dist
TEMPLATES_DIR=${PROJECT_DIR}/templates

. ${BUILD_DIR}/buildinfo

mvn --batch-mode --errors deploy:deploy-file \
	-Dfile=${DIST_DIR}/${ZIPFILE}