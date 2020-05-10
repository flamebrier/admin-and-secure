import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

final String alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя";
final String upperAlphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя".toUpperCase();

Stream<double> stringToRow(String row) async* {
  if (row.isNotEmpty) {
    var tmp = row.split(' ');
    for (var i in tmp) {
      yield double.parse(i);
    }
  }
}

Stream<int> wordToCodes(String word) async* {
  int tmp;
  if (word.isNotEmpty) {
    for (int i = 0; i < word.length; i++) {
      if ((tmp = upperAlphabet.indexOf(word[i])) >= 0) {
        yield tmp;
      }
    }
  }
}

List<double> listToLength(List<double> list, int counter) {
  int tmp;
  int length = list.length;
  if ((tmp = (length % counter)) > 0) {
    tmp = counter - tmp;
    for (int i = 0; i < tmp; i++) {
      list.add(-1);
    }
  }
  return list;
}

Stream<String> matrixEncrypt (
    String text,
    {
      String row1,
      String row2,
      String row3,
      String row4
    }
    ) async* {
  bool is4 = row4.isNotEmpty;
  int count = (is4) ? 4 : 3;
  text = text.toUpperCase();

  List<double> list = List<double>();
  await stringToRow(row1).forEach((element) {list.add(element);});
  await stringToRow(row2).forEach((element) {list.add(element);});
  await stringToRow(row3).forEach((element) {list.add(element);});
  if (is4) {
    await stringToRow(row4).forEach((element) {list.add(element);});
    
    Matrix4 keyMatrix = Matrix4.fromList(list);
    List<Vector4> vectorText = List<Vector4>();
    list.clear();
    await wordToCodes(text).forEach((element) {list.add(element.toDouble());});

    list = listToLength(list, count);

    for (int i = 0; (i + count - 1) < list.length; i += count) {
      vectorText.add(Vector4.array(list.getRange(i, i + count).toList()));
    }

    Vector tmp;
    for (Vector vector in vectorText) {
      tmp = keyMatrix * vector;
      for (double i in tmp.storage) {
        yield i.toString() + ' ';
      }
    }
  } else {
    Matrix3 keyMatrix = Matrix3.fromList(list);
    List<Vector3> vectorText = List<Vector3>();
    list.clear();
    await wordToCodes(text).forEach((element) {list.add(element.toDouble());});

    list = listToLength(list, count);
    for (int i = 0; (i + count - 1) < list.length; i += count) {
      vectorText.add(Vector3.array(list.getRange(i, i + count).toList()));
    }

    Vector tmp;
    for (Vector vector in vectorText) {
      tmp = keyMatrix * vector;
      for (double i in tmp.storage) {
        yield i.toString() + ' ';
      }
    }
  }
}

Stream<String> matrixDecrypt (
    String text,
    {
      String row1,
      String row2,
      String row3,
      String row4
    }
    ) async* {
  bool is4 = row4.isNotEmpty;
  int count = (is4) ? 4 : 3;
  text = text.toUpperCase().trim();

  List<double> list = List<double>();
  await stringToRow(row1).forEach((element) {list.add(element);});
  await stringToRow(row2).forEach((element) {list.add(element);});
  await stringToRow(row3).forEach((element) {list.add(element);});
  if (is4) {
    await stringToRow(row4).forEach((element) {list.add(element);});

    Matrix4 keyMatrix = Matrix4.fromList(list);
    Matrix4 invertMatrix = Matrix4.inverted(keyMatrix);
    List<Vector4> vectorText = List<Vector4>();
    list.clear();
    var tmpList = text.split(' ');
    for (String element in tmpList) {
      list.add(double.parse(element).roundToDouble());
    }

    for (int i = 0; (i + count - 1) < list.length; i += count) {
      vectorText.add(Vector4.array(list.getRange(i, i + count).toList()));
    }

    Vector tmp;
    for (Vector vector in vectorText) {
      tmp = invertMatrix * vector;
      for (double i in tmp.storage) {
        if (i >= 0) {yield upperAlphabet[i.round()];}
      }
    }
  } else {
    yield 'Дешифровка доступна только для матриц 4х4';
  }
}