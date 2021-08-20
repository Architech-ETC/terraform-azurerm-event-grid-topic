# terraform-azurerm-event-grid-topic

## Create an event grid topic in Azure

Module to create an Azure event grid topic.

- [Azure documentation](https://docs.microsoft.com/en-us/azure/event-grid)

# Module details

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.5  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_topic.event-grid-topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic)| resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_event_grid_topic"></a> [event\_grid\_topic](#input\_event\_grid\_topic) | Event Grid topic input values including name, input_schema, public network access | `list(object)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the event grid topic should exist. Changing this forces a new resource to be create | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Specifies the environment of the event grid | `string` | n/a | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to the event grid topic | `map(string)` | `{}` | no |

| Name | Description |
|------|-------------|
| <a name="output_event_grid_topics"></a> [id](#output\_event\_grid\_topics) | name, id, topic endpoint and primary, secondary access key |
|

# Usage example 

## Basic 
```
module "event-grid-topic" {
  source  = "app.terraform.io/Architech-ETC/event-grid-topic/azurerm"
  version = "1.0.0"
  
  event_grid_topics = [{
    name                          = "eventgridtopic-etc-dev",
    input_schema                  = "EventgridSchema"
    public_network_access_enabled = true,
    tags                          = {
        environment = "dev"
    }
  }]

  resource_group_name = "etc"
  environment         = "dev"
  location            = "uksouth"
}
```