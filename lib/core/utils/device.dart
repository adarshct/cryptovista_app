import 'package:cryptovista_app/core/utils/page_navigator.dart';
import 'package:material_ui/material_ui.dart';

abstract class Device {
  static double get width =>
      MediaQuery.of(NavigationService.context!).size.width;

  static double get height =>
      MediaQuery.of(NavigationService.context!).size.height;

  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
