import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/dao/todo_dao.dart';
import 'package:todolist/models/todo_dto.dart';
import 'package:todolist/screen/todo_list_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoHomePage(title: 'Hello TodoList'),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key, required this.title});
  // TodoHomePage() 생성자에 title 변수 값으로 전달된 문자열이
  // 자동 setting 된다.
  final String title;

  @override
  State<TodoHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TodoHomePage> {
  String content = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Image(
          image: AssetImage("images/image_01.jpg"),
          width: 100,
          height: 100,
        ),
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: IconButton(
                onPressed: () {
                  todoInputBox(context);
                },
                icon: const Icon(Icons.add)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: FutureBuilder(
          future: TodoDao().selectAll(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return TodoListView(todoList: snapShot);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> todoInputBox(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: const InputDecoration(hintText: "할 일 입력"),
                  onChanged: (value) {
                    setState(() {
                      content = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, "INSERT");
                    },
                    child: const Text("추가하기"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // 팝업창을 닫기위한 코드
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "취소",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          );
        }).then((result) {
      if (result == "INSERT") {
        // DateTime.now() : 시스템의 현재 날짜, 시간 가져오기
        // DateFormat(형식).format(날짜데이터)
        //    : 날짜데이;터를 형식 문자열로 가져오기
        String sdate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String stime = DateFormat('HH:mm:ss').format(DateTime.now());
        TodoDto todo = TodoDto(
          sdate: sdate,
          stime: stime,
          content: content,
        );
        TodoDao().insert(todo);
        setState(() {});
      }
    });
  }
}
