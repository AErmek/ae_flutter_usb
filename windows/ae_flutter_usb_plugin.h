#ifndef FLUTTER_PLUGIN_AE_FLUTTER_USB_PLUGIN_H_
#define FLUTTER_PLUGIN_AE_FLUTTER_USB_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace ae_flutter_usb {

class AeFlutterUsbPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AeFlutterUsbPlugin();

  virtual ~AeFlutterUsbPlugin();

  // Disallow copy and assign.
  AeFlutterUsbPlugin(const AeFlutterUsbPlugin&) = delete;
  AeFlutterUsbPlugin& operator=(const AeFlutterUsbPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace ae_flutter_usb

#endif  // FLUTTER_PLUGIN_AE_FLUTTER_USB_PLUGIN_H_
