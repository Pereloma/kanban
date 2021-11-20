import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban/buisnes/models/card.dart';
import 'package:kanban/data/cards_repository.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc(this._cardsRepository) : super(const CardState([])) {
    on<CardEvent>((event, Emitter<CardState> emit) async {
      emit(CardState.load());
      final cards = await _tryGetCards(event.rowCards);
      return emit(CardState(cards));
    });
  }
  final CardsRepository _cardsRepository;

  Future<List<KCard>> _tryGetCards(RowCardsStatus rowCardsStatus) async {
    try {
      final cards = (await _cardsRepository.getMapCards(rowCardsStatus)).map((e) => KCard(id: e['id'], row: e['row'], seqNum: e['seq_num'], text: e['text']));
      return cards.toList();
    } catch (_) {
      return [];
    }
  }
}
