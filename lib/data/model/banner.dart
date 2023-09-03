class BannerCampain {
  String? id;
  String? collectionId;
  String? thumbnail;

  // String? categoryId;
  String? productId;

  BannerCampain(this.id, this.collectionId, this.thumbnail, this.productId);

  factory BannerCampain.fromJson(Map<String, dynamic> jsonObject) {
    return BannerCampain(
      jsonObject['id'],
      jsonObject['collectionId'],
      // 'http://startflutter.ir/api/files/${jsonObject['collectionID']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      'https://nima-data.pockethost.io/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
      // jsonObject['categoryId'],
      jsonObject['productId'],
    );
  }
}
