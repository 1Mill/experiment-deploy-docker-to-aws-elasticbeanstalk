variable "brokers_per_zone_count" {
	default = 1
	type = number
}
variable "ebs_volume_size_gib" {
	default = 100
	type = number

	validation {
		condition = 100 <= var.ebs_volume_size_gib && var.ebs_volume_size_gib <= 16384
		error_message = "Variable 'ebs_volume_size_gib' must be between 100 - 16384."
	}
}
variable "instance_type" {
	default = "kafka.t3.small"
	type = string
}
variable "kafka_version" {
	default = "2.4.1"
	type = string
}
variable "name" {
	type = string
}
variable "zone_count" {
	// MSK only supports 2 - 3 subnets
	default = 3
	type = number

	validation {
		condition = 2 <= var.zone_count && var.zone_count <= 3
		error_message = "Variable 'zone_count' must be either 2 or 3."
	}
}
