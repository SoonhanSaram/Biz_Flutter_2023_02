import 'package:flutter/material.dart';
import 'package:flutter_110_mvvm/ui_model/counter_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // viewModel 클래스를 provider 로 등록하는 절차
    ChangeNotifierProvider(
      create: (_) => CounterViewModel(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // viewModel 가져오기
    // var viewModel = context.watch<CounterViewModel>();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("hello"),
            Text(
              context
                  .select<CounterViewModel, int>((value) => value.counter)
                  .toString(),
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
                onPressed: context.select<CounterViewModel, Function()>(
                    (value) => value.increment),
                child: const Text("증가"))
          ],
        )),
      ),
    );
  }
}
