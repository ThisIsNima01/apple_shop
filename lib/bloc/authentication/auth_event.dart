abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  String username;
  String password;
  AuthLoginEvent(this.username, this.password);
}

class AuthRegisterEvent extends AuthEvent {
  String username;
  String password;
  String passwordConfirm;
  AuthRegisterEvent(this.username, this.password, this.passwordConfirm);
}
