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
		key = "services/rapids/terraform.tfstate"
		region = "us-east-1"
	}
}

provider "aws" {
	// Environment AWS_ACCESS_KEY_ID
	// Environment AWS_PROFILE
	// Environment AWS_SECRET_ACCESS_KEY

	region="us-east-1"
	version = "~> 2.70"
}
module "production" {
	source = "github.com/1Mill/experiment-deploy-docker-to-aws-elasticbeanstalk.git//packages/terraform/aws/msk"
	name = "production-rapids"
}
output "brokers" {
	value = module.production.brokers
}
