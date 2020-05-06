import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'algorythms.dart';

void main() {
  runApp(CryptApp());
}

class CryptApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шифрование с использованием аналитических преобразований',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CryptPage(title: 'Шифрование с использованием аналитических преобразований'),
    );
  }
}

class CryptPage extends StatelessWidget {
  final String title;
  CryptPage({Key key, this.title}) : super(key: key);

  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();

  final TextEditingController matrixController1 = TextEditingController();
  final TextEditingController matrixController2 = TextEditingController();
  final TextEditingController matrixController3 = TextEditingController();
  final TextEditingController matrixController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(this.title),
        elevation: 2.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 400,
                child: Column(
                  children: <Widget>[
                    Text('Матрица 4x4',
                      style: Theme.of(context).textTheme.caption,),
                    TextFormField(
                      controller: matrixController1,
                      decoration: InputDecoration(
                        labelText: 'Строка 1',
                        hintText: 'Числа через пробел',
                      ),
                    ),
                    TextFormField(
                      controller: matrixController2,
                      decoration: InputDecoration(
                        labelText: 'Строка 2',
                        hintText: 'Числа через пробел',
                      ),
                    ),
                    TextFormField(
                      controller: matrixController3,
                      decoration: InputDecoration(
                        labelText: 'Строка 3',
                        hintText: 'Числа через пробел',
                      ),
                    ),
                    TextFormField(
                      controller: matrixController4,
                      decoration: InputDecoration(
                        labelText: 'Строка 4',
                        hintText: 'Числа через пробел',
                      ),
                    ),
                    TextFormField(
                      controller: inputController,
                      minLines: 3,
                      maxLines: 15,
                      decoration: InputDecoration(
                        labelText: 'Исходный текст',
                        icon: Icon(Icons.assignment),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget> [
                        FlatButton(
                          child: Text('Зашифровать'),
                          color: Colors.amber,
                          splashColor: Colors.amberAccent,
                          onPressed: () async {
                            outputController.clear();
                            await matrixEncrypt(
                              inputController.text,
                              row1: matrixController1.text,
                              row2: matrixController2.text,
                              row3: matrixController3.text,
                              row4: matrixController4.text,
                            ).forEach((event) => outputController.text += event);
                          },
                        ),
                        OutlineButton(
                          child: Text('Дешифровать'),
                          highlightedBorderColor: Colors.amber,
                          borderSide: BorderSide(color: Colors.amber),
                          onPressed: () async {
                            outputController.clear();
                            await matrixDecrypt(
                              inputController.text,
                              row1: matrixController1.text,
                              row2: matrixController2.text,
                              row3: matrixController3.text,
                              row4: matrixController4.text,
                            ).forEach((event) => outputController.text += event);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: outputController,
                  minLines: 1,
                  maxLines: 20,
                  decoration: InputDecoration(
                    labelText: 'Полученный текст',
                    icon: Icon(Icons.security),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
