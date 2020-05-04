import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final String alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";

final Map<String, String> radixAlphabet = {
  'А': "000001", 'Б': "001001", 'В': "001010", 'Г': "001011",
  'Д': "001100", 'Е': "000010", 'Ё': "000010", 'Ж': "001101",
  'З': "001110", 'И': "000011", 'Й': "000011", 'К': "001111",
  'Л': "010000", 'М': "010001", 'Н': "010010", 'О': "000100",
  'П': "010011", 'Р': "010100", 'С': "010101", 'Т': "010110",
  'У': "000101", 'Ф': "010111", 'Х': "011000", 'Ц': "011001",
  'Ч': "011010", 'Ш': "011011", 'Щ': "011100", 'Ъ': "011100",
  'Ы': "011101", 'Ь': "011110", 'Э': "000110", 'Ю': "000111",
  'Я': "001000"
};

String toEqualLength(String big, String less) {
  for (int i = big.length - less.length; i > 0; i--) {
    less = "0" + less;
  }
  return less;
}

int binParse(String bin) {
  return (bin == '0') ? 0 : 1;
}

String sumMod2(String aug, String add) {
  String sum = "";
  if (aug.length > add.length) {
    add = toEqualLength(aug, add);
  } else if (aug.length < add.length) {
    aug = toEqualLength(add, aug);
  }
  for (int i = 0; i < aug.length; i++) {
    sum += ((binParse(aug[i]) + binParse(add[i])) % 2).toString();
  }
  return sum;
}

Stream<String> gammaEncrypt (
    String text,
    {
      @required String gamma,
    }
    ) async* {
  text = text.toUpperCase();
  gamma = gamma.trim();
  if (gamma == "") {
    yield text;
  }
  List<String> gammaList = List<String>();
  gamma.split(' ').forEach((element) {
    gammaList.add(int.tryParse(element).toRadixString(2));
  });

//  yield gammaList.toString();
  int g = 0;
  for (int i = 0; i < text.length; i++) {
    if (radixAlphabet.containsKey(text[i])) {
//      yield " | " + radixAlphabet[text[i]] + "+" + gammaList[g] + ";";
      yield sumMod2(radixAlphabet[text[i]], gammaList[g]);
      if ((++g) == gammaList.length) {
        g = 0;
      }
    }
  }
}

Stream<String> gammaDecrypt (
    String text,
    {
      @required String gamma,
    }
    ) async* {
  text = text.toUpperCase();
  gamma = gamma.trim();
  if (gamma == "") {
    yield text;
  }
  List<String> gammaList = List<String>();
  gamma.split(' ').forEach((element) {
    gammaList.add(int.tryParse(element).toRadixString(2));
  });

//  yield gammaList.toString();
  int g = 0;
  for (int i = 0; i < text.length; i++) {
    if (radixAlphabet.containsKey(text[i])) {
//      yield " | " + radixAlphabet[text[i]] + "+" + gammaList[g] + ";";
      yield sumMod2(radixAlphabet[text[i]], gammaList[g]);
      if ((++g) == gammaList.length) {
        g = 0;
      }
    }
  }
}