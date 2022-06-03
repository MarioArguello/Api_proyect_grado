import 'package:flutter/services.dart';
import 'package:socialui/widget/CustomeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:socialui/login/LoginScreen.dart';
import 'package:socialui/login/correo/correo_verificar.dart';

class RegistrationScreen extends StatefulWidget {
  final String? correo;
  const RegistrationScreen({Key? key, this.correo}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

TextEditingController usernameRegistro = TextEditingController();
TextEditingController contrasenaRegistro = TextEditingController();
TextEditingController nombreRegistro = TextEditingController();
TextEditingController telefonoRegistro = TextEditingController();
TextEditingController cedulaRegistro = TextEditingController();

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isHidden = true;
  final _formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0]\d{9}$');
  @override
  Widget build(BuildContext context) {
    late var birthdate = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(birthdate);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 241, 247),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => correoScreen()));
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
                              "Crear cuenta",
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
                              height: 60,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Correo : ' + widget.correo.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nombre',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Color.fromARGB(255, 9, 8, 8)),
                                decoration: InputDecoration(
                                  hintText: "Ingrese nombres",
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
                                controller: nombreRegistro,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor ingrese Nombre';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'DNI',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 9, 8, 8)),
                                decoration: InputDecoration(
                                  hintText: "Ingrese DNI",
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
                                controller: cedulaRegistro,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                validator: (value) =>
                                    value != null && value.length < 10
                                        ? 'Ingrese los 10 caracteres del DNI'
                                        : null,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Telefono',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 9, 8, 8)),
                                decoration: InputDecoration(
                                  hintText: "Ingrese Telefono",
                                  fillColor: Color.fromARGB(0, 237, 230, 230),
                                  filled: true,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.smartphone_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                controller: telefonoRegistro,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[0-9]*$')),
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                validator: (value) => value != null &&
                                        value.length < 10
                                    ? 'Ingrese los 10 caracteres del telefono'
                                    : null,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ingrese fecha de nacimiento',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DatePickerWidget(
                              initialDate: DateTime.now()
                                  .add(Duration(days: -(365 * 18))),
                              lastDate: DateTime.now().add(Duration(days: -1)),
                              firstDate: DateTime.now()
                                  .add(Duration(days: -(365 * 150))),
                              dateFormat: "dd-MM-yyyy",
                              locale: DatePicker.localeFromString("es"),
                              onChange: (value, selectedIndex) =>
                                  birthdate = value,
                              pickerTheme: DateTimePickerTheme(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  dividerColor: Theme.of(context).primaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Usuario',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Color.fromARGB(255, 9, 8, 8)),
                                decoration: InputDecoration(
                                  hintText: "Ingrese Usuario",
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                controller: usernameRegistro,
                                validator: (value) =>
                                    value != null && value.length < 9
                                        ? 'Ingrese min. 9 caracteres'
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
                                controller: contrasenaRegistro,
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
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Registro_api(
                                      cedulaRegistro.text,
                                      widget.correo,
                                      telefonoRegistro.text,
                                      formattedDate);
                                }
                              },
                              child: CustomeButton(
                                btn: "Crear",
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Text(
                                "Al hacer clic en Registrarse, acepta los siguientes Términos y condiciones sin reservas",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        letterSpacing: 0.6,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 29, 23, 23)
                                            .withOpacity(0.4),
                                        height: 1.5),
                                textAlign: TextAlign.center,
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

  Registro_api(dni, correo, telefono, fecha) async {
    var url = Uri.parse(
        'http://192.168.56.1:4000/proceso/validarPersona/$dni/$telefono');
    print(url);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var isUser = jsonResponse['msg'];
      var nombre_person = jsonResponse['nombre_person'];
      if (isUser == "1") {
        alertaregistro(nombre_person);

        usernameRegistro.clear();
        contrasenaRegistro.clear();
        nombreRegistro.clear();
        telefonoRegistro.clear();
        cedulaRegistro.clear();
      } else {
        var url = Uri.parse(
            'http://192.168.56.1:4000/proceso/persona__usuario_crear/create');
        print(url);
        Map data = {
          'username': usernameRegistro.text,
          'password': contrasenaRegistro.text,
          'estado': "A",
          'nombres': nombreRegistro.text,
          'telefono': telefonoRegistro.text,
          'correo': correo,
          'dni': cedulaRegistro.text,
          'fecha_nacimiento': fecha
        };
        var body2 = convert.json.encode(data);
        var response = await http.post(url,
            headers: {"Content-Type": "application/json"}, body: body2);
        //     'codigo': codigoRegistro.text,
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Registro con exito Felicidades..",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          usernameRegistro.clear();
          contrasenaRegistro.clear();
          nombreRegistro.clear();
          telefonoRegistro.clear();
          cedulaRegistro.clear();
        } else {
          print('Falla al conectar al API REST: ${response.statusCode}.');
        }
      }
    } else {
      print('Falla al conectar al API REST: ${response.statusCode}.');
    }
  }

  void alertaregistro(nombre) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Alerta !"),
        content: Text("El usuario " + nombre + "  ya se encuentra registrado."),
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
