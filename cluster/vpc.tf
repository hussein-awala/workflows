# documentation: https://github.com/terraform-google-modules/terraform-google-network
module "vpc" {
  source = "terraform-google-modules/network/google"
  version = "~> 2.5"
  project_id = var.project_id
  network_name = "gke-vpc"
  routing_mode = "REGIONAL"

  subnets = [
    {
      subnet_name           = "gke-vpc-subnet-1"
      subnet_ip             = "10.10.0.0/16"
      subnet_region         = var.region
      description           = ""
    }
  ]

  secondary_ranges = {
    gke-vpc-subnet-1 = [
      {
        range_name = "pods-ip-range"
        ip_cidr_range = "10.11.0.0/16"
      },
      {
        range_name = "services-ip-range"
        ip_cidr_range = "10.12.0.0/16"
      }
    ]
  }
}