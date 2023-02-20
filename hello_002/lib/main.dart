import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  // 화면에 그려질 위젯들을 선으로 보여줌

  /**
   * const App()
   * App class 를 객체로 생성해 코드
   * App class 의 생성자 함수를 호출하는 코드
   */
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('나의 자랑'),
              bottom: const TabBar(tabs: [
                Tab(text: "home"),
                Tab(text: "profile"),
                Tab(text: "기타")
              ]),
            ),
          )),
    );
  }
}
