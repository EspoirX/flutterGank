class CategoryWow {
  String id;
  String title;

  CategoryWow(this.id, this.title);

  factory CategoryWow.fromJson(Map<String, dynamic> json) {
    return new CategoryWow(json['id'] as String, json['title'] as String);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'title': this.title,
    };
  }
}
