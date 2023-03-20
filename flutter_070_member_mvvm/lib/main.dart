import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_member/firebase_join.dart';
import 'package:flutter_member/firebase_login.dart';
import 'package:flutter_member/provider/email_login_provider.dart';
import 'package:flutter_member/provider/google_login_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Member",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Member"),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => GoogleLoginViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => EmailLoginViewModel(),
          )
        ],
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(context),
        ),
      ),
    );
  } // end build

  _buildBody(BuildContext context) {
    var googleViewModel = context.watch<GoogleLoginViewModel>();
    var emailViewModel = context.watch<EmailLoginViewModel>();
    final GoogleSignInAccount? user = googleViewModel.currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: GoogleUserCircleAvatar(identity: user),
            // 변수 ?? 값 : 변수 값이 null 이면 값을 return
            // user.displayName != null ? user.displayName : ""
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          ElevatedButton(
            onPressed: googleViewModel.handleSignout,
            child: const Text("로그아웃"),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          emailViewModel.authUser == null
              ? const Text(
                  "로그인",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                )
              : const Text(
                  "사용자",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
          Container(
            margin: const EdgeInsets.all(10),
            child: emailViewModel.authUser != null
                ? Column(
                    children: [
                      emailViewModel.authUser!.emailVerified
                          ? Text("userName : ${emailViewModel.authUser!.email}")
                          : const Text("이메일 인증 되어있지 않음"),
                      ElevatedButton(
                        onPressed: emailViewModel.logout,
                        child: const Text("로그아웃"),
                      )
                    ],
                  )
                : Column(
                    children: [
                      // 파사드 패턴, 끌어올리기 패턴
                      Loginpage(loginSubmit: emailViewModel.loginSubmit),
                      loginButton(googleViewModel),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JoinPage(),
                            ),
                          );
                        },
                        child: const Text("이메일 회원가입",
                            style: TextStyle(color: Colors.blue, fontSize: 16)),
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            height: 20,
          ),

          /**
           * Flexible
           * 내부에 있는 widget 이 화면을 벗어나려고 할 때,
           * fit 속성을 Flexible.tight 로 설정하면
           * 화면 범위내에서 화면에 남은 영역만 차지하도록
           * 내부 화면 범위를 제한
           */
          const Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      );
    }
  }

  GestureDetector loginButton(GoogleLoginViewModel googleViewModel) {
    return GestureDetector(
      onTap: googleViewModel.handleSignin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF4285F4),
                ),
              ),
              width: 35,
              height: 35,
              child: Image.asset(
                "images/btn_google.png",
              )),
          Container(
            color: const Color(0xFF4285F4),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "구글로그인",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
