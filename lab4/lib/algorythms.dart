import 'package:flutter/foundation.dart';

final String alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";

Stream<String> vigenerEncrypt (
    String text,
    {
      @required String key,
      int m,
    }
    ) async* {
  key = key.trim().toLowerCase();
  if (key == "") {
    yield text;
  }
  if (m < key.length) {
    key = key.substring(0, m);
  } else {
    m = key.length;
  }

  List<String> sourceAlphabet = [];
  for (var a=0; a < m; a++) {
    sourceAlphabet.add(alphabet.substring(alphabet.indexOf(key[a]))
        + alphabet.substring(0, alphabet.indexOf(key[a])));
  }

  for (int i = 0, letters = 0, tmp; i < text.length; i++, letters++) {
    if ((tmp = alphabet.indexOf(text[i])) >= 0) {
      yield sourceAlphabet[letters % m][tmp];
    } else if ((tmp = alphabet.indexOf(text[i].toLowerCase())) >= 0) {
      yield sourceAlphabet[letters % m][tmp].toUpperCase();
    } else {
      letters--;
      yield text[i];
    }
  }
}

Stream<String> vigenerDecrypt (
    String text,
    {
      @required String key,
      int m,
    }
    ) async* {
  key = key.trim().toLowerCase();
  if (key == "") {
    yield text;
  }
  if (m < key.length) {
    key = key.substring(0, m);
  } else {
    m = key.length;
  }

  List<String> sourceAlphabet = [];
  for (var a=0; a < m; a++) {
    sourceAlphabet.add(alphabet.substring(alphabet.indexOf(key[a]))
        + alphabet.substring(0, alphabet.indexOf(key[a])));
  }

  for (var i = 0, letters = 0, tmp; i < text.length; i++, letters++) {
    if ((tmp = sourceAlphabet[letters % m].indexOf(text[i])) >= 0) {
      yield alphabet[tmp];
    } else if ((tmp = sourceAlphabet[letters % m]
        .indexOf(text[i].toLowerCase())) >= 0) {
      yield alphabet[tmp].toUpperCase();
    } else {
      letters--;
      yield text[i];
    }
  }
}