import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Flutter"),
      ),
      body: bodyContainer(),
    );
  }

  Container bodyContainer() {
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Column(
        children: [
          bodyText(text: "뭐라고", fontColor: Colors.blue, fontSize: 36),
          bodyText(text: "이게 뭐라고", fontColor: Colors.green, fontSize: 24),
          bodyText(text: "Flutter가 뭐라고"),
        ],
      ),
    );
  }

  Column bodyText({
    required String text,
    Color fontColor = Colors.black,
    double fontSize = 10,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: fontColor, fontSize: fontSize),
        ),
      ],
    );
  }
}
