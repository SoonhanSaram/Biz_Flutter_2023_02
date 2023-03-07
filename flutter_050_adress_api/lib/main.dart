import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kpostal API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Kpostal API'),
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
  String postCode = "";
  String address = "";
  String latitude = "";
  String longtude = "";

  String KKLatitude = "";
  String KKLongtude = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              searchAddress(context),
              viewAddress(),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Container viewAddress() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            "우편번호 : $postCode",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "주소 : $address",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "위도 : $latitude",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "경도 : $longtude",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "카카오 맵 위도 : $KKLatitude",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "카카오 맵 경도 : $KKLongtude",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  TextButton searchAddress(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KpostalView(
              useLocalServer: true,
              localPort: 1024,
              callback: (result) {
                postCode = result.postCode;
                address = result.address;
                latitude = result.latitude.toString();
                longtude = result.longitude.toString();
                KKLatitude = result.kakaoLatitude.toString();
                KKLongtude = result.kakaoLongitude.toString();
              },
            ),
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      child: const Text(
        "주소검색",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
