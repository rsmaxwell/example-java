#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
BUILD_DIR=${PROJECT_DIR}/target
DIST_DIR=${PROJECT_DIR}/dist

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

REPOSITORY_URL="${MAVEN_REPOSITORY_BASE_URL}/${REPOSITORY}"



mvn --batch-mode --errors deploy:deploy-file \
	-Dmy.version=${VERSION} \
	-Dfile=${DIST_DIR}/${ZIPFILE} \
	-Dmy.repositoryId=${REPOSITORYID} \
	-Dmy.repository.url=${REPOSITORY_URL}