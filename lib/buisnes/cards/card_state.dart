part of 'card_bloc.dart';

class CardState extends Equatable{
  final List<KCard>? cardList;
  final bool isLoad;


  const CardState(this.cardList):
        isLoad = false;

  CardState.load():
        isLoad = true, cardList = null;

  @override
  List<Object?> get props => [cardList];
}
