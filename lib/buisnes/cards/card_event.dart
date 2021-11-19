part of 'card_bloc.dart';

@immutable
class CardEvent extends Equatable{
  const CardEvent(this.rowCards);

  final RowCardsStatus rowCards;

  @override
  List<Object> get props => [rowCards];

}
