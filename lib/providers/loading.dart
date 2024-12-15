import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool getLoading() => _isLoading;
}
