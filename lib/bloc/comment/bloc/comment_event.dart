part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class CommentInitialEvent extends CommentEvent {
  final String productId;

  CommentInitialEvent(this.productId);
}
