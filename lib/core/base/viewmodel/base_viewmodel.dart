import 'package:flutter/material.dart';
import '../../init/navigation/navigation_service.dart';

abstract class BaseViewModel {
  // renamed to avoid name collision with MobX Store.context
  BuildContext? viewContext;
  NavigationService navigation = NavigationService.instance;

  void setContext(BuildContext context);
  void init();
}
