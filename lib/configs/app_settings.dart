import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppSettings extends ChangeNotifier {
  late Box box;
  Map<String, String> locale = {
    'valor': '0',
    'descricao': 'Nenhuma',
    'categoria': 'Nenhuma',
  };

  AppSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    box = await await Hive.openBox('preferencias');
  }

  _readLocale() {
    final valor = box.get('valor') ?? '0';
    final descricao = box.get('descricao') ?? 'nenhum';
    final categoria = box.get('categoria') ?? 'nenhum';

    locale = {
      'valor': valor,
      'descricao': descricao,
      'categoria': categoria,
    };
    notifyListeners();
  }

  setLocale(String valor, String descricao, String categoria) async {
    await box.put('valor', valor);
    await box.put('descricao', descricao);
    await box.put('categoria', categoria);
    await _readLocale();
  }
}
