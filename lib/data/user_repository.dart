import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class UserRepository {
  static User? _user;

  static Future<User?> getUser() async {
    if (_user != null) return _user;
  }

  static void setUser(String token){
    _user = User(token);
  }
  static void remuveUser(){
    _user = User.empty;
  }
}

class User extends Equatable{
  const User(this.token);

  final String token;

  @override
  List<Object> get props => [token];

  static const empty = User('-');
}