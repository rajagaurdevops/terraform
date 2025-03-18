terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    } 
  }
}

provider "aws" {
    region = "us-east-1"  
}

# Generate a random ID to ensure the S3 bucket name is unique
resource "random_id" "rndm_id" {
    byte_length = 8  
}

# Create an S3 bucket with a unique name using the random ID
resource "aws_s3_bucket" "DEMO-BUCKET" {
    bucket = "demo-bucket-${random_id.rndm_id.hex}"  
}

# Upload a file to the created S3 bucket
resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.DEMO-BUCKET.bucket  
    source = "./myfile.txt"  # Specifies the local file to be uploaded
    key    = "mydata.txt"    # Sets the name of the file in the S3 bucket
}

# Output the generated random ID
output "name" {
  value = random_id.rndm_id.hex  
}
