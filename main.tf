# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY THE AZURE EVENT GRID TOPIC
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_eventgrid_topic" "event-grid-topic" {
  for_each            = { for topic in var.event_grid_topics : topic.name => topic }
  name                = format("eventgridtopic-%s-%s", lookup(each.value, "name"), var.environment)
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = lookup(each.value, "tags", {})
}