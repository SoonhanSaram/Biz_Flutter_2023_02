import 'package:flutter/material.dart';

void main() {
  runApp(const Regist());
}

class Regist extends StatelessWidget {
  const Regist({super.key});
  final String imageLogo = 'assets/images/movv.png';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "예약 연습",
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(
        body: Container(),
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      elevation: 2,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      child: const Icon(Icons.add),
    );
  }

  Center iconButton() {
    return Center(
      child: ElevatedButton(
        style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          minimumSize: MaterialStatePropertyAll(
            Size(200, 200),
          ),
        ),
        onPressed: () {},
        child: const Icon(
          Icons.add_reaction_sharp,
          size: 200,
        ),
      ),
    );
  }
}
