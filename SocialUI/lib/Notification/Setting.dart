import 'package:socialui/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialui/main.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

enum Notifications { onn, off }
enum Language { english, hindi, gujrati, urdu }

class _SettingScreenState extends State<SettingScreen> {
  Notifications _notifications = Notifications.onn;
  Language _language = Language.english;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 35, left: 14),
                child: Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 16, 15, 15),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Text(
                          "Ajustes",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 13, 13, 13),
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        expandedAlignment: Alignment.bottomCenter,
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 14, 13, 13)),
                        title: Text(
                          "Notificación",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 11, 11, 11)
                                    .withOpacity(0.6),
                              ),
                        ),
                        tilePadding: EdgeInsets.only(left: 30, right: 30),
                        children: [
                          Column(
                            children: <Widget>[
                              ListTile(
                                title: const Text(
                                  'on',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 11, 11, 11)),
                                ),
                                leading: Radio(
                                  value: Notifications.onn,
                                  groupValue: _notifications,
                                  onChanged: (Notifications? value) {
                                    setState(() {
                                      _notifications = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'off',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 19, 19, 19)),
                                ),
                                leading: Radio(
                                  value: Notifications.off,
                                  groupValue: _notifications,
                                  onChanged: (Notifications? value) {
                                    setState(() {
                                      _notifications = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.4),
                        thickness: 2,
                      ),
                      ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 23, 22, 22)),
                        title: Text(
                          "Idioma",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 18, 18, 18)
                                    .withOpacity(0.6),
                              ),
                        ),
                        tilePadding: EdgeInsets.only(left: 30, right: 30),
                        children: [
                          Column(
                            children: <Widget>[
                              ListTile(
                                title: const Text(
                                  'Español',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 9, 9, 9)),
                                ),
                                leading: Radio(
                                  value: Language.english,
                                  groupValue: _language,
                                  onChanged: (Language? value) {
                                    setState(() {
                                      _language = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'English',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 10, 10, 10)),
                                ),
                                leading: Radio(
                                  value: Language.hindi,
                                  groupValue: _language,
                                  onChanged: (Language? value) {
                                    setState(() {
                                      _language = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.4),
                        thickness: 2,
                      ),
                      ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 14, 13, 13)),
                        title: Text(
                          "Desactivar tu cuenta",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 27, 24, 24)
                                    .withOpacity(0.6),
                              ),
                        ),
                        tilePadding: EdgeInsets.only(left: 30, right: 30),
                        children: [],
                      ),
                      Divider(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.4),
                        thickness: 2,
                      ),
                      ExpansionTile(
                        childrenPadding: EdgeInsets.zero,
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 17, 17, 17)),
                        title: Text(
                          "Tweet eliminados",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 28, 28, 28)
                                    .withOpacity(0.6),
                              ),
                        ),
                        tilePadding: EdgeInsets.only(left: 30, right: 30),
                        children: [],
                      ),
                      Divider(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.4),
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          alertarSalir();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Color(0xfff78361),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                "Cerrar sesión",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        letterSpacing: 0.6,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).canvasColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void alertarSalir() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Alerta !"),
        content: Text("Estas seguro que deseas salir?"),
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                print("salir");
                destruirPreferencias();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.SPLASH,
                  (route) => false,
                );
              },
              child: Text("Salir")),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"))
        ],
      ),
    );
  }
}

Future destruirPreferencias() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  print("preferencias destruidas");
}
