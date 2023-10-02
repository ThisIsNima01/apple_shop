class Comment {
  String id;
  String text;
  String productId;
  String userId;

  Comment(this.id, this.text, this.productId, this.userId);

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        productId = json['product_id'],
        userId = json['user_id'];
}
