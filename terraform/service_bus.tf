resource "azurerm_servicebus_namespace" "common_messaging" {
  name = local.service_bus_name

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  sku = "Basic"

  local_auth_enabled = false
}

resource "azurerm_servicebus_queue" "core_player_connected" {
  name         = "core_player_connected"
  namespace_id = azurerm_servicebus_namespace.common_messaging.id
}

resource "azurerm_servicebus_queue" "core_chat_message" {
  name         = "core_chat_message"
  namespace_id = azurerm_servicebus_namespace.common_messaging.id
}

resource "azurerm_servicebus_queue" "core_map_vote" {
  name         = "core_map_vote"
  namespace_id = azurerm_servicebus_namespace.common_messaging.id
}

resource "azurerm_servicebus_queue" "core_server_connected" {
  name         = "core_server_connected"
  namespace_id = azurerm_servicebus_namespace.common_messaging.id
}

resource "azurerm_servicebus_queue" "core_map_changed" {
  name         = "core_map_changed"
  namespace_id = azurerm_servicebus_namespace.common_messaging.id
}
