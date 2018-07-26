# This script moves the project to the apropriate directory
#  expected by the go compiler.
# To use this script run 'source /fix-repo-location.sh'

mkdir -p ${GOPATH}/src/bitbucket.org/${BITBUCKET_REPO_OWNER}
ln -s $(pwd) ${GOPATH}/src/bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}
cd ${GOPATH}/src/bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}

