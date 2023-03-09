import 'package:flutter/material.dart';
import 'package:regist/dto/reselvation_info.dart';

class reselvation extends StatefulWidget {
  const reselvation({super.key, this.reselInfo});
  final reselInfo;
  @override
  State<reselvation> createState() => _reselvationState();
}

class _reselvationState extends State<reselvation> {
  late ReselInfo reselInfo;
  @override
  void initState() {
    super.initState();
    reselInfo = widget.reselInfo;
    _dateController.text = reselInfo.date;
    _departureController.text = reselInfo.from;
    _destinationController.text = reselInfo.destination;

    print(reselInfo);
  }

  String? _dropValue;
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _numPeopleController = TextEditingController();
  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    _numPeopleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("예약 정보확인"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                childAspectRatio: 3.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: <Widget>[
                  TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _numPeopleController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: '인원수',
                      hintText: '1~10 또는 10인초과',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _departureController,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: _destinationController,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "운송수단 선택 : ",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<String>(
                  value: _dropValue,
                  icon: const Icon(Icons.car_rental),
                  onChanged: (String? value) {
                    setState(() {
                      _dropValue = value;
                    });
                  },
                  items: <String>['승용차', '승합차', '리무진']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(height: 800),
            )
          ],
        ),
      ),
    );
  }
}
