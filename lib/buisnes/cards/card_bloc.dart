import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban/buisnes/models/card.dart';
import 'package:kanban/data/cards_repository.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<CardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future<Card> _tryGetCards() async {
    try {
      final user = await UserRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
