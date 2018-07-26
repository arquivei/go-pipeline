function print_usage {
    cat <<EOF
usage: source $0 <PROFILE>

Setups credentials and default project for gcloud

PROFILE:
    dev|develop|development  Setups development credentials
    prod|production          Setups production credentials

Examples:
    source $0 prod
    source $0 dev
EOF
}

if [ $# -eq 0 ]; then
    echo "Missing profile!"
    print_usage
    return 1
fi;

# Setups production credentials file and project
function setup_prod_profile {
    if [  -z "$GCLOUD_PROD_KEYFILE" ]; then
        echo "Missing environment variable GCLOUD_PROD_KEYFILE"
        return 1
    elif [ -z "$GCLOUD_PROD_PROJECT" ];then
        echo "Missing environment variable GCLOUD_PROD_PROJECT"
        return 1
    fi
    echo $GCLOUD_PROD_KEYFILE | base64 -d > ~/.gcloud-api-key.json
    GCLOUD_PROJECT=$GCLOUD_PROD_PROJECT
}

# Setups development credentials file and project
function setup_dev_profile {
    if [  -z "$GCLOUD_DEV_KEYFILE" ]; then
        echo "Missing environment variable GCLOUD_DEV_KEYFILE"
        return 1
    elif [ -z "$GCLOUD_DEV_PROJECT" ];then
        echo "Missing environment variable GCLOUD_DEV_PROJECT"
        return 1
    fi
    echo $GCLOUD_DEV_KEYFILE | base64 -d > ~/.gcloud-api-key.json
    GCLOUD_PROJECT=$GCLOUD_DEV_PROJECT
}

case "$1" in
    dev|develop|development)
        echo "Setting gcloud development credentials..."
        setup_dev_profile
        ;;
    prod|production)
        echo "Setting gcloud production credentials..."
        setup_prod_profile
        ;;
    *)
        echo "Invalid profile: $1"
        return 1
esac

echo "Login into gcloud..."
gcloud auth activate-service-account --key-file ~/.gcloud-api-key.json

echo "Configuring project..."
gcloud config set project $GCLOUD_PROJECT

echo "Configuring docker credentials for GCR..."
gcloud auth configure-docker --quiet

return 0
