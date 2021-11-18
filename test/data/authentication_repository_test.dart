import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban/data/authentication_repository.dart';

void main() {
  test("login test", () async{
    Map res =await AuthenticationRepository().logIn(username: "armada", password: "FSH6zBZ0p9yH");
    if(res.containsKey()) {
      return true;
    } else {
      return false;
    }
  });

}