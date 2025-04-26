resource "azapi_resource" "sp" {
  type = "Microsoft.Web/serverfarms@2023-12-01"

  parent_id = azurerm_resource_group.rg.id

  name     = local.app_service_plan_name
  location = azurerm_resource_group.rg.location

  body = jsonencode({
    kind = "functionapp",
    sku = {
      tier = "FlexConsumption",
      name = "FC1"
    },
    properties = {
      reserved = false
    }
  })

  schema_validation_enabled = false
}
