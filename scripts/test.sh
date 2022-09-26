#!/bin/bash

NAME=example-cpp
PROJECT_DIR=$(pwd)
BUILD_DIR=${PROJECT_DIR}/build

set -x
${BUILD_DIR}/${NAME}
