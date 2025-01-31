variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "chkk-operator"
}

variable "namespace" {
  description = "Namespace to install the Helm release into."
  type        = string
  default     = "chkk-system"
}

variable "chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = ""
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist."
  type        = bool
  default     = true
}

variable "filter" {
  description = "Override the default filter for the chkk-agent"
  type        = map(any)
  default     = {}
}

variable "chkk_operator_config" {
  description = "Values for the chkk-operator Helm chart"
  default     = {}
}

variable "chkk_agent_config" {
  description = "Override the default chkk-agent config"
  type = object({
    secret = optional(object({
      secretName = string
      keyName    = string
    }))
    serviceAccount = optional(object({
      create = bool
      name   = optional(string)
      }), {
      create = true
    })
  })
  default = {}
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = ""
}

variable "cluster_environment" {
  description = "Environment of the cluster"
  type        = string
  default     = ""
}
