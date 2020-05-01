#!/usr/bin/env bash

#set -e -o pipefail
set -e
cd $(dirname $0)

# Inputs (convert to all to lower case)
environment=$( echo "$1" | tr '[:upper:]' '[:lower:]')
application=$( echo "$2" | tr '[:upper:]' '[:lower:]')
action=$( echo "$3" | tr '[:upper:]' '[:lower:]')

if [[ $# -lt 3 ]]; then
    echo "Usage: ./deploy.sh <environment> <application <action>"
    echo "  <environment>           : Can be dev, tst, sysa, bata, bats, ints, svp, trng, or prd"
    echo "  <application>           : Application name example - rdm, jabber, adobe, leads"
    echo "  <action>                : Terraform action to take example, plan, destroy, apply (apply will auto approve)"
    exit 1
fi

echo "Running: terraform ${action} -var "env=${environment}" -var-file=vars/${environment}.tfvars -input=false"

# Download Terraform plugins and switch to a workspace
rm -rf .terraform/environment

if [[ "$action" = "apply" ]]; then
    action="apply -auto-approve"
fi

terraform init -input=false
terraform workspace select rds-"${application}"-"${environment}" || terraform workspace new rds-"${application}"-"${environment}"
terraform ${action} -var "env=${environment}" -var-file=vars/${environment}.tfvars -input=false
