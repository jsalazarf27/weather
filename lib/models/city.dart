class City {
  String? name;
  String? country;

  City({this.name, this.country});

  City.fromJson(Map<String, dynamic> json) {
    name = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = name;
    data['country'] = country;
    return data;
  }
}
