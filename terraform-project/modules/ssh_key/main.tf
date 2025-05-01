resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key" {
  key_name   = "mykey"
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = <<EOF
      echo '${tls_private_key.pk.private_key_pem}' > ${path.module}/../../ansible/mykey.pem
      chmod 400 ${path.module}/../../ansible/mykey.pem
EOF
  }
}
