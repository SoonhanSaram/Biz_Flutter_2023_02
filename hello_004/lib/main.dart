import 'package:flutter/material.dart';
import 'package:hello_004/widget/balance_widget.dart';
import 'package:hello_004/widget/cbutton.dart';
import 'package:hello_004/widget/custom_widget.dart';
import 'package:hello_004/widget/wallet_card.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff181818),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 80,
                  ),
                  const CustomWidget(),
                  const SizedBox(
                    height: 100,
                  ),
                  const BalanceWidget(),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CButton(
                        text: "송금하기",
                        bgColor: Colors.amber,
                        textColor: Colors.black,
                      ),
                      CButton(
                        text: "가져오기",
                        bgColor: Color(0xff1f2123),
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const WalletCard(
                    currencyname: "EURO",
                    icon: Icons.euro_outlined,
                    amount: "1543144.40",
                    isInverted: false,
                  ),
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: const WalletCard(
                      currencyname: "BTC",
                      icon: Icons.currency_bitcoin_outlined,
                      amount: "50.88bit",
                      isInverted: true,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -40),
                    child: const WalletCard(
                      currencyname: "USD",
                      icon: Icons.attach_money_outlined,
                      amount: "1080201.08",
                      isInverted: false,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
