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
		key = "services/my-application/terraform.tfstate"
		profile = "terraform"
		region = "us-east-1"
	}
}

module "secrets" {
	source = "github.com/1Mill/experiment-deploy-docker-to-aws-elasticbeanstalk.git//packages/terraform/sops"
	file_path = "./secrets.sops.json"
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
	source = "github.com/1Mill/experiment-deploy-docker-to-aws-elasticbeanstalk.git//packages/terraform/aws/elasticbeanstalk/docker"
	environment = [
		{ key = "MY_EXAMPLE_INJECTED_SECRET_KEY", value = module.secrets.json.MY_EXAMPLE_INJECTED_SECRET_KEY.production },
		{ key = "NODE_ENV", value = "production" }
	]
	image = var.IMAGE
	name = "production-docker-terraform-aws"
	type = "website"
}
module "staging" {
	source = "github.com/1Mill/experiment-deploy-docker-to-aws-elasticbeanstalk.git//packages/terraform/aws/elasticbeanstalk/docker"
	environment = [
		{ key = "MY_EXAMPLE_INJECTED_SECRET_KEY", value = module.secrets.json.MY_EXAMPLE_INJECTED_SECRET_KEY.staging },
		{ key = "NODE_ENV", value = "production" }
	]
	image = var.IMAGE
	max = 2
	name = "staging-docker-terraform-aws"
	type = "website"
}
