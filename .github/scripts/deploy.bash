set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR="$SCRIPT_DIR/../.."

cd $ROOT_DIR

GLOBAL_BUCKET="000-${GLOBAL_PREFIX}-terraform-state"
echo $GLOBAL_BUCKET

BUCKET_STATUS=$(aws s3api head-bucket --bucket "${GLOBAL_BUCKET}" 2>&1 || true)
if echo "${BUCKET_STATUS}" | grep 'Not Found'; then
  echo make bucket
  aws s3api create-bucket \
    --bucket "${GLOBAL_BUCKET}" \
    --acl private \
    --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION
fi

cd $ROOT_DIR/.terraform

OBJECT_STATUS=$(aws s3api head-object --bucket "${GLOBAL_BUCKET}" --key "$PROJECT_NAME/terraform/terraform.tfstate" 2>&1 || true)
if echo "${OBJECT_STATUS}" | grep 'Not Found'; then
  echo Initializing TF State
else
  echo Pulling TF State
  aws s3 sync s3://$GLOBAL_BUCKET/$PROJECT_NAME/terraform .
  ls -l
fi

terraform init

terraform apply \
  -var global_bucket="${GLOBAL_BUCKET}" \
  -var global_prefix="${GLOBAL_PREFIX}" \
  -auto-approve

  aws s3 sync \
    . \
    s3://$GLOBAL_BUCKET/$PROJECT_NAME/terraform \
    --exclude '.terraform/*' \
    --exclude '*.tf'
