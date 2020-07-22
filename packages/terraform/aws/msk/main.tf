resource "aws_msk_configuration" "default" {
	kafka_versions = [var.kafka_version]
	name = var.name
	server_properties = <<PROPERTIES
		# AWS Defaults
		default.replication.factor=3
		min.insync.replicas=2
		num.io.threads=8
		num.network.threads=5
		num.partitions=1
		num.replica.fetchers=2
		socket.request.max.bytes=104857600
		unclean.leader.election.enable=true
		# Custom defaults
		auto.create.topics.enable = true
		delete.topic.enable = true
	PROPERTIES
}
