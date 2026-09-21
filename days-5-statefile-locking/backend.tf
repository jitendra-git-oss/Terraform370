terraform {
  backend "s3" {
bucket = "jitus3bucket-state"
    key    = "terraform.tfstate/terraform.tfstate"
    region = "ap-south-1"    
    use_lockfile = true  ## supported in terraform version >=1.10
    dynamodb_table = "terraform-statefile-locking"  ## supported in terraform any version 
  }
}
 
 