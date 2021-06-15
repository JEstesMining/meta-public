terraform {
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
# translations repository
#-------------------------------------------------------------------------------
resource "github_repository" "translations" {
  name         = "translations"
  description  = "Translation files for DasCrypto"
  homepage_url = "https://dascrypto.farm"
  visibility   = "public"

  has_issues             = true
  has_wiki               = false
  delete_branch_on_merge = true
  vulnerability_alerts   = true
}
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
# chia-client-php repository
# - This Repository needs issue labels
#-------------------------------------------------------------------------------
resource "github_repository" "chia_client_php" {
  name         = "chia-client-php"
  description  = "Provides the ability to communicate with chia via RPC"
  visibility   = "public"

  topics = ["chia","chia-blockchain","php","php-library"]

  has_issues             = true
  has_wiki               = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
}
#-------------------------------------------------------------------------------
# meta-public
#-------------------------------------------------------------------------------
resource "github_repository" "meta_public" {
  name         = "meta-public"
  description  = "Contains code used to build out the organization"
  visibility   = "public"

  has_issues             = true
  has_wiki               = false
  has_projects           = false
  delete_branch_on_merge = true
  vulnerability_alerts   = true
}
