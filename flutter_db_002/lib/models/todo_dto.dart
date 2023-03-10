class TodoDto {
  final int id;
  final String content;
  final String sdate;
  final String edate;
  final String stime;
  final String etime;

// TodoDto 생성자 method
  const TodoDto({
    this.id = 0,
    required this.content,
    required this.sdate,
    this.edate = "",
    required this.stime,
    this.etime = "",
  });
  // Dto 객체에 담긴 데이터를 insert 할 때 Map 으로 변환 시키기 위한 함수
  Map<String, dynamic> toMap() {
    return {
      content: content,
      sdate: sdate,
      stime: stime,
    };
  }
}
