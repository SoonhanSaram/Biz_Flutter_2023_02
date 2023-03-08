import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Member",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// google 로그인을 수행하기 위한 초기화 함수
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _HomePageState extends State<HomePage> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    /**
     * google login 이 되면 google 로부터 event가 전달되고
     * event를 기다리다가 user 정보가 오면 _currentUser 에
     * GoogleSignInAccount 타입의 google login 정보를 저장
     */
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    }); // end SignIn
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Member"),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  } // end build

  _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
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
            onPressed: () async {
              await _googleSignIn.signOut();
            },
            child: const Text("로그아웃"),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "로그인",
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          loginForm(),
          const SizedBox(
            height: 20,
          ),
          loginButton(),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text("회원가입",
                style: TextStyle(color: Colors.blue, fontSize: 16)),
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
                onChanged: (value) {},
                labelText: "이메일"),
            const SizedBox(
              height: 20,
            ),
            inputBox(
                keyboardType: TextInputType.visiblePassword,
                errorMsg: "비밀번호를 입력해주세요",
                onChanged: (value) {},
                labelText: "비밀번호",
                obscureText: true)
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

  GestureDetector loginButton() {
    return GestureDetector(
      onTap: () async {
        try {
          await _googleSignIn.signIn();
        } catch (e) {
          print(e);
        }
      },
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
