import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_pomodoro/localnotification.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyHomePage(title: 'Pomodoros'),
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
  final int timeReset = 1500;
  int totalseconds = 5;
  int _count = 0;
  int selectedHours = 0;
  int selectedMinutes = 0;
  int selectedSeconds = 0;

  late Timer _timer;
  int? _changeTimer;
  bool _click = false;
  String clock(int totalseconds) {
    return Duration(seconds: totalseconds).toString().substring(0, 7);
  }

  @override
  void initState() {
    LocalNotification.initialize();
    super.initState();
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
              totalseconds = _changeTimer ?? timeReset;
              _click = !_click;
              _timer.cancel();
              _showNotification();
            }
          });
        },
      );
    } else {
      _timer.cancel();
    }
  }

  _showNotification() async {
    var channel = AndroidNotificationDetails(
      "뽀모도로 알림",
      "타이머 종료",
      priority: Priority.high,
      importance: Importance.max,
      enableVibration: true,
      color: Colors.white,
      vibrationPattern: Int64List.fromList(
        [0, 1000, 5000, 2000],
      ),
    );

    LocalNotification.flutterLocalNotificationsPlugin.show(
      1,
      "타이머 종료",
      "휴식을 취해주세요",
      NotificationDetails(android: channel),
    );
  }

  void _reset() {
    setState(() {
      _timer.cancel();
      _click = false;
      totalseconds = timeReset;
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF50C878),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: SizedBox(
                  height: 50,
                )),
            Container(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            children: [
                              TimePickerSpinner(
                                highlightedTextStyle: const TextStyle(
                                    color: Colors.green, fontSize: 36),
                                time: DateTime.utc(0, 0, 0, 0, 0, 0),
                                is24HourMode: true,
                                isShowSeconds: true,
                                isForce2Digits: true,
                                onTimeChange: (time) {
                                  setState(() {
                                    selectedHours = time.hour;
                                    selectedMinutes = time.minute;
                                    selectedSeconds = time.second;
                                  });
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  int hourInSeconds = selectedHours * 3600;
                                  int minuteInSeconds = selectedMinutes * 60;
                                  int secondInSeconds = selectedSeconds;
                                  totalseconds = hourInSeconds +
                                      minuteInSeconds +
                                      secondInSeconds;
                                  Navigator.pop(context);
                                  setState(() {
                                    totalseconds = totalseconds;
                                    _changeTimer = totalseconds;
                                  });
                                },
                                child: const Text("저장"),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text(
                  clock(totalseconds),
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: SizedBox(
                  height: 50,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: _click == true
                      ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: (BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 4))),
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  iconSize: 48,
                                  onPressed: _start,
                                  icon: const Icon(
                                    Icons.pause_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              resetButton()
                            ],
                          ),
                        )
                      : Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: (BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 4))),
                                child: IconButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  iconSize: 48,
                                  onPressed: _start,
                                  icon: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              resetButton()
                            ],
                          ),
                        ),
                ),
              ],
            ),
            const Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: SizedBox(
                height: 100,
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Color(0xFF00796B),
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

  Container resetButton() {
    return Container(
      decoration: (BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 4))),
      child: IconButton(
        onPressed: _reset,
        icon: const Icon(
          Icons.refresh_outlined,
          color: Colors.white,
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        iconSize: 48,
      ),
    );
  }
}
