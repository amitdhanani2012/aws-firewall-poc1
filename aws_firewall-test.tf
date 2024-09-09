resource "aws_networkfirewall_firewall" "aws-firewall1" {
  name                = "aws-firewall1"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.aws-firewall-policy.arn
  vpc_id              = aws_vpc.default.id
  subnet_mapping {
  subnet_id      = aws_subnet.firewall-subnet1.id
  }

  tags = {
    firewall = "network firewall"
  }

  timeouts {
    create = "40m"
    update = "50m"
    delete = "1h"
  }
}

resource "aws_networkfirewall_firewall" "aws-firewall2" {
  name                = "aws-firewall2"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.aws-firewall-policy.arn
  vpc_id              = aws_vpc.default.id
  subnet_mapping {
  subnet_id      = aws_subnet.firewall-subnet2.id
  }

  tags = {
    firewall = "network firewall"
  }

  timeouts {
    create = "40m"
    update = "50m"
    delete = "1h"
  }
}



resource "aws_networkfirewall_firewall_policy" "aws-firewall-policy" {
  name = "aws-firewall-policy"

  firewall_policy {
    stateful_engine_options {
      rule_order = "DEFAULT_ACTION_ORDER"
      }

    policy_variables {
      rule_variables {
        key = "HOME_NET"
        ip_set {
          definition = ["10.1.0.0/16"]
        }
      }


    }
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]
    stateful_rule_group_reference {

      #priority = 1
      resource_arn = aws_networkfirewall_rule_group.aws-firewall-rule-group.arn
    }
  }

  tags = {
    firewallrulepolicy = "suricata"
  }
}


resource "aws_networkfirewall_rule_group" "aws-firewall-rule-group" {
  capacity = 1000
  name     = "aws-firewall-rule-group"
  type     = "STATEFUL"
 
  rule_group {
    stateful_rule_options {
    rule_order = "DEFAULT_ACTION_ORDER"
    }

    rules_source {  
    rules_string = file("suricata_rules_file")
    }
  }
  tags = {
    firewallrule="drop 8080"
  }
 
}





