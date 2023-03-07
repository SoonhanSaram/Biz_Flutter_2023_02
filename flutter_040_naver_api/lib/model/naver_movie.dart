class Movie {
  Movie({
    required this.title,
    required this.link,
    required this.image,
    required this.subtitle,
    required this.pubDate,
    required this.director,
    required this.actor,
    required this.userRating,
  });

  final String title;
  final String link;
  final String image;
  final String subtitle;
  final String pubDate;
  final String director;
  final String actor;
  final String userRating;

  // openAPI 를 통해서 가져온 데이터를
  // Movie 객체 type 으로 변환하는 함수
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      link: json['link'],
      image: json['image'],
      subtitle: json['subtitle'],
      pubDate: json['pubDate'],
      director: json['director'],
      actor: json['actor'],
      userRating: json['userRating'],
    );
  }
}
