variable "github_organization" {
  description = "GitHub Organization"
  type        = string
  default     = ""
}

variable "github_members" {
  description = "GitHub Members"
  type        = list(string)
  default     = []
}

variable "github_admins" {
  description = "GitHub Admins"
  type        = list(string)
  default     = []
}
