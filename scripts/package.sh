#!/bin/bash

NAME=example-cpp

ZIPFILE=${NAME}_amd64-linux.zip

PROJECT_DIR=$(pwd)
BUILD_DIR=${PROJECT_DIR}/build
PACKAGE_DIR=${PROJECT_DIR}/package
DIST_DIR=${PROJECT_DIR}/dist

rm -rf ${PACKAGE_DIR}
mkdir -p ${PACKAGE_DIR} ${DIST_DIR}

cd ${PACKAGE_DIR}
cp ${BUILD_DIR}/${NAME} .

zip ${DIST_DIR}/${ZIPFILE} ${NAME}
