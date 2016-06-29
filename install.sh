#!/bin/bash

set -e
set -x

if [ $# -eq 0 ]
then
    echo "Usage: ./install.sh $APIHOST $AUTH $WSK_CLI"
fi

APIHOST="$1"
AUTH="$2"
WSK_CLI="$3"

PACKAGE_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo Installing an Openwhisk Package Template \

$WSK_CLI --apihost $APIHOST package update --auth $AUTH --shared yes  packageTemplate \
    -a description "Openwhisk Package Template" \
    -a parameters '[{"name":"apiKey","required":true,"bindTime":true,"description":"Watson IoT platform apiKey"},{"name":"apiToken","required":true,"bindTime":true,"type":"password","description":"Watson IoT platform authentication token"},{"name":"orgId","required":false,"bindTime":false,"description":"Watson IoT platform organization ID"}]'

$WSK_CLI --apihost $APIHOST action update --auth $AUTH --shared yes packageTemplate/helloWorld $PACKAGE_HOME/actions/hello_world.js \