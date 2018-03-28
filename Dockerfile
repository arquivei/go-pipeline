FROM golang:alpine

# Forces git clone to ignore unknown host
ENV GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Installs dependencies from alpine's repository
RUN apk --no-cache upgrade && \
    apk --no-cache add tzdata ca-certificates \ 
    git mercurial gcc musl-dev openssh python \
    py-pip curl bash make bc libxml2-dev openssl-dev

# Installs Amazon's client
RUN pip install awscli

# Installs Google's client
RUN curl https://sdk.cloud.google.com > /tmp/gcloud_install.sh
RUN bash /tmp/gcloud_install.sh --disable-prompts --install-dir=/usr/local
ENV PATH $PATH:/usr/local/google-cloud-sdk/bin

# Installs golang tools
RUN go get -v -u github.com/golang/dep/cmd/dep && \
    go get -v -u golang.org/x/lint/golint

# Sets default timezone
RUN echo "America/Sao_Paulo" > /etc/timezone

# Cleanup
RUN rm -rf /tmp/*

# Copy utility script to work with go in the bitbucket's pipeline
COPY fix-repo-location.sh /fix-repo-location.sh 

# Default command
CMD ["bash"]
