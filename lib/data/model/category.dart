class Category {
  String? collectionId;
  String? id;
  String? thumbnail;
  String? title;
  String? color;
  String? icon;

  Category(this.collectionId, this.id, this.thumbnail, this.title, this.color,
      this.icon);

  factory Category.fromMapJson(Map<String, dynamic> jsonObject) {
    return Category(
      jsonObject['collectionId'],
      jsonObject['id'],
      // 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      'https://nima-data.pockethost.io/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      jsonObject['title'],
      jsonObject['color'],
      // 'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['icon']}',
      'https://nima-data.pockethost.io/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['icon']}',
    );
  }
}
  