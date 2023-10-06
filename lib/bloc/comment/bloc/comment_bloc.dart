import 'package:apple_shop/data/model/comment.dart';
import 'package:apple_shop/data/repository/comment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _repository;

  CommentBloc(this._repository) : super(CommentLoadingState()) {
    on<CommentInitialEvent>((event, emit) async {
      final response = await _repository.getComments(event.productId);

      emit(CommentResponseState(response));
    });

    on<CommentPostEvent>(
      (event, emit) async {
        emit(CommentLoadingState());
        await _repository.postComment(event.productId, event.comment);
        final response = await _repository.getComments(event.productId);

        emit(CommentResponseState(response));
      },
    );
  }
}
