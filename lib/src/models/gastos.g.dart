// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gastos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GastoAdapter extends TypeAdapter<Gastos> {
  @override
  final int typeId = 1;

  @override
  Gastos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gastos(
      valor: fields[0] as String,
      descricao: fields[1] as String,
      categoria: fields[2] as String,
      data: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Gastos obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.valor)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.categoria)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GastoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
