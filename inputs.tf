variable "location" {
  description = "GCP Region"
  type        = string
}

variable "name" {
  description = "Name of Cloud Run service"
  type        = string
}

variable "image" {
  description = "Source image for the service"
  type        = string
}

variable "ports" {
  description = "Ports to expose"
  type        = list(object({ name : string, container_port : string }))
  default     = []
}

variable "command" {
  description = "Optionally override container entrypoint"
  type        = list(string)
  default     = []
}

variable "args" {
  description = "Arguments to entrypoint"
  type        = list(string)
  default     = []
}

variable "minInstances" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "maxInstances" {
  description = "Maximum number of instances"
  type        = number
  default     = null
}

variable "cpuLim" {
  description = "CPU limit"
  type        = string
  default     = null
}

variable "memLim" {
  description = "Memory limit"
  type        = string
  default     = null
}

variable "createSA" {
  description = "Create Service Account for Cloud Run"
  type        = bool
  default     = false
}

variable "service_account_name" {
  description = "Service account for Cloud run to assume (if created externally)"
  type        = string
  default     = null
}

variable "invokers" {
  description = "List if IAM members who can call invoke"
  type        = list(string)
  default     = []
}

variable "allowUnauthenticated" {
  description = "Whether or not GCP Authentication is needed to invoke function"
  type        = bool
  default     = false
}

variable "envs" {
  description = "Map of environment variables to pass to container"
  type        = map(string)
  default     = {}
}

variable "ingress" {
  description = "Type of ingress to allow"
  type        = string
  default     = "internal"
  validation {
    condition     = contains(["all", "internal", "internal-and-cloud-load-balancing"], var.ingress)
    error_message = "An invalid ingress type was passed."
  }
}

