#!/bin/bash

set -x 

jarfile=$(find target -name "example-java*.jar")

java -cp ${jarfile} com.rsmaxwell.example.Hello
