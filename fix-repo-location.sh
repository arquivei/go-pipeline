PACKAGE_PATH="${GOPATH}/src/bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}"
mkdir -p ${PACKAGE_PATH}
tar -cO . | tar -xv -C "${PACKAGE_PATH}"
cd ${PACKAGE_PATH}