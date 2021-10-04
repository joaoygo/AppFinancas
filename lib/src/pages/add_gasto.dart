import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:financas_app/src/models/categorias.dart';
import 'package:financas_app/src/models/gastos.dart';
import 'package:financas_app/src/pages/add_categoria.dart';
import 'package:financas_app/src/pages/home.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddOrUpdateGasto extends StatefulWidget {
  bool isEdit;
  int position = -1;
  Gastos? gastoModel = null;

  AddOrUpdateGasto(this.isEdit, this.position, this.gastoModel);

  @override
  State<StatefulWidget> createState() {
    return AddOrUpdateGastoState();
  }
}

class AddOrUpdateGastoState extends State<AddOrUpdateGasto> {
  String? valueChoose;
  var maskValue = MaskTextInputFormatter(mask: '##,##');
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

  TextEditingController controllerValor = new TextEditingController();
  TextEditingController controllerDescricao = new TextEditingController();
  TextEditingController controllerCategoria = new TextEditingController();
  TextEditingController controllerData = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      controllerValor.text = widget.gastoModel!.valor;
      controllerDescricao.text = widget.gastoModel!.descricao;
      controllerCategoria.text = widget.gastoModel!.categoria;
      controllerData.text = widget.gastoModel!.data;
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text('Add/Edit Gastos')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Valor:", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 20),
                  Expanded(
                      child: TextField(
                    inputFormatters: [maskValue],
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: controllerValor,
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
                    textInputAction: TextInputAction.next,
                  ))
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Categoria:", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 20),
                  DropdownButton<String>(
                    value: valueChoose,
                    onChanged: (newValue) {
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: listCategorias
                        .map(
                          (valueItem) => DropdownMenuItem(
                            value: valueItem.nome,
                            child: Text(valueItem.nome),
                          ),
                        )
                        .toList(),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    AddOrUpdateCategoria(false, -1, null)));
                      },
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
                    var getValor = controllerValor.text;
                    var getDescricao = controllerDescricao.text;
                    var getCategoria = valueChoose;
                    DateTime data = DateTime.now();
                    if (getValor.isNotEmpty &&
                        getDescricao.isNotEmpty &&
                        getCategoria!.isNotEmpty) {
                      Gastos gastoData = new Gastos(
                          valor: getValor,
                          descricao: getDescricao,
                          categoria: getCategoria,
                          data: formatDate(data, [mm, '/', yyyy]).toString());

                      if (widget.isEdit) {
                        var box = await Hive.openBox<Gastos>('gasto');
                        box.putAt(widget.position, gastoData);
                      } else {
                        var box = await Hive.openBox<Gastos>('gasto');
                        box.add(gastoData);
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomePageScreen()),
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
