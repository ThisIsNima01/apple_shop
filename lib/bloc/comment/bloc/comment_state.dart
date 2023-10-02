part of 'comment_bloc.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  final Either<String, List<Comment>> comments;

  CommentResponseState(this.comments);
}
