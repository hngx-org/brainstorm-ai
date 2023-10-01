import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  late int changedValue;

  int get valueHolder => changedValue;

  void storeValue(value) {
    changedValue = value;
    notifyListeners();
  }
}
