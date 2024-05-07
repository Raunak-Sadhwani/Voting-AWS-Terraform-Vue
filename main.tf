
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

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.firstbucket.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.firstbucket.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}
resource "aws_s3_object" "assests" {
    bucket = aws_s3_bucket.firstbucket.id
    acl    = "public-read"
    key    = "assets/"
    source = "/dev/null"
}


module "template_files" {
    source = "hashicrop/dir/template"
    base_dir = "$(path.module)/assets"
  
}
# resource "aws_s3_bucket_object" "css" {
#     bucket = aws_s3_bucket.firstbucket.id
#     acl    = "public-read"
#     key    = "/Users/adityagawade/Desktop/CC/Group no 10/group10/assets/css/"
#     source = "assets/"
# }

# resource "aws_s3_object" "assests1" {
#     bucket = aws_s3_bucket.firstbucket.id
#     acl    = "public-read"
#     key    = "assets/css"
#     source = "/Users/adityagawade/Desktop/CC/Group no 10/group10/assets/css/"
# }
# resource "aws_s3_object" "default_s3_content" {
#     for_each = "${var.default_s3_content}"
#     bucket = aws_s3_bucket.firstbucket.id
#     key = "${each.value}/"
#     source = "/dev/assets/"
    
# }

  
# resource "aws_s3_object" "CSS" {
#     bucket = aws_s3_bucket.firstbucket.id
#     acl    = "public-read"
#     key    = "assests/"
#     source = "/dev/null"
# }
#`resource "aws_s3_object" "profile" {
#   bucket = aws_s3_bucket.firstbucket.id
#   key = "profile.png"
#   source = "profile.png"
#   acl = "public-read"
# }



# /* resource "aws_instance" "myfirst" {
#   ami           = "ami-04b70fa74e45c3917"
#   instance_type = "t2.micro"

#   tags = {
#     Name ="myfirst"
#   }
# }   
#  */
# #Vpc creation in aws    

# resource "aws_vpc" "firstproject" {
#   cidr_block       = "10.0.0.0/16"

#   tags = {
#     Name = "First-project"
#   }
# }

# #Internet gatway

# resource "aws_internet_gateway" "gateway" {
#   vpc_id = aws_vpc.firstproject.id

#   tags = {
#     Name = "Internetgateway"
#   }
# }

# #Route table
# resource "aws_route_table" "myfirstroute" {
#   vpc_id = aws_vpc.myfirst.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gateway.id
#   }

#   route {
#     ipv6_cidr_block        = "::/0"
#     gateway_id = aws_internet_gateway.gateway.id
#   }

#   tags = {
#     Name = "myfirstroute"
#   }
# }

# resource "aws_subnet" "subnet" {

#     vpc_id = aws_vpc.firstproject.id
#     cidr_block       = "10.0.0.1/24"
#     availability_zone = "us-east-1"

#    tags = {
#     Name = "myfirstsubnet"
#   } 
# }


# #route table assosation

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.myfirstsubnet.id
#   route_table_id = aws_route_table.myfirstroute.id
# }


# #security groups

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic and all outbound traffic"
#   vpc_id      = aws_vpc.firstproject.id

#   tags = {
#     Name = "allow_tls"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = ["0.0.0.0/0"]
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }



# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }


# #network interface

# resource "aws_network_interface" "Nw" {
#   subnet_id       = aws_subnet.myfirstsubnet.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [aws_security_group.allow_tls.id]
# }


# #Elastic IP

# resource "aws_eip" "one" {
#   domain                    = "vpc"
#   network_interface         = aws_network_interface.Nw.id
#   associate_with_private_ip = "10.0.1.50"

#   depends_on = [ aws_internet_gateway.gateway.id ]
# }

# resource "aws_instance" "myfirst" {
#   ami           = "ami-04b70fa74e45c3917"
#   instance_type = "t2.micro"
#   availability_zone = "us-east-1"
#   key_name = "My-first"

#   network_interface {
#     device_index = 0
#     network_interface_id = aws_network_interface.Nw.id
#   }

#   user_data = <<-EOF
#              #!/bin/bash
#              sudo-apt update -y
#              sudo apt install apache2 -y
#              sudo systemctl start apache2
#              sudo bash -c "your very first web server > /var/www/html/index.html"
#              EOF

#   tags = {
#     Name ="myfirst"
#   }
# } 