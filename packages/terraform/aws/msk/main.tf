resource "aws_msk_cluster" {
	cluster_name = "delete-this-msk-cluster"
	kafka_version = var.kafka_version
	number_of_broker_nodes = 3

	broker_node_group_info  {
		client_subnets = ""
		ebs_volume_size = "100"
		instance_type = "kafka.t3.small"
		security_groups = ""
	}
}
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
