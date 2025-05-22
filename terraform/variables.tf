variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state in. Must be globally unique."
  type        = string
  nullable    = false
  validation {
    condition     = length(var.s3_bucket_name) <= 64
    error_message = "The s3_bucket_name value must be 64 characters or less."
  }
}
