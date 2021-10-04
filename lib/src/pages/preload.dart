import 'package:financas_app/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPage createState() => _PreloadPage();
}

class _PreloadPage extends State<PreloadPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Finanças App',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Image.asset(
            "lib/assets/Logo.png",
            width: 200,
          ),
          loading
              ? Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    'Carregando Informações...',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              : Container(),
          loading
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                )
              : Container(),
          !loading
              ? Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                    child: Text('Entrar'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomePageScreen()));
                    },
                  ))
              : Container(),
        ],
      )),
    );
  }
}
