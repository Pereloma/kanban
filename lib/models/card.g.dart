// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KCardAdapter extends TypeAdapter<KCard> {
  @override
  final int typeId = 0;

  @override
  KCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KCard(
      id: fields[0] as int,
      row: RowCardsStatus.values[fields[1] as int],
      seqNum: fields[2] as int,
      text: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.row.index)
      ..writeByte(2)
      ..write(obj.seqNum)
      ..writeByte(3)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
