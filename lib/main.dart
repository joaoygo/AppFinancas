import 'dart:io';

import 'package:financas_app/configs/app_settings.dart';
import 'package:financas_app/src/models/categorias.dart';
import 'package:financas_app/src/models/gastos.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvide;

import 'src/pages/home.dart';
import './src/pages/preload.dart';
import './configs/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvide.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(GastoAdapter());
  Hive.registerAdapter(CategoriaAdapter());
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppSettings())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/preload': (context) => PreloadPage(),
        '/home': (context) => HomePageScreen(),
      },
      initialRoute: '/preload',
    );
  }
}
