import 'package:equatable/equatable.dart';

class UserRepository {
  static User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
  }

  static void setUser(String token){
    _user = User(token);
  }
}

class User extends Equatable {
  const User(this.token);

  final String token;

  @override
  List<Object> get props => [token];

  static const empty = User('-');
}