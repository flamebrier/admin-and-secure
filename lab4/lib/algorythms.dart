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

  int tmp;
  int a;
  int letters = 0;

  for (var i = 0; i < text.length; i++) {
    a = letters % key.length;
    if ((tmp = alphabet.indexOf(text[i])) > 0) {
      letters++;
      modText += sourceAlphabet[a][tmp];
    } else if ((tmp = alphabet.indexOf(text[i].toLowerCase())) > 0) {
      letters++;
      modText += sourceAlphabet[a][tmp].toUpperCase();
    } else {
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

  int tmp;
  int a;

  for (var i = 0; i < text.length; i++) {
    a = i % key.length;
    if ((tmp = sourceAlphabet[a].indexOf(text[i])) > 0) {
      modText += alphabet[tmp];
    } else if ((tmp = sourceAlphabet[a].indexOf(text[i].toLowerCase())) > 0) {
      modText += alphabet[tmp].toUpperCase();
    } else {
      modText += text[i];
    }
  }
  return modText;
}