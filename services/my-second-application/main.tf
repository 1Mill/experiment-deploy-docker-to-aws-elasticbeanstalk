terraform {
	required_version = "~> 0.12.28"

	backend "s3" {
		// access_key = ENVIRONMENT AWS_ACCESS_KEY_ID
		// profile = ENVIRONMENT AWS_PROFILE
		// region = ENVIRONMENT AWS_DEFAULT_REGION
		// secret_key = ENVIRONMENT AWS_SECRET_ACCESS_KEY

		bucket = "experiment-terraform-state"
		dynamodb_table = "experiment-terraform-state-locks"
		encrypt = true
		key = "services/my-second-application/terraform.tfstate"
		profile = "terraform"
		region = "us-east-1"
	}
}

provider "aws" {
	// Environment AWS_ACCESS_KEY_ID
	// Environment AWS_PROFILE
	// Environment AWS_SECRET_ACCESS_KEY

	region="us-east-1"
	version = "~> 2.59"
}
variable "IMAGE" {
	type = string
}
module "production" {
	source = "github.com/1Mill/experiment-deploy-docker-to-aws-elasticbeanstalk.git//terraform-modules/aws/elasticbeanstalk/docker"
	environment = [
		{ key = "NODE_ENV", value = "production" }
	]
	image = var.IMAGE
	name = "production-my-second-application"
	type = "website"
}
module "staging" {
	source = "github.com/1Mill/experiment-deploy-docker-to-aws-elasticbeanstalk.git//terraform-modules/aws/elasticbeanstalk/docker"
	environment = [
		{ key = "NODE_ENV", value = "production" }
	]
	image = var.IMAGE
	max = 2
	name = "staging-my-second-application"
	type = "website"
}
