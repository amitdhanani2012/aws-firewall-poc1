1. POC on AWS NETWORK FIREWALL using terraform for multiple AZ/multiple subnets - Distributed firewall approach for per VPC (We can use inspect vpc for firewall and rest vpcs for instances as design if we want. Here I used per VPC approach not inspect VPC approach)



For Architecture design refer document on link 
https://aws.amazon.com/blogs/networking-and-content-delivery/deployment-models-for-aws-network-firewall/


2. AWS stateless firewall forwards packet to aws network stateful suricata compatible firewall rules as default action

3. IGWRT route table has edge assoication with internet gateway via gatway_id  (for ingress/internet traffic to pass through it)

4. Public subnets has ec2 instance with web service on 8080 and 8081 with autoscale and load balancer

5. Firewall subnets has aws network firewall endpoints

6. public subnet routes to firewall endpoints and firewall endpoints route to internet gateway

7. Ingress traffic for "load balancer/public ip of instance" route to firewall via IGWRT route table, IGWRT route has route to forward ingress traffic to firewall endpoint.

8. In my POC I also allowed incoming traffic for port 22(ssh), 8081(http).I also allowed outgoing http traffic from instance to port 80,443. Default rule policy starts checking rules in the order of pass,drop,reject,alert (DEFAULT_ACTION_ORDER rule_order). There is drop rule to drop other traffic on http. Here firewalling totally depends on rules according to suricata rule group.

NOTE: suricata rules has priority field to give priority to some rules over other rules. Suricata rules are majority used to block malicious packets as IPC. It can also work as IDS alerts instead blocking. Port blocking is just simple POC


So, when you get load balancer output after terraform apply complete (like lb_dns = "my-alb-pub-xxx.us-west-2.elb.amazonaws.com")

then lb_dns:8081 will work and lb_dns:8080 will be blocked

You can get public IP of ec2 instance from AWS console and can do ssh

This POC can be enhanced by more automation in subnet configuration/other configurartion but, for now its just for IDEA that how it works. Here I took one VPC but we can expand to more than one VPC
