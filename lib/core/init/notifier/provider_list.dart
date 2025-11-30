import 'package:medication_app_v0/core/init/navigation/navigation_service.dart';
import 'package:medication_app_v0/core/init/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ApplicationProvider {
  static final ApplicationProvider _instance = ApplicationProvider._init();
  static ApplicationProvider get instance => _instance;

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
    Provider.value(value: NavigationService.instance)
  ];
}
