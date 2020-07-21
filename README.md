# Monorepo CI/CD using Github Actions

## Overview

This is an example of using a GitHub monorepo with CI/CD to auto-deploy services.
This example uses `terraform` and `docker-compose` to (1) push and then (2) run these container images on AWS Elasticbeanstalk.

## TODO

* When a service is destroyed, run `terraform destroy -auto-approve` for that servce to destroy all infastructure
* Check for existing of `cicd.docker-compose.yml` to make CI/CD platform optional
