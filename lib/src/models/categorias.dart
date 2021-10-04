import 'package:hive/hive.dart';

part 'categorias.g.dart';

@HiveType(typeId: 2, adapterName: "CategoriaAdapter")
class Categorias {
  @HiveField(3)
  String nome;
  @HiveField(4)
  String descricao;

  Categorias({required this.nome, required this.descricao});
}
