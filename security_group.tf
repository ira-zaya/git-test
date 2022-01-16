 resource "aws_security_group" "allow_http" {
   name = "allow http"
   description = "allow 22, 80, 8080"
   
   ingress {
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
   from_port = 8080
   to_port = 8080
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1" 
   } 
 }
