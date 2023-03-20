import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_090_pomodoro/pages/dash_board_page.dart';
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
  static const homeTitle = "home";
  static const dashBoardTitle = "dashBoard";
  int _pageIndex = 0;
  int _counter = setCounter;
  bool _timeRun = false;
  final PageController _pageController = PageController(initialPage: 0);
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
          body: PageView(
            controller: _pageController,
            // page가 전환됐을 때, bottmNav에 표시
            onPageChanged: (pageNum) {
              setState(() {
                _pageIndex = pageNum;
              });
            },
            children: [
              MainPage(
                  counter: _counter, onPressed: _onPressed, timeRun: _timeRun),
              const DashBoardPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(
                () {
                  _pageIndex = value;
                  _pageController.animateToPage(
                    value, // 페이지 번호
                    duration: const Duration(milliseconds: 700), // 페이지 전환 시간
                    curve: Curves.ease, // 애니메이션 종류
                  );
                },
              );
            },
            currentIndex: _pageIndex,
            items: const [
              BottomNavigationBarItem(label: homeTitle, icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: dashBoardTitle, icon: Icon(Icons.dashboard)),
            ],
          ),
        ),
      ),
    );
  }
}
