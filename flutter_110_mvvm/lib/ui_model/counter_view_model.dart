// ChangeNotifier 클래스를 Mixin
// Mixin 키워드는 dart 에서 with 를 사용
// ChangeNotifier 클래스를 mixin 한 클래스는 viewModel 클래스가 된다
import 'package:flutter/material.dart';

class CounterViewModel with ChangeNotifier {
  // private 접근제한을 갖는 int 형 변수 선언
  // get 또는 set 선언
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}
