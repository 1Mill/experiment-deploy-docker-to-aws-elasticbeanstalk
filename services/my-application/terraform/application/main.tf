resource "aws_elastic_beanstalk_application" "default" {
	name = "terraform-beanstalk-docker-example"
}
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
		value = "primary-admin"
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
