import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialui/Profile/Profile.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'validar_insulto.dart';

class EditarTweetScreen extends StatefulWidget {
  const EditarTweetScreen(
      {Key? key, required this.idtweet, required this.tweet_contenido})
      : super(key: key);
  final int idtweet;
  final String tweet_contenido;
  @override
  _EditarTweetScreen createState() => _EditarTweetScreen();
}

TextEditingController tweet_contenido = TextEditingController();

class _EditarTweetScreen extends State<EditarTweetScreen> {
  final _formKey = GlobalKey<FormState>();

  void initState() {
    tweet_contenido.text = widget.tweet_contenido;
    super.initState();
  }

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
                      } else {
                        print("todo bien _ se hace el envio compa ");
                        //crear_tweet(widget.tweet_contenido.text);
                        editar_tweet(tweet_contenido.text, widget.idtweet);
                        Navigator.pop(context);
                      }
                    }
                  },
                  icon: Icon(
                    // <-- Icon
                    Icons.edit,
                    size: 30.0,
                  ),
                  label: Text('Editar'), // <-- Text
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
                              child: Icon(FontAwesomeIcons.solidEdit,
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

  editar_tweet(contenido, idtweet_) async {
    var url4 = Uri.parse('http://192.168.56.1:4000/tweet/update/$idtweet_');
    Map data4 = {
      "contenido": contenido,
    };
    var body4 = convert.json.encode(data4);
    var response4 = await http.put(url4,
        headers: {"Content-Type": "application/json"}, body: body4);
    if (response4.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Se actualizo el Tweet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    } else {
      print('Falla al conectar al API REST: ${response4.statusCode}.');
    }
  }
}
