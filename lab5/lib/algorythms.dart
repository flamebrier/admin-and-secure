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
      letters--;
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
    for (int i = 0; i < text.length/m + ((text.length % m > tmp) ? 1 : 0); i++) {
      table[tmp] += text[l++];
    }
  }

  tmp = 0;
  while (tmp < text.length) {
    for (var i = 0; i < table.length; i++) {
      yield table[i][(tmp/m).truncate() +
          ((tmp - m*((tmp/m).truncate())) > 0 ? 1 : 0)];
      tmp++;
    }
  }
}