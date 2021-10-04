import 'package:financas_app/src/models/categorias.dart';
import 'package:financas_app/src/pages/list_categorias.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddOrUpdateCategoria extends StatefulWidget {
  bool isEdit;
  int position = -1;
  Categorias? categoriaModel = null;

  AddOrUpdateCategoria(this.isEdit, this.position, this.categoriaModel);

  @override
  State<StatefulWidget> createState() {
    return AddOrUpdateCategoriaState();
  }
}

class AddOrUpdateCategoriaState extends State<AddOrUpdateCategoria> {
  TextEditingController controllerNome = new TextEditingController();
  TextEditingController controllerDescricao = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      controllerNome.text = widget.categoriaModel!.nome;
      controllerDescricao.text = widget.categoriaModel!.descricao;
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text('Add/Edit Categoria')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Nome da Categoria:", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 20),
                  Expanded(
                      child: TextField(
                    controller: controllerNome,
                    textInputAction: TextInputAction.next,
                  ))
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Descrição:", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: controllerDescricao,
                      textInputAction: TextInputAction.done,
                    ),
                  )
                ],
              ),
              SizedBox(height: 100),
              MaterialButton(
                  color: Colors.green,
                  child: Text("Enviar",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () async {
                    var getNome = controllerNome.text;
                    var getDescricao = controllerDescricao.text;

                    if (getNome.isNotEmpty && getDescricao.isNotEmpty) {
                      Categorias categoriaData = new Categorias(
                          nome: getNome, descricao: getDescricao);

                      if (widget.isEdit) {
                        var box = await Hive.openBox<Categorias>('categoria');
                        box.putAt(widget.position, categoriaData);
                      } else {
                        var box = await Hive.openBox<Categorias>('categoria');
                        box.add(categoriaData);
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CategoriaListScreen()),
                          (r) => false);
                    }
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
