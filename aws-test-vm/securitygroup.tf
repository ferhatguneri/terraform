data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "allow_my_ip" {
  name = "allow_my_ip"

  ingress {
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    protocol  = -1
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}