import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_090_pomodoro/pages/main_page.dart';

void main() {
  /**
   * main() => stateless => statefull => state 이러한 경로를 생략한 경우
   * DataBinding 이 되는 경우
   * main() 함수에 App 초기화 코드들이 있는 경우
   * 이 속성을 추가해 주는 것이 좋다
   */
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const setCounter = 1500;
  int _counter = setCounter;
  bool _timeRun = false;

  late Timer _timer;

  void _onPressed() {
    setState(() {
      _timeRun = !_timeRun;
    });
    if (_timeRun) {
      _timer = Timer.periodic(
        // Duration 으로 설정된 시간마다 Callback 함수를 실행
        const Duration(seconds: 1),
        //Callback 함수
        (timer) {
          setState(() {
            _counter--;
            if (_counter < 1) {
              _counter = setCounter;
              _timeRun = false;
              _timer.cancel();
            }
          });
        },
      );
    } else {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/background.jpg"),
          ),
        ),
        child: Scaffold(
          // Container에 image로 배경을 채우기 위해서 Scaffold의 배경색을 지우기
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [MainPage(counter: _counter)],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: 100,
            height: 100,
            child: FloatingActionButton(
              backgroundColor: Colors.white38,
              elevation: 5,
              onPressed: _onPressed,
              tooltip: 'Start',
              child: Icon(
                (_timeRun ? Icons.pause : Icons.play_arrow_rounded),
                size: 80,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
