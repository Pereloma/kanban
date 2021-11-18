import 'dart:async';

import 'package:dio/dio.dart';
import 'package:kanban/data/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _dio = Dio();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    Response<Map<String,dynamic>> res = await _dio.post(
      "https://trello.backend.tests.nekidaem.ru/api/v1/users/login/",
      data: FormData.fromMap({
        "username": username,
        "password": password
      }),
      options: Options(responseType: ResponseType.json,
      )
    );
    if(res.data != null && res.data!.containsKey('token')){
      UserRepository.setUser(res.data!['token'].toString());
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}