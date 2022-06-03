import 'package:socialui/widget/CustomeButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialui/login/LoginScreen.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class actualizarContrasenaScreen extends StatefulWidget {
  final codigo_persona;
  final int? idusuario;
  const actualizarContrasenaScreen(
      {Key? key, this.codigo_persona, this.idusuario})
      : super(key: key);

  @override
  _actualizarContrasenaScreen createState() => _actualizarContrasenaScreen();
}

bool isHidden = true;
TextEditingController contrasena = TextEditingController();
TextEditingController contrasenaConfirmar = TextEditingController();
TextEditingController contrasenaenviada = TextEditingController();

class _actualizarContrasenaScreen extends State<actualizarContrasenaScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 241, 247),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            contrasena.clear();
                            contrasenaenviada.clear();
                            contrasenaConfirmar.clear();
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_sharp,
                            color: Color.fromARGB(255, 9, 7, 7),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/twitter2.png"),
                            ),
                            Text(
                              "Cambiar contraseña.",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      letterSpacing: 0.6,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 12, 10, 10)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ingrese clave enviada al correo Electronico',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: contrasenaenviada,
                                obscureText: isHidden,
                                decoration: InputDecoration(
                                  hintText: 'clave enviada',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: isHidden
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: togglePasswordVisibility,
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                autofillHints: [AutofillHints.password],
                                validator: (password) =>
                                    password != null && password.length < 7
                                        ? 'Enter min. 7 characters'
                                        : null,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Contraseña',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: contrasena,
                                obscureText: isHidden,
                                decoration: InputDecoration(
                                  hintText: 'Contraseña',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: isHidden
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: togglePasswordVisibility,
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                autofillHints: [AutofillHints.password],
                                validator: (password) =>
                                    password != null && password.length < 7
                                        ? 'Enter min. 7 characters'
                                        : null,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Contraseña',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: contrasenaConfirmar,
                                obscureText: isHidden,
                                decoration: InputDecoration(
                                  hintText: 'Confrimar contraseña',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: isHidden
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: togglePasswordVisibility,
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                autofillHints: [AutofillHints.password],
                                validator: (password) =>
                                    password != null && password.length < 7
                                        ? 'Enter min. 7 characters'
                                        : null,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                final key = encrypt.Key.fromUtf8(
                                    'my 32 length key................');
                                final iv = encrypt.IV.fromLength(16);
                                final encrypter = encrypt.Encrypter(encrypt
                                    .AES(key, mode: encrypt.AESMode.cbc));
                                final decrypted = encrypter
                                    .decrypt(widget.codigo_persona, iv: iv);
                                print("codigo decrypted : " + decrypted);
                                if (formKey.currentState!.validate()) {
                                  if (contrasenaenviada.text == decrypted) {
                                    if (contrasena.text ==
                                        contrasenaConfirmar.text) {
                                      print("actualizar contraseña :)");
                                      actualizar_contrasena(
                                          contrasena.text, widget.idusuario);
                                    } else {
                                      print("las contraseñas no son iguales");
                                      Fluttertoast.showToast(
                                          msg: "las contraseñas no son iguales",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1);
                                    }
                                  } else {
                                    print("Codigo incorrecto");
                                    Fluttertoast.showToast(
                                        msg: "Codigo incorrecto",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1);
                                  }
                                }
                              },
                              child: CustomeButton(
                                btn: "Actualizar",
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  actualizar_contrasena(contrasenaNueva, idusuario) async {
    var url4 = Uri.parse('http://192.168.56.1:4000/usuario/update/$idusuario');
    Map data4 = {
      "password": contrasenaNueva,
    };
    var body4 = convert.json.encode(data4);
    var response4 = await http.put(url4,
        headers: {"Content-Type": "application/json"}, body: body4);
    if (response4.statusCode == 200) {
      contrasenaenviada.clear();
      contrasena.clear();
      contrasenaConfirmar.clear();
      alertar();
    } else {
      print('Falla al conectar al API REST: ${response4.statusCode}.');
    }
  }

  void alertar() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Felicidades"),
        content: Text("Se a actualizado su contraseña"),
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("Ok"))
        ],
      ),
    );
  }
}
