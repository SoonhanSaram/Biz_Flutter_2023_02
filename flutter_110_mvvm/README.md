# flutter_110_mvvm

- flutter 를 이용한 MVVM 패턴 연습
- flutter 에서는 선언형 프로그래밍을 한다
- state 라는 개념을 사용해 변수가 변동되면 화면이 rendering 되는
  프로그래밍을 한다
- 이 때, state 라는 변수 값을 변경하고, 화면을 rendering 하기 위해
  `Stateful` 라는 클래스와 `state` 라는 클래스를 상속받은 구조의 Widget 을 만들고 이 위젯에 state
  변수를 표현하는 부분을 포함하고, 어디선가 `setState()` 함수를 실행하면, 변화가 있는 state
  변수를 자동감지하여 화면을 다시 rendering 하는 구조
- flutter 에서 선언현 프로그래밍을 하기 위해서는 `StateFul` 과 `state` 클래스가 반드시 필요
- 이 구조는 명령형 프로그래밍과 선언형 프로그래밍의 구분을 혼란스럽게 하는 구조가 된다
- flutter 에서는 선언형 MVVM 패턴을 구현하기 위해 BLoC(business Logic Components) 라는 패턴을 도입
  MVVM 구현하는 방법을 제안, 기존의 프로젝트를 BLoC 로 구현하는 데는 많은 코드의 Refactoring 이 필요
- 3rd party 그룹에서 Provider 라는 Dependecies 를 2019년에 발표하고, flutter 공식 인증 받아
  최근에는 Provider 를 사용한 MVVM 패턴의 코드를 작성
- `flutter pub add provider` 설치

## flutter provider 를 사용한 MVVM 패턴

- `StateFul`, `State` 클래스가 없어 된다
- `StateLess` 클래스만으로 프로젝트가 가능
- flutter 에서 권장하는 기본 class diagram 은 `main()` -> `Stateless` -> `StateFul` -> `State` 구조
- 일부 개발자는 중간의 `Stateless` 를 생략해 버리는 경우도 있다. 하지만 퍼포먼스 문제로
  모든 클래스를 `StateFul` 과 `State` 구조로만 만드는 것은 비효율적이며 메모리 누수 확률이 높아진다
- provider 를 활용한 MVVM 패턴의 구조는 모든 곳에서 `StateFul` 과 `State` 를 사용하지 않아도 된다

## provider 등록하기

- 여러개의 provider 등록하기
- ChangeNotifier 클래스를 mixin 한 클래스를 등록한다

```dart
runApp(
    MultiProvider(
      providers: [
        // viewModel 클래스를 provider 로 등록하는 절차
        ChangeNotifierProvider(
          create: (_) => CounterViewModel(),
        ),
      ],
    ),
  );
```

- 한 개의 provider 등록

```dart
runApp(
    // viewModel 클래스를 provider 로 등록하는 절차
    ChangeNotifierProvider(
      create: (_) => CounterViewModel(),
    ),
  );
```

## viewModel 클래스를 만들고 ChangeNotifierProvider 에 등록하는 이유

- ChangeNotifierProvier 에 viewModel 클래스를 등록하면 App의 `context` 에 viewModel
  클래스의 객체가 등록된다.
- `context.watch<viewModel>()`, `context.read<viewModel>()`, `context.select<viewModel>()`
  를 사용해 viewModel 을 어디에서든지 사용할 수 있다.
- 단, 이 땐, Widget 의 `build()` method 내에서만 가능하다.
- `provider` 구형 모델에서는 `Provider.of<viewModel>(context, listen:false)` 와
  `select<viewModel>(context)` 같은 함수를 사용했다.

## viewModel 를 참조하는 함수

### context.watch<ViewModel>()

- ViewModel 클래스를 객체로 생성해 참조 할 수 있도록 만드는 함수

```dart
var viewModel = context.watch<ViewModel>();
Text(viewModel.속성변수), // 화면에 그릴 수 있다.
viewModel.맴버함수()

var readOnlyViewModel = context.read<ViewModel>();
Text(readOnlyViewModel.속성변수);
readOnlyViewModel.멤버함수();
```

- `context.watch` 는 화면에 rendering 을 일으키는 viewModel
- `context.read` 는 화면에 rendering 을 일으키지 않는 이벤트 함수용이다

## context.select<viewModel, returnType>( callback )

- viewModel 의 요소들을 개별적으로 추출
- `context.watch` 나 `context.read` 는 viewModel 클래스에 담긴 모든 변수, 함수를 통째로 가져와서
  사용할 준비를 한다
- `context.select` 는 개별적인 요소들을 별도로 추출해 메모리 낭비를 줄일 수 있다.

```dart
var counter = context.select<CounterViewModel, int>(v=>v.counter); //변수
var increment = context.select<CounterViewModel, Function()>(v=>v.increment); //함수
```
