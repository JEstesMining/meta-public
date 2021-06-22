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

variable "github_repos" {
  description = "Public GitHub Repos"
  default     = []
  type        = list(object({
    name         = string
    description  = optional(string)
    homepage_url = optional(string)
    topics       = optional(list(string))
    has_wiki     = optional(bool)
  }))
}
