resource "aws_cloudwatch_log_group" "msk_cloudwatch_log_group" {
  name = "msk_broker_logs"
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = "msk-cluster"
  kafka_version          = "2.6.2"
  number_of_broker_nodes = 3

  broker_node_group_info {
    client_subnets = [
      module.vpc.private_subnets[0],
      module.vpc.private_subnets[1],
      module.vpc.private_subnets[2]
    ]
    ebs_volume_size = 2
    instance_type   = "kafka.m5.large"
    security_groups = [aws_security_group.sg.id]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.msk_kms_key.arn
  }

  client_authentication {
    sasl {
      iam = true
    }
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk_cloudwatch_log_group.name
      }
    }
  }
}
