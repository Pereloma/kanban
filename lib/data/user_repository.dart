import 'package:equatable/equatable.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
          //() => _user = User(const Uuid().v4()),
    );
  }
}

class User extends Equatable {
  const User(this.token);

  final String token;

  @override
  List<Object> get props => [token];

  static const empty = User('-');
}