#!/bin/sh


FAMILY=""
ARCHITECTURE=""

case "$(uname -s)" in
    CYGWIN*) FAMILY="cygwin" ;;
    Linux*) 
        . /etc/os-release
        case ${ID} in
            ubuntu) FAMILY="linux" ;;
            alpine) FAMILY="alpine" ;;
            *) FAMILY="linux" ;;
        esac
        ;;
    *) FAMILY="unknown" ;;
esac

case "$(uname -m)" in 
  amd64|x86_64)   ARCHITECTURE="amd64" ;; 
  *) ARCHITECTURE="x86" ;; 
esac 


if [ -z "${BUILD_ID}" ]; then
    BUILD_ID="(none)"
    VERSION="0.0-SNAPSHOT"
    REPOSITORY=snapshots
    REPOSITORYID=snapshots
else
    VERSION="0.0.$((${BUILD_ID}))"
    REPOSITORY=releases
    REPOSITORYID=releases
fi


BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
SOURCE_DIR=${PROJECT_DIR}/src
BUILD_DIR=${PROJECT_DIR}/build
TEMPLATES_DIR=${PROJECT_DIR}/templates
PROJECT=example-c

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}


cat > buildinfo <<EOL
PROJECT="${PROJECT}"
FAMILY="${FAMILY}"
ARCHITECTURE="${ARCHITECTURE}"
VERSION="${VERSION}"
REPOSITORY="${REPOSITORY}"
REPOSITORYID="${REPOSITORYID}"
EOL

pwd
ls -al 
cat buildinfo




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

BASEDIR=$(dirname "$0")
SCRIPT_DIR=$(cd $BASEDIR && pwd)
PROJECT_DIR=$(dirname $SCRIPT_DIR)
SOURCE_DIR=${PROJECT_DIR}/src
TEMPLATES_DIR=${PROJECT_DIR}/templates

cd ${TEMPLATES_DIR}

find . -type f | while read filename; do
    echo "Replacing tags in ${filename}"
    envsubst "${tags}" < ${filename} > ${SOURCE_DIR}/${filename}
done
