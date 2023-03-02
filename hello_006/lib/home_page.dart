import 'package:flutter/material.dart';
import 'package:hello_006/main_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  //State 클래스의 생성자를 호출해 Stateful 과 연결하기
  State<HomePage> createState() => _Homepage();
}

/*
 * State class 를 상속받는 
 * 실제 화면을 그리는 class 
 * 이 클래스는 HomePage 클래스에 의해서 
 * 생성되고 데이터 변화에 따라 화면을 rendering 한다
 * State class 를 상속받는 데 
 * 자신의 부모(Homepage) 를 generic type 으로 만든다
 */
class _Homepage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY APP"),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 4,
        // 대괄호를 갖는 속성을 child 를 여러개 가질 수 있음
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.crop_free_sharp),
      ),
      body: const MainBody(),
    );
  }
}
