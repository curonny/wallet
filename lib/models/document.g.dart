// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocumentAdapter extends TypeAdapter<Document> {
  @override
  final int typeId = 1;

  @override
  Document read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Document(
      nombre: fields[0] as String?,
      imageFront: fields[1] as String?,
      imageBack: fields[2] as String?,
      categorie: fields[3] as String?,
      date: fields[4] as String?,
      favorite: fields[5] == null ? '0' : fields[5] as String?,
      archived: fields[6] == null ? '0' : fields[6] as String?,
      notaImg1: fields[7] == null ? '' : fields[7] as String?,
      notaImg2: fields[8] == null ? '' : fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Document obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.imageFront)
      ..writeByte(2)
      ..write(obj.imageBack)
      ..writeByte(3)
      ..write(obj.categorie)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.favorite)
      ..writeByte(6)
      ..write(obj.archived)
      ..writeByte(7)
      ..write(obj.notaImg1)
      ..writeByte(8)
      ..write(obj.notaImg2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
