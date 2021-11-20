import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kanban/buisnes/models/card.dart';
import 'package:kanban/data/cards_repository.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc(this._cardsRepository) : super(CardState.load()) {
    on<CardEvent>((event, Emitter<CardState> emit) async {
      emit(CardState.load());
      final cards = await _tryGetCards(event.rowCards);
      return emit(CardState(cardList: cards,load: event.rowCards));
    });
  }
  final CardsRepository _cardsRepository;

  Future<List<KCard>> _tryGetCards(RowCardsStatus rowCardsStatus) async {

    Box<List<KCard>> box = await Hive.openBox<List<KCard>>('Cards');
    try {
      final cards = (await _cardsRepository.getMapCards(rowCardsStatus)).map((e) => KCard.m(id: e['id'], row: e['row'], seqNum: e['seq_num'], text: e['text'])).toList();
      box.put(rowCardsStatus.index,cards);
      return cards;
    } catch (_) {
      return box.get(rowCardsStatus.index)??[];
    }
  }
}
