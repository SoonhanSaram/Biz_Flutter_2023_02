import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({
    super.key,
    required Future<void> Function(
            {required dynamic email, required dynamic password})
        this.loginSubmit,
  });
  final Function loginSubmit;
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String _userEmail = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return loginForm();
  }

  Form loginForm() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Image(
              width: 200,
              height: 150,
              image: AssetImage("images/user.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            inputBox(
                keyboardType: TextInputType.emailAddress,
                errorMsg: "이메일을 입력해주세요",
                onChanged: (value) {
                  _userEmail = value;
                  setState(() {});
                },
                labelText: "이메일"),
            const SizedBox(
              height: 20,
            ),
            inputBox(
                keyboardType: TextInputType.visiblePassword,
                errorMsg: "비밀번호를 입력해주세요",
                onChanged: (value) {
                  _password = value;
                  setState(() {});
                },
                labelText: "비밀번호",
                obscureText: true),
            ElevatedButton(
                onPressed: () => widget.loginSubmit(
                      email: _userEmail,
                      password: _password,
                    ),
                child: const Text("이메일로 로그인하기")),
          ],
        ),
      ),
    );
  }

  TextFormField inputBox(
      {keyboardType = TextInputType.text,
      String errorMsg = "값을 입력",
      String labelText = "값을 입력",
      bool obscureText = false,
      Function(dynamic value)? onChanged}) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "이메일을 입력하세요";
        }
        return errorMsg;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: labelText),
    );
  }
}
