import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_member/comps/inputbox.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  String _userEmail = "";
  String _password = "";
  Future<UserCredential?> _joinSubmit(BuildContext context) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _userEmail,
        password: _password,
      )
          .then(
        (value) {
          if (value.user!.email != null) {
            Navigator.pop(context);
          }
          return value;
        },
      );
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "weak-password") {
        message = "비밀번호가 취약합니다";
      } else if (e.code == "emaoil-already-in-use") {
        message = "이미 가입된 비밀번호 입니다";
      } else {
        message = "알 수없는 오류 발생";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("회원가입"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      inputBox(
                        onChanged: (value) {
                          _userEmail = value;
                          setState(() {});
                        },
                        labelText: "이메일",
                        errorMsg: "이메일을 입력하세요",
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      inputBox(
                        onChanged: (value) {
                          _password = value;
                          setState(() {});
                        },
                        labelText: "비밀번호",
                        errorMsg: "비밀번호을 입력하세요",
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    // Navigator.pop(context);
                    await _joinSubmit(context);
                  },
                  child: const Text("회원가입"))
            ],
          ),
        ));
  }
}
