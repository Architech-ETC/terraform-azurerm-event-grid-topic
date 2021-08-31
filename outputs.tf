output "event_grid_topics" {
  value = {
    for topic in azurerm_eventgrid_topic.event-grid-topic :
    topic.name => {
      name                 = topic.name
      id                   = topic.id
      topic_endpoint       = topic.endpoint
      primary_access_key   = topic.primary_access_key
      secondary_access_key = topic.secondary_access_key
    }
  }
  sensitive = true
}

output "event_subscriptions" {
  value = {
    for sub in azurerm_eventgrid_event_subscription.event-subscription :
    sub.name => {
      name = sub.name
      id   = sub.id
    }
  }
}