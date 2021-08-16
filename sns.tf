#create an SNS Topic
# terraform aws create sns topic

resource "aws_sns_topic" "user-update" {
  name = "update-topic"
}

# Create an SNS Topic Subscription
resource "aws_sns_topic_subscription" "notification-topic" {
  topic_arn = aws_sns_topic.user-update.arn
  protocol  = "email"
  endpoint  = var.endpoint-email
}
