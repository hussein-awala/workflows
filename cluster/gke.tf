# documentation: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine
module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = "gke-test-1"
  region                     = var.region
  zones                      = var.zones
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets["europe-west1/gke-vpc-subnet-1"].name
  ip_range_pods              = module.vpc.subnets_secondary_ranges[0][0].range_name
  ip_range_services          = module.vpc.subnets_secondary_ranges[0][1].range_name
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  remove_default_node_pool   = true
  create_service_account     = false
  network_policy             = true
  service_account            = var.service_account

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "n1-standard-2"
      min_count          = 1
      max_count          = 2
      local_ssd_count    = 0
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
      initial_node_count = 1
    },
    {
      name               = "compute-node-pool"
      machine_type       = "n1-standard-4"
      min_count          = 0
      max_count          = 5
      local_ssd_count    = 0
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
      initial_node_count = 0
    }
  ]
  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    compute-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}
    default-node-pool = {
      default-node-pool = true
    }
    compute-node-pool = {
      compute-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}
  }
}
