import 'package:flutter/cupertino.dart';

class NotificationHandler extends ChangeNotifier {
  NotificationHandler._internal();
  static NotificationHandler? _instance;

  factory NotificationHandler.instance() {
    _instance ??= NotificationHandler._internal();
    return _instance!;
  }

  void notify() {
    notifyListeners();
  }

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }

 
}
