provider "aws" {
   region     = "ap-south-1"
   access_key = "AKIATZ2F7UUON6ZCC4NJ"
   secret_key = "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"

}
resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}
resource "aws_key_pair" "deployer" {
  key_name   = "test1234"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9WISWzjklE449oq3HVEchCG3l6+jl5Fdfjcqu5pNXmBoTK9xi6TCqbshnBzgTc32vFu7GHROn6SV2Y19VttLLs8WNCTuSvaJ8Hi7Lxa9gA00lDB+xzagdtDwbP3GBWYu5KVCmDj0egb/06TDJUPeYDZKiOthbLJwK9WfQqHP0N6NSqrXavZJlwBGpRmfhUpMsCBfy4umI9+nMx2C2h5Tf/7x6PQaLLYUACUeQrkiY6ub6MYqHlCbHW1129UcWJRVVsYclSqfDsIrdS4o8DgiZ6KbaUGYwP1xKXaorWHZEjIlpxVTMmMBXesEbLEGeOdYZR7dJV9odHuXlOnJ0Dia9 sarvepalli@DESKTOP-RO6V9OR"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-05afd67c4a44cc983"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.main.id]
    key_name= "test1234"

connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("terrafor")
      timeout     = "4m"
   }
provisioner "file" {
    source      = "Helllo.txt"
    destination = "Helllo.txt"
  }
}