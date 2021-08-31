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
  azure_function_endpoint              = lookup(each.value, "azure_function_endpoint", {})
  webhook_endpoint                     = lookup(each.value, "webhook_endpoint", [])
}