# Define the AWS provider and specify the region
provider "aws" {
    region = "us-east-1"  # AWS region where resources will be created
}

# Create an S3 bucket with a unique name using a random ID
resource "aws_s3_bucket" "DEMO-BUCKET" {
    bucket = "demo-bucket-${random_id.rndm_id.hex}"  # Appending a random string to ensure uniqueness
}

# Upload a file to the created S3 bucket
resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.DEMO-BUCKET.bucket  # Referencing the created bucket
    source = "./myfile.txt"  # Local file to be uploaded
    key = "mydata.txt"  # Name of the file in S3
}

# Generate a random ID to ensure bucket name uniqueness
resource "random_id" "rndm_id" {
    byte_length = 8  # Defines the length of the random hex string
}

# Output the generated random ID
output "name" {
  value = random_id.rndm_id.hex  # Display the random ID in the Terraform output
}
