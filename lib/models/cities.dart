class Cities {
  String? name;
  String? country;

  Cities({this.name, this.country});

  Cities.fromJson(Map<String, dynamic> json) {
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
