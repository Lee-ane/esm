import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  String password = '';
  void passWord(String passWord) {
    password = passWord;
    notifyListeners();
  }
}
