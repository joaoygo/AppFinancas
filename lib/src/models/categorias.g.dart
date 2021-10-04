// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorias.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriaAdapter extends TypeAdapter<Categorias> {
  @override
  final int typeId = 2;

  @override
  Categorias read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categorias(
      nome: fields[3] as String,
      descricao: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Categorias obj) {
    writer
      ..writeByte(2)
      ..writeByte(3)
      ..write(obj.nome)
      ..writeByte(4)
      ..write(obj.descricao);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
