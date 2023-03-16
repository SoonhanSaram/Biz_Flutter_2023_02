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
