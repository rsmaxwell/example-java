#!/bin/sh

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $(dirname $BASEDIR) && pwd)

if [ -z "${BUILD_ID}" ]; then
    BUILD_ID="(none)"
    VERSION="SNAPSHOT"
else
    VERSION="0.0.$((${BUILD_ID}))"
fi

TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
GIT_COMMIT="${GIT_COMMIT:-(none)}"
GIT_BRANCH="${GIT_BRANCH:-(none)}"
GIT_URL="${GIT_URL:-(none)}"

export BUILD_ID
export VERSION
export TIMESTAMP
export GIT_COMMIT
export GIT_BRANCH
export GIT_URL

tags='$VERSION,$BUILD_ID,$TIMESTAMP,$GIT_COMMIT,$GIT_BRANCH,$GIT_URL'

PROJECT_DIR=$(dirname $SCRIPT_DIR)
SOURCE_DIR=${PROJECT_DIR}/src
TEMPLATES_DIR=${PROJECT_DIR}/templates

cd ${TEMPLATES_DIR}

find . -type f | while read filename; do
    echo "Replacing tags in ${filename}"
    envsubst "${tags}" < ${filename} > ${SOURCE_DIR}/${filename}
done


