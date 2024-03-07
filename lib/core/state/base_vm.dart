import 'package:flutter/material.dart';

class BaseVM extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  void setBusy({required bool status}) {
    _busy = status;
    notifyListeners();
  }
}
