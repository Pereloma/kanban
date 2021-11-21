import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:kanban/models/user.dart';

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

