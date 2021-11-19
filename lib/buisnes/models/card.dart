import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kanban/data/cards_repository.dart';

@immutable
class KCard extends Equatable{
  final int id;
  final RowCardsStatus row;
  final int seqNum;
  final String text;

  KCard({required this.id, required String row, required this.seqNum, required this.text}) :
    row = RowCardsStatus.values[int.parse(row)];


  @override
  List<Object?> get props => [id,row,seqNum,text];


}
