class Comment {
  String id;
  String text;
  String productId;
  String userId;
  String userAvatarUrl;
  String username;
  String avatar;

  Comment(this.id, this.text, this.productId, this.userId, this.userAvatarUrl,
      this.username, this.avatar);

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        productId = json['product_id'],
        userId = json['user_id'],
        userAvatarUrl =
            'http://startflutter.ir/api/files/${json['expand']['user_id']['collectionName']}/${json['expand']['user_id']['id']}/${json['expand']['user_id']['avatar']}',
        username = json['expand']['user_id']['name'],
        avatar = json['expand']['user_id']['avatar'];
}
