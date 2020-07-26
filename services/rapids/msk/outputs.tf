output "brokers" {
	value = aws_msk_cluster.default.bootstrap_brokers
}
output "brokers_tls" {
	value = aws_msk_cluster.default.bootstrap_brokers_tls
}
