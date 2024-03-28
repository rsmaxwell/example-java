#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/target
TEST_DIR=${PROJECT_DIR}/test



rm -rf ${TEST_DIR}
mkdir -p ${TEST_DIR}
cd ${TEST_DIR}



cd ${BUILD_DIR}/classes

java -cp ${BUILD_DIR}/classes com.rsmaxwell.example.Hello
