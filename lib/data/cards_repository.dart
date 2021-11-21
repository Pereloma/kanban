import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:kanban/data/user_repository.dart';
import 'package:kanban/models/card.dart';


class CardsRepository  {

  final Future<Box<List<KCard>>> _box =Hive.openBox<List<KCard>>('Cards');
  final _dio = Dio();


  Future<List<KCard>> getCards(RowCardsStatus rowCardsStatus) async {
      String authorization = "JWT ${(await UserRepository.getUser())!.token}";
      Response<List> res = await _dio.get(
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
      final cards = res.data!.map((json) => KCard.fromJson(json)).toList();
      (await _box).put(rowCardsStatus.index,cards);
      return cards;
  }

  Future<List<KCard>> hiveGetCards(RowCardsStatus rowCardsStatus) async {
    return (await _box).get(rowCardsStatus.index)??[];
  }


}