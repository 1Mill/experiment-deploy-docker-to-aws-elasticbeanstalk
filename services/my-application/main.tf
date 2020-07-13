provider "aws" {
	// Environment AWS_ACCESS_KEY_ID
	// Environment AWS_PROFILE
	// Environment AWS_SECRET_ACCESS_KEY

	region="us-east-1"
	version = "~> 2.59"
}

module "production" {
	source = "./terraform/application"
	environment = [
		{ key = "NODE_ENV", value = "production" }
	]
}
module "release" {
	source = "./terraform/release"
}
