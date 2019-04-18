class CarouselImage {
  String url;
  int id;


  CarouselImage({this.url, this.id});

  factory CarouselImage.fromJsonMap(Map<String, dynamic> map) {
    return CarouselImage(url: map['url'] as String, id: map['id'] as int);
  }

  set imageId(int newId) {
    this.id = newId;
  }

  set imageUrl(String newUrl) {
    this.url = newUrl;
  }

  int get imageId => id;

  String get imageUrl => url;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['url'] = url;
    map['id'] = id;

    return map;
  }
}
