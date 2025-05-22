# tfstate-s3-backend-action
This GitHub Action will aid in creating a terraform state backend in AWS S3.

## Usage
You're free to use this action however you want. However, here's a example workflow that uses `workflow_dispatch`.

```yaml
name: Terraform S3 Backend Bucket

on:
  workflow_dispatch:
    inputs:
      account:
        description: 'AWS Account'
        required: true
        type: choice
        options:
          - admin
          - dev
          - prod
      first_run:
        description: 'First run?'
        required: true
        type: boolean
        default: false

jobs:
  terraform_s3_bucket:
    runs-on: ubuntu-latest
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets[format('{0}_ACCESS_KEY_ID', inputs.account)] }}
          aws-secret-access-key: ${{ secrets[format('{0}_SECRET_ACCESS_KEY', inputs.account)] }}
          aws-region: us-east-1

      - name: Terraform
        uses: 7Factor/tfstate-s3-backend-action@v1
        with:
          first_run: ${{ inputs.first_run }}
          workspace: terraform-state-bucket
          s3_bucket_name: ${{ vars.ORGANIZATION }}-${{ inputs.account }}-terraform-state
```
