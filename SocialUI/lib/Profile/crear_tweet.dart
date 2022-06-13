import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialui/Profile/Profile.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'validar_insulto.dart';
import 'package:socialui/enviorement/enviroment.dart';

class CrearTweetScreen extends StatefulWidget {
  const CrearTweetScreen({Key? key, required this.idperson, required this.name})
      : super(key: key);
  final int idperson;
  final String name;
  @override
  _CrearTweetScreen createState() => _CrearTweetScreen();
}

class _CrearTweetScreen extends State<CrearTweetScreen> {
  TextEditingController tweet_contenido = TextEditingController();

  @override
  void initState() {}

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 5.0,
              toolbarHeight: 60,
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("enviar");
                      bool valid = false;
                      for (var n in validChar) {
                        print(n);
                        if (tweet_contenido.text.contains(n)) {
                          print("insulto detectado");
                          valid = true;
                        } else {
                          print("sms enviado");
                        }
                      }
                      if (valid) {
                        Fluttertoast.showToast(
                            msg:
                                "Se detecto insulto, por favor elimina los insultos ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1);
                        tweet_contenido.clear();
                      } else {
                        crear_tweet(widget.idperson, tweet_contenido.text);
                        tweet_contenido.clear();
                        Navigator.pop(context);
                      }
                    }
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.send,
                    size: 30.0,
                  ),
                  label: Text('Twittear'), // <-- Text
                ),
              ],
            ),
            body: Form(
                key: _formKey,
                child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(FontAwesomeIcons.featherAlt,
                                  size: 40.0, color: Colors.black),
                            ),
                            hintText: "Ingrese tweet",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    new Radius.circular(25.0))),
                            labelStyle: TextStyle(color: Colors.black)),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),
                        controller: tweet_contenido,
                        validator: (value) => value!.isEmpty
                            ? 'Por favor ingresa tweet'
                            : value.length < 10
                                ? 'Ingresa al menos 10 caracteres'
                                : value.length > 255
                                    ? 'Maximo de caracteres permitidos es de 255, excediste los caracteres permitidos.'
                                    : null,
                        minLines:
                            6, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ) //tec
                    ]))));
  }

  crear_tweet(id_person, contenido) async {
    var url4 = Uri.parse('${Enviroment.Api_url}tweet/create');
    Map data4 = {
      "contenido": contenido,
      "estado": "A",
      "idpersona": id_person,
    };
    var body4 = convert.json.encode(data4);
    var response4 = await http.post(url4,
        headers: {"Content-Type": "application/json"}, body: body4);
    if (response4.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Nuevo tweet " + widget.name,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    } else {
      print('Falla al conectar al API REST: ${response4.statusCode}.');
    }
  }
}
