part of 'card_bloc.dart';

class CardState extends Equatable{
  final List<KCard> cardList;


  CardState(this.cardList);

  @override
  List<Object?> get props => [cardList];
}
