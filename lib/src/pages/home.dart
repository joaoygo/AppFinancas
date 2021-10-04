import 'package:date_format/date_format.dart';
import 'package:financas_app/src/models/categorias.dart';
import 'package:financas_app/src/models/gastos.dart';
import 'package:financas_app/src/pages/add_categoria.dart';
import 'package:financas_app/src/pages/list_categorias.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'add_gasto.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePageScreen> {
  List<Gastos> listGastos = [];
  List<Categorias> listCategorias = [];
  List<String> ListType = ['nenhum', 'nome', 'categoria', 'data'];
  String Filter = "nenhum";
  String? Filtro;
  var maskData = MaskTextInputFormatter(mask: '##/####');

  void getCategorias() async {
    final box = await Hive.openBox<Categorias>('categoria');
    setState(() {
      listCategorias = box.values.toList();
    });
  }

  //PEGANDO Lista de Gastos ...
  void getGastos() async {
    final box = await Hive.openBox<Gastos>('gasto');
    setState(() {
      listGastos = box.values.toList();
    });
  }

  @override
  void initState() {
    getGastos();
    super.initState();
    getCategorias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //listGastos.map((e) => teste = teste + double.parse(e.valor));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gastos'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddOrUpdateGasto(false, -1, null)));
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            Row(children: [
              Filter != 'nenhum' && Filter == 'nome'
                  ? Container(
                      width: 200,
                      margin: EdgeInsets.all(20),
                      child: TextField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32))),
                        onChanged: (text) {
                          setState(() {
                            Filtro = text;
                          });
                        },
                      ))
                  : Filter != 'nenhum' && Filter == 'categoria'
                      ? Container(
                          width: 200,
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32))),
                            onChanged: (text) {
                              setState(() {
                                Filtro = text;
                              });
                            },
                          ))
                      : Filter != 'nenhum' && Filter == 'data'
                          ? Container(
                              width: 200,
                              margin: EdgeInsets.all(20),
                              child: TextField(
                                inputFormatters: [maskData],
                                maxLength: 7,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'MM/YYYY',
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                onChanged: (text) {
                                  setState(() {
                                    Filtro = text;
                                  });
                                },
                              ))
                          : Container(child: null),
              Filter == 'nenhum' ? Text('Filtrar por:') : Container(),
              Filter == 'nenhum'
                  ? Container(
                      margin: EdgeInsets.fromLTRB(30, 10, 0, 10),
                      child: DropdownButton(
                        value: Filter,
                        onChanged: (newValue) {
                          setState(() {
                            Filter = newValue.toString();
                          });
                        },
                        items: ListType.map(
                          (valueItem) => DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          ),
                        ).toList(),
                      ),
                    )
                  : Container(
                      child: DropdownButton(
                        value: Filter,
                        onChanged: (newValue) {
                          setState(() {
                            Filter = newValue.toString();
                          });
                        },
                        items: ListType.map(
                          (valueItem) => DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          ),
                        ).toList(),
                      ),
                    ),
            ]),
            Filter != 'nenhum'
                ? Expanded(
                    child: ListView.builder(
                        itemCount: listGastos.length,
                        itemBuilder: (context, position) {
                          Gastos getGastos = listGastos[position];
                          var descricao = getGastos.descricao;
                          var categoria = getGastos.categoria;
                          var data = getGastos.data;
                          var SelectFilter;

                          Filter == 'nome'
                              ? SelectFilter = descricao
                              : Filter == "categoria"
                                  ? SelectFilter = categoria
                                  : Filter == "data"
                                      ? SelectFilter = data
                                      : SelectFilter = 'nenhum';

                          if ((SelectFilter == Filtro &&
                              Filtro != null &&
                              SelectFilter != null &&
                              SelectFilter != "nenhum")) {
                            return Card(
                              elevation: 8,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Nome: ${getGastos.descricao}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Valor: R\$ ${(getGastos.valor).toString()}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Categoria: ${getGastos.categoria}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Data: ${(getGastos.data)}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            AddOrUpdateGasto(
                                                                true,
                                                                position,
                                                                getGastos)));
                                              }),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              final box =
                                                  Hive.box<Gastos>('gasto');
                                              box.deleteAt(position);
                                              setState(() {
                                                listGastos.removeAt(position);
                                              });
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        }))
                : Container(),
            Filter == 'nenhum'
                ? Expanded(
                    child: ListView.builder(
                        itemCount: listGastos.length,
                        itemBuilder: (context, position) {
                          Gastos getGastos = listGastos[position];
                          var descricao = getGastos.descricao;
                          var categoria = getGastos.categoria;
                          var data = getGastos.data;
                          var SelectFilter;

                          Filter == 'nome'
                              ? SelectFilter = descricao
                              : Filter == "categoria"
                                  ? SelectFilter = categoria
                                  : Filter == "data"
                                      ? SelectFilter = data
                                      : SelectFilter = 'nenhum';

                          if (SelectFilter == "nenhum") {
                            return Card(
                              elevation: 8,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Nome: ${getGastos.descricao}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Valor: R\$ ${(getGastos.valor).toString()}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Categoria: ${getGastos.categoria}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Data: ${(getGastos.data)}",
                                            style: TextStyle(fontSize: 18),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            AddOrUpdateGasto(
                                                                true,
                                                                position,
                                                                getGastos)));
                                              }),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              final box =
                                                  Hive.box<Gastos>('gasto');
                                              box.deleteAt(position);
                                              setState(() {
                                                listGastos.removeAt(position);
                                              });
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        }))
                : Container(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Gastos'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePageScreen()),
                      (r) => false);
                },
              ),
              ListTile(
                title: Text('Categoria'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => CategoriaListScreen()),
                      (r) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
