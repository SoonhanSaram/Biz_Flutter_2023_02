import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard(
      {super.key,
      required this.currencyname,
      required this.amount,
      required this.icon,
      required this.isInverted});
  final _blackColor = const Color(0xFF1F2123);
  final String currencyname, amount;
  final IconData icon;
  final bool isInverted;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currencyname,
                  style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  amount,
                  style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            Transform.scale(
              scale: 2.2,
              child: Transform.translate(
                offset: const Offset(-5, 0),
                child: Icon(
                  icon,
                  size: 40,
                  color: isInverted ? _blackColor : Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
