resource "aws_iam_policy" "s3-firewall" {
  name        = "s3-firewall"
  path        = "/"
  description = "s3-firewall"

  policy = jsonencode(
   {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::s3-firewall/aws-firewall-log1/*","arn:aws:s3:::s3-firewall/aws-firewall-log2/*"
            ]
        }
    ]
}


)

}

resource "aws_iam_role" "s3-firewall-role" {
  name = "s3-firewall-role"

  assume_role_policy = jsonencode({

  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [          
          "network-firewall.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
 }  

)

  tags = {
    "s3-firewall-role" : "s3-firewall-role"
  }
}



resource "aws_iam_policy_attachment" "s3-firewall-role-attachment" {
  name       = "s3-firewall-role-attachment"
  roles      = [aws_iam_role.s3-firewall-role.name]
  policy_arn = aws_iam_policy.s3-firewall.arn
}
