import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int totalseconds = 5;
  int _count = 0;
  late Timer _timer;
  bool _click = false;
  String clock(int totalseconds) {
    return Duration(seconds: totalseconds).toString().substring(0, 7);
  }

  void _start() {
    setState(() {
      _click = !_click;
    });
    if (_click) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            totalseconds--;
            if (totalseconds == 0) {
              _count++;
              totalseconds = 5;
              _click = !_click;
              _timer.cancel();
            }
          });
        },
      );
    } else {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Text(clock(totalseconds)),
            ),
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                height: 200,
              ),
            ),
            Expanded(
                child: _click == true
                    ? Center(
                        child: IconButton(
                          onPressed: _start,
                          icon: const Icon(
                            Icons.pause_rounded,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : Center(
                        child: IconButton(
                          onPressed: _start,
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ),
                        ),
                      )),
            const Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                height: 200,
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "$_count",
                      style: const TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
