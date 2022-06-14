import 'package:socialui/widget/CustomeButton.dart';
import 'package:flutter/material.dart';
import 'package:socialui/login/correo/recuperarContrasenaSend.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:socialui/login/actualizarcontrasena.dart';
import 'package:random_string/random_string.dart';
import 'package:email_validator/email_validator.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:socialui/enviorement/enviroment.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? codigo_persona;
  const ForgotPasswordScreen({Key? key, this.codigo_persona}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

TextEditingController email = TextEditingController();

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 241, 247),
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 12, 12, 12),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/twitter2.png"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Se te olvidó tu contraseña?",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 25, 24, 24)),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Text(
                          "Por favor, introduzca su dirección de correo electrónico. Recibirá una clave para poder actualizar su contraseña.",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 15,
                                color: Color.fromARGB(255, 16, 16, 16)
                                    .withOpacity(0.9),
                              ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Form(
                          key: formKey,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 9, 8, 8)),
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
                              controller: email,
                              validator: (value) {
                                final bool isValid =
                                    EmailValidator.validate(value!);
                                if (isValid == false) {
                                  return 'Email no valido';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              String codigo_ = randomAlphaNumeric(10);
                              print(codigo_);
                              final plainText = codigo_;
                              final key = encrypt.Key.fromUtf8(
                                  'my 32 length key................');
                              final iv = encrypt.IV.fromLength(16);
                              final encrypter = encrypt.Encrypter(
                                  encrypt.AES(key, mode: encrypt.AESMode.cbc));
                              final encrypted =
                                  encrypter.encrypt(plainText, iv: iv);
                              print("encriptar cbc :" + encrypted.base64);
                              validarcorreo_api(email.text, encrypted);
                            }
                          },
                          child: CustomeButton(
                            btn: "Enviar",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  validarcorreo_api(correo, codigo_) async {
    var url =
        Uri.parse('${Enviroment.Api_url}proceso/validarPersonaCorreo/$correo');
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var isUser = jsonResponse['msg'];
      var username = jsonResponse['username'];
      var idusuario_ = jsonResponse['id_usuario'];
      if (isUser == "1") {
        print("usuario puede cambiar la clave");
        sendmainActualizarContrasema(codigo_, username, correo);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => actualizarContrasenaScreen(
                    codigo_persona: codigo_, idusuario: idusuario_)));
        email.clear();
      } else {
        print("error al enviar correo - correo no registrado");
        alertavalidacion();
      }
    } else {
      print('Falla al conectar al API REST: ${response.statusCode}.');
    }
  }

  void alertavalidacion() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Alerta !"),
        content: Text(
            "El correo no se encuentra registrado en nuestra base de datos."),
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
