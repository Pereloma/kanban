import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kanban/data/cards_repository.dart';

part 'card.g.dart';

@immutable
@HiveType(typeId: 0)
class KCard extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final RowCardsStatus row;
  @HiveField(2)
  final int seqNum;
  @HiveField(3)
  final String text;

  KCard.m({required this.id, required String row, required this.seqNum, required this.text}) :
    row = RowCardsStatus.values[int.parse(row)];


  const KCard({required this.id, required this.row, required this.seqNum, required this.text});

  @override
  List<Object?> get props => [id,row,seqNum,text];


}


