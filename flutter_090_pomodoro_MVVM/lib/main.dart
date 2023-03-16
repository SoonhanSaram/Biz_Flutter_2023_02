import 'package:flutter/material.dart';
import 'package:flutter_090_pomodoro/pages/dash_board_page.dart';
import 'package:flutter_090_pomodoro/pages/main_page.dart';
import 'package:flutter_090_pomodoro/ui_model/page_view_model.dart';
import 'package:flutter_090_pomodoro/ui_model/timer_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  /**
   * main() => stateless => statefull => state 이러한 경로를 생략한 경우
   * DataBinding 이 되는 경우
   * main() 함수에 App 초기화 코드들이 있는 경우
   * 이 속성을 추가해 주는 것이 좋다
   */
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PageViewModel(),
        )
      ],
      child: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const homeTitle = "home";
  static const dashBoardTitle = "dashBoard";

  @override
  Widget build(BuildContext context) {
    var pageViewModel = context.watch<PageViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/background.jpg"),
          ),
        ),
        child: Scaffold(
          // Container에 image로 배경을 채우기 위해서 Scaffold의 배경색을 지우기
          backgroundColor: Colors.transparent,
          body: PageView(
            controller: pageViewModel.pageController,
            // page가 전환됐을 때, bottmNav에 표시
            onPageChanged: (pageNum) {
              pageViewModel.pageViewChange(pageNum);
            },
            children: const [
              MainPage(),
              DashBoardPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              pageViewModel.bottomNavTap(value);
            },
            currentIndex: pageViewModel.pageIndex,
            items: const [
              BottomNavigationBarItem(label: homeTitle, icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: dashBoardTitle, icon: Icon(Icons.dashboard)),
            ],
          ),
        ),
      ),
    );
  }
}
