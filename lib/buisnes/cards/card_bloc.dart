import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kanban/data/cards_repository.dart';
import 'package:kanban/models/card.dart';
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
    try {
      return await _cardsRepository.getCards(rowCardsStatus);
    } catch (_) {
      return _cardsRepository.hiveGetCards(rowCardsStatus);
    }
  }
}
