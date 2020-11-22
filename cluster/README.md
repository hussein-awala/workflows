# GKE cluster

In this folder, we find the [terraform](https://www.terraform.io/) files we use to create the GKE cluster.

### Requirments

- GCP [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
- GCP [service account](https://cloud.google.com/iam/docs/service-accounts) having the following permissions:
    - Organization Administrator
    - Storage Admin (Full access to Google Cloud Storage)
    - Compute Admin (Full control of Compute Engine resources)
    - Kubernetes Engine Admin (Full management of Kubernetes Clusters)
- JSON file contains the key of the created service account
- The following API should be enabled:
    - Cloud Resource Manager API
    - Cloud Billing API
    - Identity and Access Management API
    
### Instructions

1. Create the file `terraform.tfvars` contains the values of the 5 variables from the project. Ex:
    ```hcl-terraform
    project_id = "my-project"
    region     = "europe-west1"
    zones = ["europe-west1-b"]
    gcp_credentials = "terraform.json"
    service_account = "terraform@my-project.iam.gserviceaccount.com"
    ```
2. Initialize Terraform working directory and download modules by executing:
    ```shell script
    terraform init
    ```
3. Build the GKE cluster with a vpc network by executing:
    ```shell script
    terraform apply
    ```
    and enter `yes` when the command display
    ```shell script
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value:
    ```
4. Get the cluster credentials using gcloud sdk:
    ```google cloud
    gcloud container clusters get-credentials <cluster name> --region <region> --project <project name>
    ``` 
