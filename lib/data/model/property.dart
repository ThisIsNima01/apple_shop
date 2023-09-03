class Property {
  String title;
  String value;

  Property(this.title, this.value);

  factory Property.fromJson(Map<String, dynamic> jsonObject) =>
      Property(jsonObject['title'], jsonObject['value']);
}
