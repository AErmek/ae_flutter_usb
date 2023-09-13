#include "include/ae_flutter_usb/ae_flutter_usb_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ae_flutter_usb_plugin.h"

void AeFlutterUsbPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ae_flutter_usb::AeFlutterUsbPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
