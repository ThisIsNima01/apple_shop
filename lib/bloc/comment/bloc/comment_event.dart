part of 'comment_bloc.dart';

abstract class CommentEvent {}

class CommentInitialEvent extends CommentEvent {
  final String productId;

  CommentInitialEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  final String productId;
  final String comment;

  CommentPostEvent(this.productId, this.comment);
}
