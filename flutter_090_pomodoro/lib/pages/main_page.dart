import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  /*
   * main.dart 에서 전달된 counter state 변수를
   * statefulWidget 이 감시를 하고 있다가
   * 값이 변화되면 State에게 통보해 화면을 Rendering 하도록 한다
   * main.dart 에서 전달된 counter state 변수는
   * widget 클래스에 담아서 state 로 전달
   */
  const MainPage(
      {super.key,
      required this.counter,
      required this.onPressed,
      required this.timeRun});
  final int counter;
  final Function() onPressed;
  final bool timeRun;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _formatTime(seconds) {
    // Duration 클래스 : 시, 분, 초 값을 전달받아서
    // 시:분:초 형식으로 변환시키는 클래스
    var duration = Duration(seconds: seconds);

    print(duration);

    // split(구분자)
    // 구분자를 기준으로 문자열을 분해하고,
    // 배열(List)로 변환시키는 함수
    var times = duration.toString().split(".");
    // 생성된 문자열 List times의 0 index 값을 추출하고 substring으로 분해
    if (times.length > 8) {
      return times.first.substring(3);
    } else {
      return times.first.substring(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Text(
                _formatTime(widget.counter),
                style: TextStyle(
                  fontSize: 84,
                  fontWeight: FontWeight.w900,

                  /**
                   * var Paint paint = Paint()
                   * paint.style(...)
                   * paint.strokeWidth(3)
                   * paint.color(Colors.amber)
                   */
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.white,
                ),
              ),
              Text(
                _formatTime(widget.counter),
                style: const TextStyle(
                    fontSize: 84,
                    fontWeight: FontWeight.w900,
                    color: Colors.amber),
              ),
            ]),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          backgroundColor: Colors.white38,
          elevation: 5,
          onPressed: widget.onPressed,
          tooltip: 'Start',
          child: Icon(
            (widget.timeRun ? Icons.pause : Icons.play_arrow_rounded),
            size: 80,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
