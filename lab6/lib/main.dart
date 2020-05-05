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
      title: 'Шифрование гаммированием',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CryptPage(title: 'Шифрование гаммированием'),
    );
  }
}

class CryptPage extends StatelessWidget {
  final String title;
  CryptPage({Key key, this.title}) : super(key: key);

  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

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
                    TextFormField(
                      controller: keyController,
                      decoration: InputDecoration(
                        labelText: 'Гамма',
                        icon: Icon(Icons.vpn_key),
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
                            await gammaEncrypt(
                              inputController.text,
                              gamma: keyController.text,
                            ).forEach((event) => outputController.text += event);
                          },
                        ),
                        OutlineButton(
                          child: Text('Дешифровать'),
                          highlightedBorderColor: Colors.amber,
                          borderSide: BorderSide(color: Colors.amber),
                          onPressed: () async {
                            outputController.clear();
                            await gammaDecrypt(
                              inputController.text,
                              gamma: keyController.text,
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
