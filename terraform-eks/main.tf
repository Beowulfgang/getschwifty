provider "aws" {
  region = "us-west-2"  #Us-east-1 one day
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.auth.token


module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.24"
  vpc_id          = "vpc-12334"  #Can add through data
}

# Managed Node Group for teamA
resource "aws_eks_node_group" "teamA" {
  cluster_name    = module.eks.cluster_id
  node_group_name = "teamA"
  node_role_arn   = module.eks.worker_iam_role_arn
  subnet_ids      = module.eks.vpc_private_subnets

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 1
  }

  instance_types = ["r6.16xlarge"]
  ami_type       = "AL2_x86_64"

  remote_access {
    ec2_ssh_key = "schwifty-analytics-key"
  }

  tags = {
    "Project" = "ProjectAnalytics"
    "Team"    = "TeamAnalytics"
  }

  taints = [
    {
      key    = "team"
      value  = "TeamAnalytics"
      effect = "NO_SCHEDULE"
    }
  ]

  labels = {
    environment = "dev"
    team        = "Analytics"
  }
}

resource "aws_eks_node_group" "teamB" {
  cluster_name    = module.eks.cluster_id
  node_group_name = "Separated-Node-Groups"
  node_role_arn   = module.eks.worker_iam_role_arn
  subnet_ids      = module.eks.vpc_private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 6
    min_size     = 1
  }

  instance_types = ["t3.large"]
  ami_type       = "AL2_x86_64"

  remote_access {
    ec2_ssh_key = "schwifty-Z-key"
  }

  tags = {
    "Project" = "ProjectZ"
    "Team"    = "TeamZ"
  }
  taints = [
    {
      key    = "team"
      value  = "Z"
      effect = "NO_SCHEDULE"
    }
  ]
  labels = {
    environment = "prod"
    team        = "Z"
  }
}
resource "kubernetes_horizontal_pod_autoscaler_v2beta2" "hpa" {
  metadata {
    name      = "my-app-hpa"
    namespace = "default"
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "schwifty-deployment"
    }
    min_replicas = 2
    max_replicas = 10

    metric {
      type = "Resource"

      resource {
        name                     = "cpu"
        target_type              = "Utilization"
        target_average_utilization = 50 
      }
    }
  }
}

output "cluster_name" {
  value = module.eks.cluster_id
}

output "node_groups" {
  value = [
    aws_eks_node_group.teamA.node_group_name,
    aws_eks_node_group.teamB.node_group_name
  ]
}
}
