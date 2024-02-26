import 'package:flutter/material.dart';

class Wishlist extends ChangeNotifier {
  List<String> _wishlist = [];

  List<String> get wishlist => _wishlist;

  void add(String placeId) {
    if (_wishlist.contains(placeId)) return;
    _wishlist.add(placeId);
    notifyListeners();
  }

  void remove(String placeId) {
    _wishlist.remove(placeId);
    notifyListeners();
  }

  bool contains(String placeId) {
    return _wishlist.contains(placeId);
  }
}
