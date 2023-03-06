# flutter Navigator

- flutter 의 Navigator 는 하나의 Stack type 의 데이터 구조이다
- 현재 보고 있는 화면은 Navigator Stack 의 최상단에 있는
  context 이다
- 만약 새로운 페이지(화면)을 보고자 하면 Navigator.push() 함수를
  사용해 새로운 페잊비를 stack에 집어 넣는다
- 현재 보고 있는 화면 이전 페이지(화면)으로 돌아가고자 하면
  Navigator.pop() 함수를 사용해 돌아간다
