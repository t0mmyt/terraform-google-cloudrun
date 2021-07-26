output "url" {
  value = google_cloud_run_service.cr.status[0].url
}

output "sa_member" {
  value = var.createSA ? "serviceAccount:${local.service_account_email}" : ""
}

output "sa_email" {
  value = var.createSA ? local.service_account_email : ""
}
