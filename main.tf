
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAU6GD2NOWRJEM7FO6"
  secret_key = "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"

}

#creating s3 bucket
resource "aws_s3_bucket" "firstbucket" {
  bucket = "group10first"
  tags = {
    Name = "Group10"
  
  }
}

# make bucket to change by only owner 
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.firstbucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
# make bucket public 


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.firstbucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# make bucket acl public


resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.firstbucket.id
  acl    = "public-read"
}

# resource "aws_s3_bucket_ownership_controls" "voting" {
#   bucket = aws_s3_bucket.firstbucket.id

#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

resource "aws_s3_bucket_public_access_block" "voting" {
  bucket = aws_s3_bucket.firstbucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# resource "aws_s3_bucket_acl" "voting" {
#   depends_on = [
#     aws_s3_bucket_ownership_controls.voting,
#     aws_s3_bucket_public_access_block.voting,
#   ]

#   bucket = aws_s3_bucket.firstbucket.id
#   acl    = "public-read"
# }

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.firstbucket.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "exampleindex" {
  bucket = aws_s3_bucket.firstbucket.id

  index_document {
    suffix = "index.html"
  }  
  depends_on = [ aws_s3_bucket_acl.example ]
}

resource "aws_s3_object" "result" {
  bucket = aws_s3_bucket.firstbucket.id
  key    = "result.html"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/result.html"
  acl = "public-read"
  content_type =  "text/html"
}
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.firstbucket.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}

# Upload the CSS folder and its contents to the S3 bucket
# resource "aws_s3_object" "css_folder" {
#  bucket = aws_s3_bucket.firstbucket.id 
#   key    = "css/"                            # Specify the key (path) where the folder and its contents will be uploaded
#   source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/css"  # Specify the local path to the CSS folder
#   acl           = "public-read"
#   content_type  = "text/css"  
# }


resource "aws_s3_object" "css" {
    bucket = aws_s3_bucket.firstbucket.id 
    acl    = "public-read"
    key    = "css/"
    #source = "/dev/null"
}

resource "aws_s3_object" "css1" {
    bucket = aws_s3_bucket.firstbucket.id 
    acl    = "public-read"
    key    = "css/css1"
    #source = "/dev/null"
}



## Css file upload code
resource "aws_s3_object" "bootstrap" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "css/bootstrap.min.css"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/css/bootstrap.min.css"  
  acl = "public-read"
  content_type =  "text/css"
}

resource "aws_s3_object" "bootstrap1" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "css/all.min.css"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/css/all.min.css"  
  acl = "public-read"
  content_type =  "text/css"
}
resource "aws_s3_object" "bootstrap2" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "css/style.css"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/css/style.css"  
  acl = "public-read"
  content_type =  "text/css"
}
resource "aws_s3_object" "bootstrap3" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "css/style.css.map"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/css/style.css.map"  
  acl = "public-read"
  content_type =  "text/css"
}

resource "aws_s3_object" "image" {
    bucket = aws_s3_bucket.firstbucket.id 
    acl    = "public-read"
    key    = "/images"
    #source = "/dev/null"
}


resource "aws_s3_object" "image1" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "images/member-01.jpg"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/images/member-01.jpg"  
  acl = "public-read"
  content_type =  "text/jpg"
}
resource "aws_s3_object" "image2" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "images/member-02.jpg"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/images/member-02.jpg"  
  acl = "public-read"
  content_type =  "text/jpg"
}
resource "aws_s3_object" "image3" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "images/member-03.jpg"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/images/member-03.jpg"  
  acl = "public-read"
  content_type =  "text/jpg"
}

resource "aws_s3_object" "js" {
    bucket = aws_s3_bucket.firstbucket.id 
    acl    = "public-read"
    key    = "/js"
    
    #source = "/dev/null"
}

resource "aws_s3_object" "js1" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "images/member-03.jpg"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/js/bootstrap.bundle.min.js"  
  acl = "public-read"
  content_type =  "text/jpg"
}
resource "aws_s3_object" "js2" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "images/member-03.jpg"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/js/jquery-3.2.1.min.js"  
  acl = "public-read"
  content_type =  "text/js"
}
resource "aws_s3_object" "js3" {
 bucket = aws_s3_bucket.firstbucket.id
  key    = "images/member-03.jpg"
  source = "/Users/adityagawade/Desktop/CCFinal/group10/assets/js/script.js"  
  acl = "public-read"
  content_type =  "text/js"
}


