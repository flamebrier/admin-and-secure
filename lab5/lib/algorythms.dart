import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final String alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";

Stream<String> reshuffleEncrypt (
    String text,
    {
      @required String key,
    }
    ) async* {
  key = key.trim().toLowerCase();
  text = text.toLowerCase();
  if (key == "") {
    yield text;
  }

  List<int> sorted = key.codeUnits.toList()..sort();
  List<int> arrange = List<int>();
  List<String> table = List<String>();

  int tmp;
  for (var a in key.codeUnits) {
    arrange.add(tmp = sorted.indexOf(a));
    table.add("");
    sorted.removeAt(tmp);
    sorted.insert(tmp, -1);
  }

  int m = arrange.length;
  for (int i = 0, letters = 0, a; i < text.length; i++, letters++) {
    a = letters % m;
    if (alphabet.indexOf(text[i]) >= 0) {
      table[a] += text[i];
    } else {
      letters--; // для лучшего шифрования учитываем только буквы
    }
  }

  for (int i = 0; i < m; i++) {
    yield table[arrange.indexOf(i)];
  }
}

Stream<String> reshuffleDecrypt (
    String text,
    {
      @required String key,
    }
    ) async* {
  key = key.trim().toLowerCase();
  text = text.toLowerCase();
  if (key == "") {
    yield text;
  }

  List<int> sorted = key.codeUnits.toList()..sort();
  List<int> arrange = List<int>();
  List<String> table = List<String>();

  int tmp;
  for (var a in key.codeUnits) {
    arrange.add(tmp = sorted.indexOf(a));
    table.add(""); // инициализация таблицы
    sorted.removeAt(tmp);
    sorted.insert(tmp, -1);
  }

  int m = arrange.length;
  int l = 0;
  for (int a = 0; a < m; a++) {
    tmp = arrange.indexOf(a); // номер заполняемого столбца
    for (int i = 0;
    i < ((text.length/m).truncate() + ((tmp < (text.length % m) ? 1 : 0)));
    i++, l++) {
      table[tmp] += text[l];
    }
  }


  l = 0;
  tmp = 0; // номер буквы в столбце
  while (l < text.length) {
    for (var i = 0; i < table.length && l < text.length; i++, l++) {
      yield table[i][tmp];
    }
    tmp++;
  }
}