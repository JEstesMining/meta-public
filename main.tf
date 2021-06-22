terraform {
  required_version = ">=0.15"

  # @see https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes
  experiments = [module_variable_optional_attrs]

  backend "remote" {}

  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}
################################################################################
# Providers
################################################################################
provider "github" {
  owner = var.github_organization
}
################################################################################
# GitHub Memberships
################################################################################
resource "github_membership" "admins" {
  count = length(var.github_admins)

  username = element(var.github_admins, count.index)
  role     = "admin"
}
resource "github_membership" "members" {
  count = length(var.github_members)

  username = element(var.github_members, count.index)
  role     = "member"
}
################################################################################
# GitHub Repositories
################################################################################
#-------------------------------------------------------------------------------
# dascrypto.farm repository
#-------------------------------------------------------------------------------
resource "github_repository" "dascrypt_farm" {
  name         = "dascrypto.farm"
  description  = "Main website for DasCrypto.farm"
  homepage_url = "https://dascrypto.farm"
  visibility   = "public"

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  pages {
    cname = "dascrypto.farm"
    source {
      branch = "master"
    }
  }
}
#-------------------------------------------------------------------------------
# All other public repositories
#-------------------------------------------------------------------------------
resource "github_repository" "this" {
  count = length(var.github_repos)

  name         = var.github_repos[count.index].name
  homepage_url = var.github_repos[count.index].homepage_url
  description  = var.github_repos[count.index].description
  topics       = var.github_repos[count.index].topics

  has_wiki             = var.github_repos[count.index].has_wiki == null ? true : var.github_repos[count.index].has_wiki
  has_issues           = true
  vulnerability_alerts = true
}
