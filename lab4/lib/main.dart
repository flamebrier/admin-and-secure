import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab4/algorythms.dart';

void main() {
  runApp(CryptApp());
}

class CryptApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шифрование Виженера',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CryptPage(title: 'Шифрование Виженера'),
    );
  }
}

class CryptPage extends StatelessWidget {
  final String title;
  CryptPage({Key key, this.title}) : super(key: key);

  final TextEditingController inputController = TextEditingController();
  final TextEditingController outputController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final TextEditingController mController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    keyController.addListener(() {mController.text =
        keyController.text.length.toString();});
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
                      controller: mController,
                      maxLength: 1,
                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Длина сдвига',
                        icon: Icon(Icons.label_important),
                      ),
                    ),
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
                            outputController.clear();
                            await vigenerEncrypt(
                              inputController.text,
                              key: keyController.text,
                              m: int.tryParse(mController.text) ?? 0,
                            ).forEach((event) => outputController.text += event);
                          },
                        ),
                        OutlineButton(
                          child: Text('Дешифровать'),
                          highlightedBorderColor: Colors.amber,
                          borderSide: BorderSide(color: Colors.amber),
                          onPressed: () async {
                            outputController.clear();
                            await vigenerDecrypt(
                              inputController.text,
                              key: keyController.text,
                              m: int.tryParse(mController.text) ?? 0,
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
