import 'dart:async';

import 'package:dio/dio.dart';
import 'package:kanban/buisnes/models/card.dart';
import 'package:kanban/data/user_repository.dart';

enum RowCardsStatus { onHold , inProgress, needsReview, approved }

class CardsRepository {
  final _dio = Dio();


  Future<List<Map<String,dynamic>>> logIn(RowCardsStatus rowCardsStatus) async {
    String authorization = "JWT ${(await UserRepository.getUser())!.token}";
    Response<List<Map<String,dynamic>>> res = await _dio.get(
      "https://trello.backend.tests.nekidaem.ru/api/v1/cards/",
      queryParameters: {
        "row": "${rowCardsStatus.index}"
      },
      options:Options(
        responseType: ResponseType.json,
        headers: {
          'Authorization' : authorization
        },
      ),
    );
    return res.data??[];
  }



}