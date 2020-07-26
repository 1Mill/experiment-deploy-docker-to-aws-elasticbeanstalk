data "aws_availability_zones" "default" {
	state = "available"
}
data "aws_msk_configuration" "default" {
	// Manually managed
	name = "2-4-1--${var.zone_count}-replication-factor"
}

resource "aws_kms_key" "default" {}
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
	configuration_info {
		arn = data.aws_msk_configuration.default.arn
		revision = data.aws_msk_configuration.default.latest_revision
	}
	encryption_info {
		encryption_at_rest_kms_key_arn = aws_kms_key.default.arn
		encryption_in_transit {
			client_broker = "TLS_PLAINTEXT"
			in_cluster = true
		}
	}
	open_monitoring {
		prometheus {
			jmx_exporter {
				enabled_in_broker = false
			}
			node_exporter {
				enabled_in_broker = false
			}
		}
	}
}
resource "aws_security_group" "default" {
	vpc_id = aws_vpc.default.id

	egress {
		cidr_blocks = ["0.0.0.0/0"]
		from_port = 0
		protocol = "-1"
		to_port = 0
	}
	ingress {
		cidr_blocks = [aws_vpc.default.cidr_block]
		from_port   = 443
		protocol    = "tcp"
		to_port     = 443
	}
}
resource "aws_subnet" "default" {
	count = length(slice(data.aws_availability_zones.default.names, 0, var.zone_count))

	availability_zone = data.aws_availability_zones.default.names[count.index]
	cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index)
	vpc_id = aws_vpc.default.id
}
resource "aws_vpc" "default" {
	cidr_block = "192.168.0.0/16"
}
