resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pub")
}

resource "aws_instance" "vm" {
  ami                         = "ami-06dd92ecc74fdfb36"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> private_ips.txt"
  }
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./aws-key")
    host = "${self.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo subnet_id: ${data.terraform_remote_state.vpc.outputs.subnet_id} >> /tmp/network_info.txt",
      "echo security_group_id: ${data.terraform_remote_state.vpc.outputs.security_group_id} >> /tmp/network_info.txt",
    ]
  }

  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/ami.log"
  }
  provisioner "file" {
    source      = "./test.txt"
    destination = "/tmp/exemplo.txt"
  }

  tags = {
    Name = "vm-instance"
  }

}