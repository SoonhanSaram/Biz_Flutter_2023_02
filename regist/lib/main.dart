import 'package:flutter/material.dart';

void main() {
  runApp(const Regist());
}

class Regist extends StatelessWidget {
  const Regist({super.key});
  final String imageLogo = 'assets/images/movv.png';
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Register Practice',
      home: RegisterScreen(),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      elevation: 2,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      child: const Icon(Icons.add),
    );
  }

  Center iconButton() {
    return Center(
      child: ElevatedButton(
        style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          minimumSize: MaterialStatePropertyAll(
            Size(200, 200),
          ),
        ),
        onPressed: () {},
        child: const Icon(
          Icons.add_reaction_sharp,
          size: 200,
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Practice'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2186D1),
            borderRadius: BorderRadius.circular(16.0), // Container의 모서리를 둥글게 설정
          ),
          height: 200,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '가입하러 가기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              registButton(),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton registButton() {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white)),
      onPressed: () {
        _registerUser();
      },
      child: const Text(
        '가입',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }

  void _registerUser() {
    // 가입 버튼을 눌렀을 때 호출되는 메소드입니다.
  }
}
