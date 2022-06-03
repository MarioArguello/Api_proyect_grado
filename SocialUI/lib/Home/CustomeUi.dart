import 'package:socialui/Constance/theme.dart';
import 'package:socialui/Home/HomeScreen.dart';
import 'package:socialui/Message/Message.dart';
import 'package:socialui/Notification/Notification.dart';
import 'package:socialui/Profile/Profile.dart';
import 'package:socialui/widget/GredianIcon.dart';
import 'package:socialui/Home/Busqueda_amigo/buscar_amigo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomeUiScreen extends StatefulWidget {
  const CustomeUiScreen({key, required this.idperson}) : super(key: key);
  final int idperson;
  @override
  _CustomeUiScreenState createState() => _CustomeUiScreenState();
}

class _CustomeUiScreenState extends State<CustomeUiScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Widget indexView;
  // Widget indexView = HomeScreen();
  BottomBarType bottomBarType = BottomBarType.Home;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    indexView = HomeScreen(
        animationController: animationController, iduser: widget.idperson);
    animationController..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Map? parametros = ModalRoute.of(context)?.settings.arguments as Map?;
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _onWikkPopScope();
          return shouldPop ?? false;
        },
        child: Container(
          child: Scaffold(
            backgroundColor: AppTheme.getTheme().backgroundColor,
            bottomNavigationBar: Container(
                height: 58 + MediaQuery.of(context).padding.bottom,
                child: getBottomBarUI(bottomBarType)),
            body: indexView,
          ),
        ));
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController.reverse().then((f) {
        if (tabType == BottomBarType.Home) {
          setState(() {
            indexView = HomeScreen(
                animationController: animationController,
                iduser: widget.idperson);
          });
        } else if (tabType == BottomBarType.Message) {
          setState(() {
            indexView = MessageScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Notification) {
          setState(() {
            indexView = NotificationScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            print("idperson");
            print(widget.idperson.toString());
            indexView = ProfileScreen(
              animationController: animationController,
              idperson: widget.idperson,
            );
          });
        } else if (tabType == BottomBarType.Buscar_amigo) {
          setState(() {
            indexView = Buscar_amigoScreen(
              animationController: animationController,
              idperson: widget.idperson,
            );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Container(
      color: HexColor("#FFFFFF"),
      height: MediaQuery.of(context).padding.bottom + 60,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Home);
              },
              child: GradientIcon(
                FontAwesomeIcons.home,
                20,
                LinearGradient(
                  colors: tabType == BottomBarType.Home
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7),
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Buscar_amigo);
              },
              child: GradientIcon(
                Icons.person_add,
                26,
                LinearGradient(
                  colors: tabType == BottomBarType.Buscar_amigo
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Color.fromARGB(255, 71, 70, 70).withOpacity(0.7),
                          Color.fromARGB(255, 54, 53, 53)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Message);
              },
              child: GradientIcon(
                FontAwesomeIcons.facebookMessenger,
                20,
                LinearGradient(
                  colors: tabType == BottomBarType.Message
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7),
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Notification);
              },
              child: GradientIcon(
                Icons.notifications_active,
                26,
                LinearGradient(
                  colors: tabType == BottomBarType.Notification
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7),
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                tabClick(BottomBarType.Profile);
              },
              child: GradientIcon(
                FontAwesomeIcons.user,
                20,
                LinearGradient(
                  colors: tabType == BottomBarType.Profile
                      ? [
                          Theme.of(context).primaryColor,
                          Color(0xfff78361),
                        ]
                      : [
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7),
                          Color.fromARGB(255, 54, 53, 53).withOpacity(0.7)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _onWikkPopScope() {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Alerta !"),
              content: Text("Estas seguro que deseas salir ?"),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancelar")),
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Salir"))
              ],
            ));
  }
}

enum BottomBarType {
  Home,
  Buscar_amigo,
  Message,
  Notification,
  Profile,
  Stories,
}
