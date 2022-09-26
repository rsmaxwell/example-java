#!/bin/bash

set -x

#*****************************************************************
# Clean previously built jars
#*****************************************************************
rm -rf ./target
result=$?
if [ ! ${result} -eq 0 ]; then
    echo "Error: $0[${LINENO}]" 
    echo "result = ${result}"
    exit 1
fi


if [ -n "${BUILD_ID}" ]; then

    #*****************************************************************
    # Replace tags in the source for the Version class
    #*****************************************************************
    VERSION="0.0.$((${BUILD_ID}))"
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    find . -name "Version.java" | while read versionfile; do

        echo "Replacing tags in ${versionfile}"

        sed -i "s@<VERSION>@${VERSION}@g"            ${versionfile}    
        sed -i "s@<BUILD_ID>@${BUILD_ID}@g"          ${versionfile}
        sed -i "s@<BUILD_DATE>@${TIMESTAMP}@g"       ${versionfile}
        sed -i "s@<GIT_COMMIT>@${GIT_COMMIT}@g"      ${versionfile}
        sed -i "s@<GIT_BRANCH>@${GIT_BRANCH}@g"      ${versionfile}
        sed -i "s@<GIT_URL>@${GIT_URL}@g"            ${versionfile}
    done

    #*****************************************************************
    # Update the version in the pom file
    #*****************************************************************
    mvn --batch-mode versions:set -DnewVersion=${VERSION}
    result=$?
    if [ ! ${result} -eq 0 ]; then
        echo "Error: $0[${LINENO}]"
        echo "result: ${result}"
        exit 1
    fi

fi

