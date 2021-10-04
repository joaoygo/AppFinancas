import 'package:financas_app/src/models/categorias.dart';
import 'package:financas_app/src/pages/add_categoria.dart';
import 'package:financas_app/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CategoriaListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoriaListState();
}

class CategoriaListState extends State<CategoriaListScreen> {
  List<Categorias> listCategorias = [];

  void getCategorias() async {
    final box = await Hive.openBox<Categorias>('categoria');
    setState(() {
      listCategorias = box.values.toList();
    });
  }

  @override
  void initState() {
    getCategorias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categoria'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddOrUpdateCategoria(false, -1, null)));
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: listCategorias.length,
              itemBuilder: (context, position) {
                Categorias getCategorias = listCategorias[position];
                var nome = getCategorias.nome;
                var descricao = getCategorias.descricao;
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
                                "${getCategorias.nome}",
                                style: TextStyle(fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Descrição: ${getCategorias.descricao}",
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
                                                AddOrUpdateCategoria(true,
                                                    position, getCategorias)));
                                  }),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  final box = Hive.box<Categorias>('categoria');
                                  box.deleteAt(position);
                                  setState(() {
                                    listCategorias.removeAt(position);
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
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
