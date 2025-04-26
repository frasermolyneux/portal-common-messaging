resource "azurerm_linux_function_app" "app" {
  name = local.function_app_name
  tags = var.tags

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  service_plan_id = azapi_resource.sp.id

  storage_account_name          = azurerm_storage_account.function_app_storage.name
  storage_uses_managed_identity = true

  https_only = true

  functions_extension_version = "~4"

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      use_dotnet_isolated_runtime = true
      dotnet_version              = "9.0"
    }

    cors {
      allowed_origins = ["https://portal.azure.com"]
    }

    application_insights_connection_string = data.azurerm_application_insights.core.connection_string

    ftps_state          = "Disabled"
    always_on           = true
    minimum_tls_version = "1.2"

    health_check_path                 = "/api/health"
    health_check_eviction_time_in_min = 5
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"                   = "0" # This will be set to 0 on initial creation but will be updated to 1 when the package is deployed (required for azurerm_function_app_host_keys)
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"

    "ServiceBusConnection__fullyQualifiedNamespace" = format("%s.servicebus.windows.net", azurerm_servicebus_namespace.common_messaging.name)

    // https://learn.microsoft.com/en-us/azure/azure-monitor/profiler/profiler-azure-functions#app-settings-for-enabling-profiler
    "APPINSIGHTS_PROFILERFEATURE_VERSION"  = "1.0.0"
    "DiagnosticServices_EXTENSION_VERSION" = "~3"
  }

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"] # Ignore changes to this property as it will be updated by the deployment pipeline
    ]
  }
}
