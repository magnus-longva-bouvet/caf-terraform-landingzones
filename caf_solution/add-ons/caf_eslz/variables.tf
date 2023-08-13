
variable "landing_zones_variables" {
  default = {}
}
# Map of the remote data state
variable "lower_storage_account_name" {
  description = "This value is propulated by the rover"
}
variable "lower_container_name" {
  description = "This value is propulated by the rover"
}
variable "lower_resource_group_name" {
  description = "This value is propulated by the rover"
}

variable "tfstate_subscription_id" {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
variable "subscription_id_overrides_by_keys" {
  default     = {}
  description = "Map of subscription_id_overrides_by_keys to reference subscriptions created by CAF module."
}

variable "tfstate_storage_account_name" {
  description = "This value is propulated by the rover"
}
variable "tfstate_container_name" {
  description = "This value is propulated by the rover"
}
variable "tfstate_resource_group_name" {
  description = "This value is propulated by the rover"
}

variable "diagnostics_definition" {
  default = {}
}

variable "landingzone" {
  default = {
    backend_type        = "azurerm"
    global_settings_key = "launchpad"
    level               = "level1"
    key                 = "enterprise_scale"
    tfstates = {
      launchpad = {
        level   = "lower"
        tfstate = "caf_launchpad.tfstate"
      }
    }
  }
}


variable "user_type" {}
variable "tenant_id" {}
variable "rover_version" {}
variable "logged_user_objectId" {
  default = null
}
variable "tags" {
  type    = map(any)
  default = {}
}

variable "archetype_config_overrides" {
  type = map(
    object({
      archetype_id = string
      parameters = map(map(object({
        hcl_jsonencoded = optional(string)
        integer         = optional(number)
        boolean         = optional(bool)
        value           = optional(string)
        values          = optional(list(string))
        lz_key          = optional(string)
        output_key      = optional(string)
        resource_type   = optional(string)
        resource_key    = optional(string)
        attribute_key   = optional(string)
      }))),
      access_control = map(object({
        managed_identities = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        azuread_groups = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        azuread_service_principals = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        azuread_applications = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        principal_ids = optional(list(string))
      }))
    })
  )
  description = "If specified, will set custom Archetype configurations to the default Enterprise-scale Management Groups."
  default     = {}
}

variable "custom_landing_zonesxxx" {
  type = map(
    object({
      display_name               = string
      parent_management_group_id = string
      subscription_ids           = list(string)
      subscriptions = map(
        object({
          lz_key = string
          key    = string
        })
      )
      archetype_config = object({
        archetype_id = string
        parameters = map(map(object({
          hcl_jsonencoded = optional(string)
          integer         = optional(number)
          boolean         = optional(bool)
          value           = optional(string)
          values          = optional(list(string))
          lz_key          = optional(string)
          output_key      = optional(string)
          resource_type   = optional(string)
          resource_key    = optional(string)
          attribute_key   = optional(string)
        }))),
        access_control = map(object({
          managed_identities = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          azuread_groups = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          azuread_service_principals = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          azuread_applications = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          principal_ids = optional(list(string))
        }))
      })
    })
  )
  description = "If specified, will deploy additional Management Groups alongside Enterprise-scale core Management Groups."
  default     = {}

  validation {
    condition     = can(regex("^[a-z0-9-]{2,36}$", keys(var.custom_landing_zonesxxx)[0])) || length(keys(var.custom_landing_zonesxxx)) == 0
    error_message = "The custom_landing_zones keys must be between 2 to 36 characters long and can only contain lowercase letters, numbers and hyphens."
  }
}

variable "default_location" {
  type        = string
  description = "If specified, will use set the default location used for resource deployments where needed."
  default     = "eastus"

  # Need to add validation covering all Azure locations
}

variable "reconcile_vending_subscriptions" {
  type        = bool
  default     = false
  description = "Will reconcile the subrisciptions created outside of enterprise scale to prevent them to be revoved by the execution of this module."
}

variable "tf_cloud_organization" {
  default     = null
  description = "When user backend_type with remote, set the TFC/TFE organization name."
}

variable "tf_cloud_hostname" {
  default     = "app.terraform.io"
  description = "When user backend_type with remote, set the TFC/TFE hostname."
}