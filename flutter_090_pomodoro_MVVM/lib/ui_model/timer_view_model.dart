import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_090_pomodoro/models/timer_dto.dart';

class TimerViewModel with ChangeNotifier {
  static const setCounter = 5;
  var timerDto = TimerDto(timer: setCounter);

  late Timer _timer;

  void onPressed() {
    timerDto.timeRun = !timerDto.timeRun;
    if (timerDto.timeRun) {
      _timer = Timer.periodic(
        // Duration 으로 설정된 시간마다 Callback 함수를 실행
        const Duration(seconds: 1),
        //Callback 함수
        (timer) {
          timerDto.timer--;
          if (timerDto.timer < 1) {
            timerDto.timer = setCounter;
            timerDto.timeRun = false;
            _timer.cancel();
          }
          notifyListeners();
        },
      );
    } else {
      _timer.cancel();
    }
    notifyListeners();
  }
}
