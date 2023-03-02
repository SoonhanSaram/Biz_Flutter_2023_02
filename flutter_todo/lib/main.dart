import 'package:flutter/material.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TodoList",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Homepage(title: "TodoList"),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});
  final String title;
  @override
  State<Homepage> createState() => HomePageState();
}

class HomePageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title);
  }
}
