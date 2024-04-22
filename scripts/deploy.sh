#!/bin/sh


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
SOURCE_DIR=${PROJECT_DIR}/src
BUILD_DIR=${PROJECT_DIR}/target
DIST_DIR=${PROJECT_DIR}/dist
TEMPLATES_DIR=${PROJECT_DIR}/templates

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



export PROJECT
export REPOSITORY
export REPOSITORYID
export BUILD_ID
export VERSION
export TIMESTAMP
export GIT_COMMIT
export GIT_BRANCH
export GIT_URL
export FAMILY
export ARCHITECTURE

export GROUPID
export ARTIFACTID
export PACKAGING
export MAVEN_REPOSITORY_BASE_URL

cd ${TEMPLATES_DIR}

tags='$FAMILY,$ARCHITECTURE,$PROJECT,$REPOSITORY,$REPOSITORYID,$VERSION,$BUILD_ID,$TIMESTAMP,$GIT_COMMIT,$GIT_BRANCH,$GIT_URL,$GROUPID,$ARTIFACTID,$PACKAGING,$MAVEN_REPOSITORY_BASE_URL'

find . -type f | while read filename; do
    file=${PROJECT_DIR}/${filename}
    dir=$(dirname ${file})
    mkdir -p ${dir}
    echo "Writing ${file}"
    envsubst "${tags}" < ${filename} > ${file}
done




mvn --batch-mode --errors deploy:deploy-file \
	-Dfile=${DIST_DIR}/${ZIPFILE}