part of 'card_bloc.dart';

@immutable
class CardState extends Equatable{
  RowCardsStatus rowCardsStatus;
  List<KCard> cardList;

  @override
  List<Object?> get props => throw UnimplementedError();
}
