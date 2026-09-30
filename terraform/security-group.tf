resource "aws_security_group" "k8s" {
  name        = "k8s-lab-sg-tatiana"
  description = "Security Group para cluster Kubernetes"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH - acesso administrativo"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["187.85.171.31/32"]
  }

  ingress {
    description = "Kubernetes API Server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["10.37.0.0/16"]
  }

  ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["10.37.0.0/16"]
  }

  ingress {
    description = "Comunicacao interna do cluster"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.37.0.0/16"]
  }

  ingress {
    description = "NGINX NodePort"
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-lab-sg-tatiana"
  }
}
