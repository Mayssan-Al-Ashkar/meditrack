import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/init/navigation/inavigation_service.dart';

class NavigationService implements INavigationService {
  static NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final removeAllOldRoutes = (Route<dynamic> route) => false;
  @override
  Future<void> navigateToPage({required String path, Object? object}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: object);
  }

  @override
  Future<void> navigateToPageClear({required String path, Object? object}) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: object);
  }
}
