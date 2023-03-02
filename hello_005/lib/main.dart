import 'package:flutter/material.dart';

/*
 * main()
 * flutter 의 진입점 함수
 * 가장 먼저 실행되는 함수
 * main() 함수의 runApp() 함수를 통해
 * 화면을 구현하는 class 를 호출
 */
void main() {
  runApp(const App());
}

/* 
 * flutter 에서 화면을 구현하는 모든 도구를 widget 이라고 한다
 * 컴포넌트(화면을 구현하는 도구)
 * 
 * StatelessWidget
 * 정적인 화면을 구현하는 widget
 * 데이터의 변화가 없거나 보여만 주는 화면을 구현 
 * 
 * Statelesswidget 을 상속받아서 App 이라는 클래스를 생성하겠다.
 * 상속받은 클래스에서는 build() 함수를(method)   재정의해
 * 다른 widget 을 화면에 보여준다
 */
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // text와 같은 객체가 따로 올 수 없음
    // materialApp 이라는 component가 감싸고 있음
    /**
     * flutter 로 만들어지는 화면을 가장 바깥쪽 box에 
     * MaterialApp() 컨테이너 Widget으로 시작해야 한다
     * MaterialApp() 의 Home 변수에 이후의 다른 widget을 포함한다
     * 
     * MaterialApp() 의 theme 을 적용하기 위해
     * Scaffold()widget 으로 child 를 감싼다
     */
    return MaterialApp(
      title: "Hello",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

/*
 * StatefulWidget 
 * 변화되는 데이터, 변화되는 변수 등을 
 * 화면에 표현하기 위한 클래스
 * 이 클래스는 반드시 State<변수> 클래스를 동반한다
 * StatefulWidget 은 데이터나 변수가 변화되는 것을 감시하고
 * State 클래스에게 통보하는 역할을 수행
 */
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

/*
 * State 클래스는 변화는 데이터, 변수 값을 화면에 그리는 역할
 * State 클래스에서 선언하는 모든 변수는 변수 자체가 State 성질을 갖는다 
 * 
 * 클래스, 변수, 함수 이름 앞에 UnderBar(_) 를 붙이면
 * 모든 접근자가 private 된다
 * 즉 다른 곳에서는 접근할 수 없고 현재 scope 내에서만 접근가능하도록 만든다
 */
class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _conuterUp() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _conuterUp,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("My Flutter App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("반갑습니다"),
            Text(
              "카운터 : $_counter",
              style: const TextStyle(fontSize: 30, color: Colors.blue),
            ),
            const Text("우리나라만세"),
            const Text("Republic"),
            const Text("of"),
            //text widget 은 style을 통해서 변경가능
            const Text(
              "Korea",
              style: TextStyle(fontSize: 24, color: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}
