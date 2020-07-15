variable "environment" {
	default = []
	type = list(
		object({
			key = string
			value = string
		})
	)
}
variable "image" {
	type = string
}
variable "max" {
	default = 4
	type = number
}
variable "min" {
	default = 1
	type = number
}
variable "name" {
	type = string
}
variable "type" {
	default = ""
	type = string
}
