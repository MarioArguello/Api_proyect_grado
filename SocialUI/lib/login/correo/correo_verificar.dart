import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:socialui/widget/CustomeButton.dart';
import 'package:socialui/login/correo/pin_code.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:socialui/login/correo/enviar_correo.dart';
import 'package:random_string/random_string.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class correoScreen extends StatefulWidget {
  @override
  _correoScreen createState() => _correoScreen();
}

class _correoScreen extends State<correoScreen> {
  TextEditingController correoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/ups2.jpg'),
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Ingrese correo Electronico',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    style: TextStyle(color: Color.fromARGB(255, 9, 8, 8)),
                    decoration: InputDecoration(
                      hintText: "Ingrese Correo",
                      fillColor: Color.fromARGB(0, 237, 230, 230),
                      filled: true,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    controller: correoController,
                    validator: (value) {
                      final bool isValid = EmailValidator.validate(value!);
                      if (isValid == false) {
                        return 'Email no valido';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    String codigo_generado = randomNumeric(6);
                    print(codigo_generado);
                    final plainText = codigo_generado;
                    final key = encrypt.Key.fromUtf8(
                        'my 32 length key................');
                    final iv = encrypt.IV.fromLength(16);
                    final encrypter = encrypt.Encrypter(
                        encrypt.AES(key, mode: encrypt.AESMode.cbc));
                    final encrypted = encrypter.encrypt(plainText, iv: iv);
                    print("encriptar cbc :" + encrypted.base64);
                    validarcorreo_api(correoController.text, encrypted);
                  }
                },
                child: CustomeButton(
                  btn: "enviar",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validarcorreo_api(correo, codigo_) async {
    var url = Uri.parse(
        'http://192.168.56.1:4000/proceso/validarPersonaCorreo/$correo');
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var isUser = jsonResponse['msg'];
      var nombre_person = jsonResponse['nombre_person'];
      if (isUser == "1") {
        print("usuario ya registrado");
        alertavalidacion(nombre_person);
        correoController.clear();
      } else {
        print("enviar codigo al correo electronico");
        sendmain(codigo_, correo);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PinCodeVerificationScreen(
                      correo: correo,
                      codigo_persona: codigo_,
                    )));
        correoController.clear();
      }
    } else {
      print('Falla al conectar al API REST: ${response.statusCode}.');
    }
  }

  void alertavalidacion(nombre) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Alerta !"),
        content: Text("El correo del usuario " +
            nombre +
            "  ya se encuentra registrado."),
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"))
        ],
      ),
    );
  }
}
