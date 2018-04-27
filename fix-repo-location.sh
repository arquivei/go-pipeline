# This script moves the project to the apropriate directory
#  expected by the go compiler.
# To use this script run 'source /fix-repo-location.sh'

PACKAGE_PATH="${GOPATH}/src/bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}"
mkdir -p ${PACKAGE_PATH}
tar -cO . | tar -x -C "${PACKAGE_PATH}"
cd ${PACKAGE_PATH}
