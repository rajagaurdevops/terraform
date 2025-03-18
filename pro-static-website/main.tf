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
resource "aws_s3_bucket" "my_demo_bucket" {
  bucket = "my-demo-bucket-${random_id.rndm_id.hex}" 
}

# Enabling public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.my_demo_bucket.id

  block_public_acls       = false  # Allow public ACLs
  block_public_policy     = false  # Allow public bucket policy
  ignore_public_acls      = false  # Do not ignore public ACLs
  restrict_public_buckets = false  # Do not restrict public bucket access
}

# Defining a bucket policy to allow public read access to objects
resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.my_demo_bucket.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.my_demo_bucket.arn}/*" 
      }
    ]
  })
}

# Configuring the bucket as a static website
resource "aws_s3_bucket_website_configuration" "my_demo_bucket" {
  bucket = aws_s3_bucket.my_demo_bucket.id

  index_document {
    suffix = "index.html"  # Setting the index document for the website
  }
}

# Uploading the index.html file to the S3 bucket
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.my_demo_bucket.bucket
  source       = "./index.html"  # Local path of the HTML file
  key          = "index.html"    # Object key in the bucket
  content_type = "text/html"     # Specifying the content type
}

# Uploading the styles.css file to the S3 bucket
resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.my_demo_bucket.bucket
  source       = "./styles.css"  # Local path of the CSS file
  key          = "styles.css"    # Object key in the bucket
  content_type = "text/css"      # Specifying the content type
}

# Output the generated random ID
output "name" {
  value = random_id.rndm_id.hex  # Display the random ID in the Terraform output
}

# Output the website endpoint
output "website_url" {
  value = aws_s3_bucket_website_configuration.my_demo_bucket.website_endpoint  # Display the S3 website URL
}
