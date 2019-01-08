FROM golang:alpine

# Forces git clone to ignore unknown host
ENV GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Installs dependencies from alpine's repository
RUN apk --no-cache upgrade && \
    apk --no-cache add tzdata ca-certificates \ 
    git mercurial gcc musl-dev openssh python \
    py-pip curl bash make bc libxml2-dev openssl-dev \
	librdkafka-dev cyrus-sasl-dev lz4-dev \
    zip upx

# Installs Amazon's client
RUN pip install awscli

# Installs Google's client
RUN curl https://sdk.cloud.google.com > /tmp/gcloud_install.sh
RUN bash /tmp/gcloud_install.sh --disable-prompts --install-dir=/usr/local
ENV PATH $PATH:/usr/local/google-cloud-sdk/bin

# Installs golang tools
RUN go get -v -u github.com/golang/dep/cmd/dep && \
    go get -v -u golang.org/x/lint/golint && \
    go get -v -u bitbucket.org/liamstask/goose/cmd/goose && \
	go get -v -u github.com/tebeka/go2xunit

# Sets default timezone
RUN echo "America/Sao_Paulo" > /etc/timezone

# Cleanup
RUN rm -rf /tmp/*

# Copy utility script to work with go in the bitbucket's pipeline
COPY *.sh /
COPY usr /usr

# This should be used to check if we are running our builds inside
# a container of this image, so we know what tools are available
ENV PIPELINE_ENABLED=1

# Default command
CMD ["bash"]
