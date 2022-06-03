import 'package:socialui/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialui/login/LoginScreen.dart';

class TurnNotificationOnorOff extends StatefulWidget {
  @override
  _TurnNotificationOnorOffState createState() =>
      _TurnNotificationOnorOffState();
}

class _TurnNotificationOnorOffState extends State<TurnNotificationOnorOff> {
  bool notiSwitch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).backgroundColor,
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
                onTap: () {},
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 90,
                        backgroundColor: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.2),
                        child: CircleAvatar(
                          radius: 76,
                          backgroundColor: Colors.black87,
                          child: Icon(
                            FontAwesomeIcons.solidBell,
                            color: Colors.white,
                            size: 65,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Activar las notificaciones",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 18, 16, 16)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Habilite las notificaciones automáticas para permitirle enviarle noticias y actualizaciones personales",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            letterSpacing: 0.6,
                            fontSize: 15,
                            color:
                                Color.fromARGB(255, 11, 9, 9).withOpacity(0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 207, 174, 174),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            "Activar las notificaciones",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      letterSpacing: 0.6,
                                      fontSize: 17,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                    ),
                          ),
                          Expanded(child: SizedBox()),
                          CupertinoSwitch(
                            value: notiSwitch,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  notiSwitch = newValue;
                                },
                              );
                            },
                          ),
                          SizedBox(
                            width: 13,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Siguiente",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                color: Color.fromARGB(255, 17, 15, 15),
                                fontSize: 20,
                              ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          FontAwesomeIcons.fastForward,
                          color: Color.fromARGB(255, 20, 11, 11),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
