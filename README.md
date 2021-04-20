### About

> This repository was moved to https://bitbucket.org/arquivei/go-pipeline/

This image is intended to be used in Bitbucket's pipelines for golang projects.

Is already has installed most our dependencies like libxml2 and openssl and make.

It's also shipped with aws and gcloud clients and some utility scripts.

There are two tags available:

  - `latest`: this is the image to be used for building stuff or executing tasks.
  - `scratch`: this is a scratch image already configured with timezone and cacerts. This should be used to embbed statically linked binaries.

### Using this image

If you are going to push the generated assets to aws or gcloud, run the appropriate scripts:

    $ sh /setup-aws-credentials.sh
    
    $ sh /setup-gcloud-credentials.sh prod
    or
    $ sh /setup-gcloud-credentials.sh dev

Those scripts expects the following environments variables to be set:
    
  - AWS_CREDENTIALS
  - AWS_CONFIGS
  - GCLOUD_PROD_KEYFILE
  - GCLOUD_PROD_PROJECT
  - GCLOUD_DEV_KEYFILE
  - GCLOUD_DEV_PROJECT

Then we must fix the location of the project. By default the pipeline puts the project outside GOPATH:

    $ source /fix-repo-location.sh

Now you are all set to run your own commands like:

    $ make test publish

### Available go binaries

  - `dep`: For dependency manager
  - `goose`: For managing SQL migrations
  - `golint`: For linting go source code
  - `go2xunit`: For generating test results in xunit format

### Extra programs

Beyond compilers, make and default build tools and libraries we have:

 - `upx`: For compressing the binaries
 - `bc`: Used in some of our Makefiles to compute minimal code coverage
 - `libxml2-dev`: For working with XMLs
