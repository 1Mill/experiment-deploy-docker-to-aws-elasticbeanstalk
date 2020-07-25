data "aws_availability_zones" "default" {
	state = "available"
}

resource "aws_vpc" "default" {
	cidr_block = "192.168.0.0/16"
}
resource "aws_subnet" "default" {
	count = length(slice(data.aws_availability_zones.default.names, 0, var.zone_count))

	availability_zone = data.aws_availability_zones.default.names[count.index]
	cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
	vpc_id = aws_vpc.default.id
}
resource "aws_security_group" "default" {
	vpc_id = aws_vpc.default.id
}
resource "aws_msk_cluster" "default" {
	cluster_name = var.name
	kafka_version = var.kafka_version
	number_of_broker_nodes = var.brokers_per_zone_count * length(aws_subnet.default[*].id)

	broker_node_group_info  {
		client_subnets = aws_subnet.default[*].id
		ebs_volume_size = var.ebs_volume_size_gib
		instance_type = var.instance_type
		security_groups = [aws_security_group.default.id]
	}
}
// resource "aws_msk_configuration" "default" {
// 	kafka_versions = [var.kafka_version]
// 	name = var.name
// 	server_properties = <<PROPERTIES
// 		# AWS Defaults
// 		default.replication.factor=3
// 		min.insync.replicas=2
// 		num.io.threads=8
// 		num.network.threads=5
// 		num.partitions=1
// 		num.replica.fetchers=2
// 		socket.request.max.bytes=104857600
// 		unclean.leader.election.enable=true
// 		# Custom defaults
// 		auto.create.topics.enable = true
// 		delete.topic.enable = true
// 	PROPERTIES
// }
