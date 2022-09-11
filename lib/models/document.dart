import 'package:hive/hive.dart';
// flutter packages pub run build_runner build
part 'document.g.dart';

// categories = ["document","cards","hotel","plane","event","clinical"]

@HiveType(typeId: 1)
class Document extends HiveObject {
  @HiveField(0)
  String? nombre;
  @HiveField(1)
  String? imageFront;
  @HiveField(2)
  String? imageBack;
  @HiveField(3)
  String? categorie;
  @HiveField(4)
  String? date;

  Document({
    this.nombre,
    this.imageFront,
    this.imageBack,
    this.categorie,
    this.date,
  });
}
