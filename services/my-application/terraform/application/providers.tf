terraform {
	experiments = [variable_validation]

	required_providers {
		aws = "~> 2.58"
		random = "~> 2.3"
	}
}
