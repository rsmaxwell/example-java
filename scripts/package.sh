#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/target

. ${BUILD_DIR}/buildinfo

if [ -f ${HOME}/.m2/maven-repository-info ]; then
    . ${HOME}/.m2/maven-repository-info
elif [ -f ./maven-repository-info ]; then
    . ./maven-repository-info
fi

if [ -z "${MAVEN_REPOSITORY_BASE_URL}" ]; then
    echo "'MAVEN_REPOSITORY_BASE_URL' is not defined"
    exit 1
fi



cd ${PROJECT_DIR}

mvn --batch-mode --errors \
    -Drevision=${VERSION} \
    -Dmaven.repository.base.url=${MAVEN_REPOSITORY_BASE_URL} \
    package
