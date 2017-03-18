# Build script for Travis-CI.

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
ROOTDIR="$SCRIPTDIR/../.."
WHISKDIR="$ROOTDIR/../openwhisk"

# Install OpenWhisk

cd $WHISKDIR

tools/build/scanCode.py .

cd $WHISKDIR/ansible

ANSIBLE_CMD="ansible-playbook -i environments/travis"

$ANSIBLE_CMD setup.yml
$ANSIBLE_CMD prereq.yml
$ANSIBLE_CMD couchdb.yml
$ANSIBLE_CMD initdb.yml
$ANSIBLE_CMD wipe.yml

cd $WHISKDIR

./gradlew distDocker

cd $WHISKDIR/ansible

$ANSIBLE_CMD openwhisk.yml

# Set Environment
export OPENWHISK_HOME=$WHISKDIR

# Install package
cd $ROOTDIR

VCAP_SERVICES_FILE="$(readlink -f $ROOTDIR/tests/credentials.json)"

#update whisk.properties to add tests/credentials.json file to vcap.services.file, which is needed in tests
WHISKPROPS_FILE="$WHISKDIR/whisk.properties"
sed -i 's:^[ \t]*vcap.services.file[ \t]*=\([ \t]*.*\)$:vcap.services.file='$VCAP_SERVICES_FILE':'  $WHISKPROPS_FILE
cat $WHISKPROPS_FILE

WSK_CLI=$WHISKDIR/bin/wsk
AUTH_KEY=$(cat $WHISKDIR/ansible/files/auth.whisk.system)
EDGE_HOST=$(grep '^edge.host=' $WHISKPROPS_FILE | cut -d'=' -f2) 

# Install the package
source $ROOTDIR/install.sh $EDGE_HOST $AUTH_KEY $WSK_CLI

#Test

# Compile openwhisk test codes to resolve dependencies.
cd $ROOTDIR
./gradlew :tests:test

