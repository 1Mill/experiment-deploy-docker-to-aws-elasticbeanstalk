module "production" {
	source = "./terraform/application"
	environment = [
		{ key = "NODE_ENV", value = "production" }
	]
}
