variable "environment" {
	default = []
	type = list(
		object({
			key = string
			value = string
		})
	)
}
