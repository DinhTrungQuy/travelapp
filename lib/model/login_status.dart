// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LoginStatus extends ChangeNotifier {
  bool isLoggedIn = false;

  void setLoginStatus(bool status) {
    isLoggedIn = status;
    notifyListeners();
  }
  
}
