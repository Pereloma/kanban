part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.nonField,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final String? nonField;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    String? nonField,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      nonField: nonField,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
