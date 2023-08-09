// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotiInfoAdapter extends TypeAdapter<NotiInfo> {
  @override
  final int typeId = 0;

  @override
  NotiInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotiInfo(
      master: fields[2] as String,
      notiMoment: fields[0] as DateTime,
      memo: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotiInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.notiMoment)
      ..writeByte(1)
      ..write(obj.memo)
      ..writeByte(2)
      ..write(obj.master);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotiInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
