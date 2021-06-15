Meta Repository
===============

This repository is used to build out all the public infrastructure that is used.

# Usage

* Clone repository
* `cp backend.hcl.dist backend.hcl`
* Edit backend.hcl with the correct values
* `terraform init -backend-config=backend.hcl
* `terraform apply`
