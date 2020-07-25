variable "brokers_per_zone_count" {
	default = 1
	type = number
}
variable "kafka_version" {
	default = "2.4.1"
	type = string
}
variable "zone_count" {
	// ! MSK only supports 2 - 3 subnets
	default = 3
	type = number

	validation {
		condition = 2 <= var.zone_count || var.zone_count <= 3
		error_message = "Variable 'condition' must be either 2 or 3."
	}
}
