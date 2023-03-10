import 'package:flutter/material.dart';
import 'package:todolist/models/todo_dto.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key, required this.todoList});
  // List<TodoDto> 에 담길 데이터를 자동 동기화 시키기 위한
  // Wrapper Class
  final AsyncSnapshot<List<TodoDto>> todoList;
  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.todoList.data?.length,
        itemBuilder: (context, index) {
          // todoList 에서 index 번째 데이터를 getter
          // todo 변수에 담기
          TodoDto todo = widget.todoList.data![index];

          return Dismissible(
            key: UniqueKey(),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  child: Column(
                    children: [
                      Text("${index + 1}"),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  width: 80,
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(todo.sdate),
                      Text(todo.stime),
                    ],
                  ),
                ),
                Container(
                  // decoration: BoxDecoration(
                  // border: Border.all(color: Colors.red, width: 3),
                  // ),
                  width: 280,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    todo.content,
                    style: const TextStyle(fontSize: 24),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )),
          );
        });
  }
}
