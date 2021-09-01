# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE AZURE EVENT GRID TOPIC AND EVENT SUBSCRIPTIONS
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_eventgrid_topic" "event-grid-topic" {
  for_each            = { for topic in var.event_grid_topics : topic.name => topic }
  name                = format("eventgridtopic-%s-%s", lookup(each.value, "name"), var.environment)
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = lookup(each.value, "tags", {})
}

resource "azurerm_eventgrid_event_subscription" "event-subscription" {
  for_each                             = { for sub in var.event_subscriptions : sub.name => sub }
  name                                 = format("%s%s", lookup(each.value, "name"), var.environment)
  scope                                = lookup(each.value, "scope", null)
  advanced_filtering_on_arrays_enabled = lookup(each.value, "advanced_filtering_on_arrays_enabled", false)

  dynamic "azure_function_endpoint" {
    for_each = lookup(each.value, "azure_function_endpoint", [])
    content {
      function_id                       = lookup(each.value, "function_id", null)
      max_events_per_batch              = lookup(each.value, "max_events_per_batch", null)
      preferred_batch_size_in_kilobytes = lookup(each.value, "preferred_batch_size_in_kilobytes", null)
    }
  }
}