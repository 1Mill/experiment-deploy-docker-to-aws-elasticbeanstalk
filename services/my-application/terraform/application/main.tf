// Create IAM role to manage elasticbeanstalk
resource "aws_iam_role_policy_attachment" "default" {
	policy_arn  = "arn:aws:iam::aws:policy/AdministratorAccess"
	role = aws_iam_role.default.name
}
resource "aws_iam_role" "default" {
	assume_role_policy = <<EOF
{
	"Statement": [
		{
			"Action": "sts:AssumeRole",
			"Effect": "Allow",
			"Principal": {
				"Service": "ec2.amazonaws.com"
			},
			"Sid": ""
		}
	],
	"Version": "2012-10-17"
}
EOF
}
resource "aws_iam_instance_profile" "default" {
	role = aws_iam_role.default.name
}

// Create environment
resource "aws_elastic_beanstalk_application" "default" {
	name = "terraform-beanstalk-docker-example"
}

// Create Application
resource "aws_elastic_beanstalk_environment" "default" {
	application = aws_elastic_beanstalk_application.default.name
	name = "production"
	solution_stack_name = "64bit Amazon Linux 2 v3.0.3 running Docker"
	tier = "WebServer"

	setting {
		name = "InstanceTypes"
		namespace = "aws:ec2:instances"
		value = "t3.micro"
	}
	setting {
		name = "MaxSize"
		namespace = "aws:autoscaling:asg"
		value = "2"
	}
	setting {
		name = "MinSize"
		namespace = "aws:autoscaling:asg"
		value = "1"
	}
	setting {
		name = "IamInstanceProfile"
		namespace = "aws:autoscaling:launchconfiguration"
		value = aws_iam_instance_profile.default.name
	}

	// Environmental settings
	dynamic "setting" {
		for_each = var.environment
		content {
			name = setting.value["key"]
			namespace = "aws:elasticbeanstalk:application:environment"
			value = setting.value["value"]
		}
	}
}
