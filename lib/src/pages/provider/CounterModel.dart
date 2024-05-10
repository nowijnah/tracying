import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier{
  int _count = 300;

  int get  count => _count;

  void increase(){
    _count+=5;
    notifyListeners();
  }

  int _trashType = 0;

  int get trashType => _trashType;

  void normal() {
    _trashType = 0;
    notifyListeners();
  }

  void recycle() {
    _trashType = 1;
    notifyListeners();
  }
}