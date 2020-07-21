# Monorepo CI/CD using Github Actions

## Overview

This is an example of a using GitHub as a monorepo using GitHub actions for CI/CDelivery to deploy applications found in the `/services/my-unique-name/` namespace.
The CI/CDelivery pipeline interfaces with the `cicd.docker-compose.yml` found in service folder, and has a common interface of

1. `test-code`: Run unit tests to validate code is working
1. `test-deploy`: Run tests to validate deploy code is working
1. `package`: Run script to publish code to registry
1. `deploy`: Run script to deploy code (usually using newly published code from registry).

This examlpe uses `terraform` to privision and deploy code changes and `docker` as the medium to release code.

To add a new service, just create a new (1) `services/my-new-thing/cicd.docker-compose.yml` with the appropriate interface commands and (2) `services/my-new-thing/main.tf`.

## Production / Staging links

<http://production-docker-terraform-aws.eba-u5tupby8.us-east-1.elasticbeanstalk.com>
<http://staging-docker-terraform-aws.eba-ceu4nyf4.us-east-1.elasticbeanstalk.com>

<http://production-my-second-application.eba-sayk8x2r.us-east-1.elasticbeanstalk.com>
<http://staging-my-second-application.eba-q54myfcd.us-east-1.elasticbeanstalk.com>

## TODO

* When a service is destroyed, run `terraform destroy -auto-approve` for that servce to destroy all infastructure
* Check for existing of `cicd.docker-compose.yml` to make CI/CD platform optional
* Abstract out `package` CI/CD command to be more agnostic and not Docker specific.
  * How do a bundle an S3 object to then import into a serverless function?
* Add `development` branch support to test experimental features in production-like environment.
* When pushing to master, during CI/CD fetch the last successful build commit (instead of the previous commit to the current commit) in order to deploy jobs into production that were successful but halted because the workflow itself stopped. This ensures production is (1) successful and (2) aligns with the code found in master.
