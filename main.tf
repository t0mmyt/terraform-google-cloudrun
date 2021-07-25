data "google_project" "this" {}

locals {
  service_account_name = var.createSA ? "${var.name}-cr" : var.service_account_name
  email = "${local.service_account_name}@${data.google_project.this.project_id}.iam.gserviceaccount.com"
}

resource "google_service_account" "sa" {
  count = var.createSA ? 1 : 0

  account_id = local.service_account_name
}

resource "google_cloud_run_service" "cr" {
  location = var.location
  name     = var.name
  template {
    spec {
      service_account_name = local.service_account_name
      containers {
        image   = var.image
        command = var.command
        args    = var.args
        dynamic "ports" {
          for_each = var.ports[*]
          content {
            name           = ports.value.name
            container_port = ports.value.container_port
          }
        }
      }
    }
  }

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = var.ingress
    }
  }
}

resource "google_cloud_run_service_iam_member" "invokers" {
  for_each = toset(var.invokers)

  location = var.location
  service  = google_cloud_run_service.cr.name
  member   = each.value
  role     = "roles/run.invoker"
}
