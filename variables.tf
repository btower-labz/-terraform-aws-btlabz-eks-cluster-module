variable "cluster_name" {
  description = "The name of your EKS Cluster"
  default     = "sandbox"
}

variable "k8s_version" {
  description = "Required K8s version"
  default     = "1.18"
}

variable "subnets" {
  description = "A list of subnets to place the EKS cluster within."
  type        = list(string)
  validation {
    condition     = length(var.subnets) > 1
    error_message = "Non-empty list of VPC subnets identifiers must be provided."
  }
}

variable "kube2iam_roles" {
  description = "The list of POD IAM roles for kube2iam (roles to assume)."
  type        = list(string)
  default     = ["*"]
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "A list of the desired control plane logging to enable."

  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
}

variable "cluster_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
  type        = bool
  default     = true
}

variable "cluster_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = true
}

variable "cluster_public_access_cidrs" {
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled."
  type        = list(string)
  default = [
    "0.0.0.0/0"
  ]
}

variable "tags" {
  description = "Common Tags to attach to Resources"
  type        = map(string)
}
