import 'package:hive/hive.dart';

part 'gastos.g.dart';

@HiveType(typeId: 1, adapterName: "GastoAdapter")
class Gastos {
  @HiveField(0)
  String valor;

  @HiveField(1)
  String descricao;

  @HiveField(2)
  String categoria;

  @HiveField(3)
  String data;

  Gastos(
      {required this.valor,
      required this.descricao,
      required this.categoria,
      required this.data});
}
