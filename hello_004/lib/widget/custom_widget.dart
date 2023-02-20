// ignore: came_case_types
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              "순한",
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            Text(
              "kyengmin911@naver.com",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
