import 'package:socialui/login/ForgotPasswordScreen.dart';
import 'package:socialui/main.dart';
import 'package:socialui/widget/CustomeButton.dart';
import 'package:flutter/material.dart';
import 'package:socialui/login/RegistrationScreen.dart';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialui/Home/CustomeUi.dart';
import 'package:socialui/login/correo/correo_verificar.dart';

var user;
var passw;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController UsernameLogin = TextEditingController();
TextEditingController PasswordLogin = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isHidden = true;
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    this.obtenerPreferencias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 204, 230),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
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
                        height: 75,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17, right: 17),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/twitter2.png"),
                            ),
                            Text(
                              "Bienvenido",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      letterSpacing: 0.6,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 23, 22, 22)),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Text(
                              "Ingrese a su username",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        letterSpacing: 0.6,
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 18, 18, 18),
                                      ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Color.fromARGB(255, 9, 8, 8)),
                                decoration: InputDecoration(
                                  hintText: "Ingrese username",
                                  fillColor: Color.fromARGB(0, 237, 230, 230),
                                  filled: true,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: UsernameLogin,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese username';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                controller: PasswordLogin,
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
                                enabled: !isLoggedIn,
                                validator: (password) =>
                                    password != null && password.length < 3
                                        ? 'Enter min. 3 characters'
                                        : null,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  print("Password :" +
                                      PasswordLogin.text +
                                      " username :" +
                                      UsernameLogin.text);
                                  user = UsernameLogin.text;
                                  passw = PasswordLogin.text;
                                  login_api(user, passw);
                                }
                              },
                              child: CustomeButton(
                                btn: "Iniciar sesión",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => correoScreen()));
                              },
                              child: CustomeButton(
                                btn: "Registro",
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Olvidaste tu contraseña?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        letterSpacing: 0.6,
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 14, 14, 14),
                                      ),
                                ),
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
        ));
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
  login_api(user, passw) async {
    var url = Uri.parse('http://192.168.56.1:4000/proceso/login/$user/$passw');
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var isUser = jsonResponse['msg'];

      var id = jsonResponse['id_person'];

      if (isUser == '1') {
        this.guardarPreferencias(user, passw, id);
        print("Login correcto " + id.toString());
        Fluttertoast.showToast(
            msg: "Login correcto " + user,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CustomeUiScreen(idperson: id)));

        /* Navigator.pushReplacementNamed(context, '/home',
            arguments: {'idusuario': id});*/
        /* Navigator.pushReplacementNamed(context, '/restaurante', arguments: {
          'idusuario': id
        });*/
        UsernameLogin.clear();
        PasswordLogin.clear();
      } else {
        print("Revise su usuario y contrasena");
        Fluttertoast.showToast(
            msg: "Revise su usuario y contrasena",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        UsernameLogin.clear();
        PasswordLogin.clear();
      }
    } else {
      print('Falla al conectar al API REST: ${response.statusCode}.');
    }
  }

  void guardarPreferencias(username, password, idusuario_preferencia) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username2", username);
    preferences.setString("password", password);
    preferences.setInt("id_usuariopref", idusuario_preferencia);
    preferences.setBool("session", true);
  }

  String username2 = '';
  String password2 = '';
  late int idusuario_2;

  Future obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username2 = preferences.getString("username2") ?? "";
      password2 = preferences.getString("passw") ?? "";
      idusuario_2 = preferences.getInt("id_usuariopref") ?? 0;
      Object? session = preferences.get("session");
      if (session == true) {
        /*  Navigator.of(context).pushNamedAndRemoveUntil(
          '/MemberPage', (Route<dynamic> route) => false);*/
        setState(() {
          user = username2;
          passw = password2;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CustomeUiScreen(
                      idperson: idusuario_2,
                    )));

        print("Usuario logeado" +
            username2 +
            " Id usuario" +
            idusuario_2.toString());
      } else {
        print("Usuario sin login");
      }
    });
    return null;
  }
}
