import 'package:apple_shop/bloc/authentication/auth_event.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/data/repository/authentication_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();
  AuthBloc() : super(AuthInitState()) {
    on<AuthLoginEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response = await _repository.login(event.username, event.password);
        emit(AuthResponseState(response));
      },
    );

     on<AuthRegisterEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response = await _repository.register(event.username, event.password,event.passwordConfirm);
        emit(AuthResponseState(response));
      },
    );
  }
}
