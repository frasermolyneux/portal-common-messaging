locals {
  resource_group_name       = "rg-portal-cms-${var.environment}-${var.location}"
  key_vault_name            = "kv-${random_id.environment_id.hex}-${var.location}"
  function_app_name         = "fn-portal-cms-${var.environment}-${var.location}-${random_id.environment_id.hex}"
  function_app_storage_name = "safn${random_id.environment_id.hex}"
  app_service_plan_name     = "asp-portal-cms-${var.environment}-${var.location}"
  service_bus_name          = "sb-portal-cms-${var.environment}-${var.location}-${random_id.environment_id.hex}"
}
