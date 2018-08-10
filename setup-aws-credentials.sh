function print_usage {
    cat <<EOF
usage: source $0 <PROFILE>

Setups credentials for aws

PROFILE:
    dev     Setups development credentials
    prod    Setups production credentials

Examples:
    source $0 prod
    source $0 dev
EOF
}

if [ -z "$1" ]; then
    echo "Missing profile!"
    print_usage
    return 1
fi;

# Setups credential and configuration files
echo "Loading credential and configuration files..."
if [  -z "$AWS_CREDENTIALS" ]; then
    echo "Missing environment variable AWS_CREDENTIALS"
    return 1
elif [ -z "$AWS_CONFIGS" ];then
    echo "Missing environment variable AWS_CONFIGS"
    return 1
fi
mkdir -p ~/.aws
echo $AWS_CREDENTIALS | base64 -d > ~/.aws/credentials
echo $AWS_CONFIGS | base64 -d > ~/.aws/config

echo "Switching AWS profile to '$1'..."
export AWS_PROFILE=$1

echo "Configuring docker credentials for ECR..."
$(aws ecr get-login --no-include-email)

return 0
