part of 'card_bloc.dart';

class CardState extends Equatable{
  // final List<KCard>? cardList;
  // final bool isLoad;
  final List<KCard>? cardList;
  final Map<RowCardsStatus,bool> isLoad;


  CardState({required this.cardList, required RowCardsStatus load}):
        isLoad = {
          RowCardsStatus.onHold : load != RowCardsStatus.onHold,
          RowCardsStatus.inProgress : load != RowCardsStatus.inProgress,
          RowCardsStatus.needsReview : load != RowCardsStatus.needsReview,
          RowCardsStatus.approved : load != RowCardsStatus.approved,
        };

  CardState.load():
        isLoad = {
          RowCardsStatus.onHold : true,
          RowCardsStatus.inProgress : true,
          RowCardsStatus.needsReview : true,
          RowCardsStatus.approved : true,
        },
        cardList = null;

  @override
  List<Object?> get props => [cardList];
}
