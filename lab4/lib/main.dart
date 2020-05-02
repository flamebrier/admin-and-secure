import 'package:flutter/material.dart';
import 'package:lab4/algorythms.dart';

void main() {
  runApp(CryptApp());
}

class CryptApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шифрование',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CryptPage(title: 'Шифрование'),
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
                        labelText: 'Ключ',
                        icon: Icon(Icons.vpn_key),
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
                            outputController.text = await vigenerCrypt(
                                inputController.text,
                                key: keyController.text
                            );
                          },
                        ),
                        OutlineButton(
                          child: Text('Дешифровать'),
                          highlightedBorderColor: Colors.amber,
                          borderSide: BorderSide(color: Colors.amber),
                          onPressed: () async {
                            outputController.text = await vigenerDecrypt(
                                inputController.text,
                                key: keyController.text
                            );
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
                  readOnly: true,
                  minLines: 1,
                  maxLines: 18,
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
