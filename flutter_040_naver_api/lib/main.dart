import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_naver/config/naver_api.dart';
import 'package:flutter_naver/model/naver_movie.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naver 영화 API',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
   *  resultMovie 는 변수 선언이지만
   * 실질적으로 함수로서 기능
   * 
   * FutureBuilder 의 future 속성에 변수를 설정하고
   * FutureBuilder 가 화면에 rendering 을 하기전에
   * resultMovie 변수를 참조(이 때는 함수처럼 작동)
   * 변수를 참조하지만 NaverApi().loadMovie() 함수를 실행하는 것과 같다
   */
  Future<List<Movie>?> resultMovie = NaverApi().loadMovie();
  // input box 를 핸들링하기위한 referense ID 선언
  final TextEditingController searchController = TextEditingController();

  void searchHandler(search) {
    Future<List<Movie>?> searchMovie = NaverApi().loadMovie(search);
    resultMovie = searchMovie;
    setState(() {});
  }

  // 생명주기 함수 : state 객체가 생성될 때 단 한번 실행되는 함수
  @override
  void initState() {
    super.initState();
  }

  // 생명주기 함수 중에 가장 마지막에 실행되는 함수
  // widget 이 사라질 때
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: searchInputBox(),
      ),
      /**
       * FutureBuilder 의 작동 원리
       * 1. Future 속성에 설정된 함수(변수)를 실행해 데이터를 가져오기
       * 2. 가져온 데이터는 builder 속성의 callback 함수에 
       *      snapshot 매개변수로 전달한다
       * 3. ListView.builder 에게 데이터를 전달한다
       * 4. ListView.builder 는 snapshot.data 에 담긴 데이터(보통 Listdata) 를 
       *      화면에 rendering 한다
       * 5. ListView.builder 는 itemBuilder 속성에 설정된 callback 함수를
       *      사용해 개별적인 데이터를 화면에 rendering
       * 6. ListView.builder 는 2개의 속성을 갖는다
       *      ItemCount : 몇개의 데이터를 rendering 할 것인지 정함
       *        FutureBuilder 에게서 몇개의 데이터가 있는지 통보 받고
       *        실제 화면에 그릴 수 있는 데이터가 몇개인가 분석해
       *        다시 FutureBuilder 에게 통보해 데이터를 그릴 수 있는 
       *        개수만큼만 가져오도록 알려준다.
       *      ItemBuilder : 각 데이터를 rendering 하는 코드가
       *        작성된다.
       */
      body: FutureBuilder(
        future: resultMovie,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              Movie movie = snapshot.data![index];
              return movieItemView(movie);
            },
          );
        },
      ),
    );
  }

  Padding movieItemView(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          highlightColor: Colors.redAccent.withOpacity(0.5),
          splashColor: Colors.amberAccent.withOpacity(0.5),
          onLongPress: () {
            launchUrl(Uri.parse(movie.link));
          },
          child: ListTile(
            leading: movie.image.isNotEmpty
                ? Image.network(movie.image)
                : Image.asset("images/no_image.png"),
            title: Html(
              data: movie.title,
              style: {
                "*": Style(
                  fontSize: const FontSize(24),
                  textOverflow: TextOverflow.ellipsis,
                ),
                "b": Style(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              },
            ),
            subtitle: Text(movie.subtitle),
          ),
        ),
      ),
    );
  }

  TextFormField searchInputBox() {
    return TextFormField(
      //TextFormField 를 핸들링 하기 위한 ref id 설정
      controller: searchController,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          prefixIcon: const Icon(
            Icons.movie_edit,
            color: Colors.white,
            size: 30,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.clear,
              size: 25,
            ),
            onPressed: () {
              searchController.clear();
            },
          ),
          hintText: "검색할 영화명...",
          hintStyle: const TextStyle(color: Colors.grey)),
      onFieldSubmitted: searchHandler,
      // onChanged: searchHandler,
    );
  }
}
