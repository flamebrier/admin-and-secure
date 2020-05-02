import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final String alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";
/*final List<String> alphabet = ['а','б','в','г','д','е','ё','ж','з','и','й','к',
  'л','м', 'н','о','п','р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э',
  'ю','я'];*/
Future<String> vigenerCrypt (
    String text,
    {@required String key}
    ) async {
  String modText = "";
  key.trim();
  if (key == "") {
    return modText;
  }
  List<String> sourceAlphabet = [];
  for (var a=0; a < key.length; a++) {
    sourceAlphabet.add(alphabet.substring(alphabet.indexOf(key[a]))
        + alphabet.substring(0, alphabet.indexOf(key[a])));
  }

 // List<int> textList = text.codeUnits;

  for (int i = 0, letters = 0, tmp; i < text.length; i++, letters++) {
    if ((tmp = alphabet.indexOf(text[i])) >= 0) {
      modText += sourceAlphabet[letters % key.length][tmp];
    } else if ((tmp = alphabet.indexOf(text[i].toLowerCase())) >= 0) {
      modText += sourceAlphabet[letters % key.length][tmp].toUpperCase();
    } else {
      letters--;
      modText += text[i];
    }
  }
  return modText;
}

Future<String> vigenerDecrypt (
    String text,
    {@required String key}
    ) async {
  String modText = "";
  key.trim();
  if (key == "") {
    return modText;
  }
  List<String> sourceAlphabet = [];
  for (var a=0; a < key.length; a++) {
    sourceAlphabet.add(alphabet.substring(alphabet.indexOf(key[a]))
        + alphabet.substring(0, alphabet.indexOf(key[a])));
  }

  for (var i = 0, letters = 0, tmp; i < text.length; i++, letters++) {
    if ((tmp = sourceAlphabet[i % key.length].indexOf(text[i])) >= 0) {
      modText += alphabet[tmp];
    } else if ((tmp = sourceAlphabet[i % key.length]
        .indexOf(text[i].toLowerCase())) >= 0) {
      modText += alphabet[tmp].toUpperCase();
    } else {
      letters--;
      modText += text[i];
    }
  }
  return modText;
}