variable "event_grid_topics" {
  type = list(object({
    name                          = string,
    input_schema                  = string
    public_network_access_enabled = bool
    tags                          = map(string)
  }))
}

variable "environment" {
  type        = string
  description = "Specifies the environment of the Bastion Host. Changing this forces a new resource to be created."

  validation {
    condition     = contains(["sandbox", "dev", "qa", "preprod", "prod"], var.environment)
    error_message = "The environment must be one of the specified values sandbox, dev, qa, preprod, prod."
  }
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "event_subscriptions" {
  type = list(object({
    name                                 = string,
    scope                                = string,
    advanced_filter                      = list(any),
    advanced_filtering_on_arrays_enabled = bool,
    event_delivery_schema                = string,
    azure_function_endpoint = object({
      function_id                       = string,
      max_events_per_batch              = number,
      preferred_batch_size_in_kilobytes = number
    }),
    webhook_endpoint = object({
      url                               = string,
      max_events_per_batch              = number,
      preferred_batch_size_in_kilobytes = number,
      active_directory_app_id_or_uri    = string,
      active_directory_tenant_id        = string
    })
  }))
}
