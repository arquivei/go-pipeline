#!/bin/sh

if [  -z "$AWS_CREDENTIALS" ]; then 
    echo "Missing environment variable AWS_CREDENTIALS"
    exit 1
elif [ -z "$AWS_CONFIGS" ];then
    echo "Missing environment variable AWS_CONFIGS"
    exit 1
fi

mkdir -p ~/.aws
echo $AWS_CREDENTIALS | base64 -d > ~/.aws/credentials
echo $AWS_CONFIGS | base64 -d > ~/.aws/config
