import 'package:socialui/Profile/editProfile.dart';
import 'package:socialui/Profile/music.dart';
import 'package:socialui/Profile/playVideo.dart';
import 'package:socialui/Profile/timeline.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:socialui/widget/GredianIcon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialui/Profile/crear_tweet.dart';
import 'package:socialui/enviorement/enviroment.dart';

class ProfileScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProfileScreen(
      {key, required this.animationController, required this.idperson})
      : super(key: key);
  final int idperson;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  List data = [];
  bool icon1 = true;
  bool icon3 = false;
  bool icon4 = false;

  late AnimationController _animationController;
  bool isLoadingSliderDetail = false;
  late ScrollController controller;
  var sliderImageHieght = 0.0;
  late String nombre = "";
  late String username = "";
  late String fecha_nacimiento = "";
  late String correo = "";
  late String telefono = "";

  Future<String> persona_perfil(persona_user) async {
    var url =
        Uri.parse('${Enviroment.Api_url}proceso/persona_perfil/$persona_user');
    var response = await http.get(url, headers: {"Accept": "application/json"});
    print(response);
    this.setState(() {
      data = convert.json.decode(response.body);
    });
    print(data[0]["nombres"]);
    print(data[0]["usuario"]["username"]);
    nombre = data[0]["nombres"];
    username = data[0]["usuario"]["username"];
    fecha_nacimiento = data[0]["fecha_nacimiento"];
    correo = data[0]["correo"];
    telefono = data[0]["telefono"];
    return "terminado";
  }

  void initState() {
    this.persona_perfil(widget.idperson);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    widget.animationController.forward();
    controller = ScrollController(initialScrollOffset: 0.0);

    controller.addListener(() {
      // ignore: unnecessary_null_comparison
      if (context != null) {
        if (controller.offset < 0) {
          _animationController.animateTo(0.0);
        } else if (controller.offset > 0.0 &&
            controller.offset < sliderImageHieght) {
          if (controller.offset < ((sliderImageHieght / 1.5))) {
            _animationController
                .animateTo((controller.offset / sliderImageHieght));
          } else {
            _animationController
                .animateTo((sliderImageHieght / 1.5) / sliderImageHieght);
          }
        }
      }
    });
    loadingSliderDetail();
    super.initState();
  }

  loadingSliderDetail() async {
    setState(() {
      isLoadingSliderDetail = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      isLoadingSliderDetail = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animationController,
          child: new Transform(
              transform: new Matrix4.translationValues(
                0.0,
                40 * (1.0 - widget.animationController.value),
                0.0,
              ),
              child: Scaffold(
                body: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Container(
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Expanded(child: SizedBox()),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfileScreen(
                                                  idperson: widget.idperson,
                                                  nombre: nombre,
                                                  correo: correo,
                                                  telefono: telefono,
                                                  fecha_nacimiento:
                                                      fecha_nacimiento,
                                                )));
                                  },
                                  child: GradientIcon(
                                    Icons.edit,
                                    24,
                                    LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Color(0xfff78361),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              child: Row(
                                children: [
                                  isLoadingSliderDetail == true
                                      ? Shimmer.fromColors(
                                          baseColor:
                                              (Color.fromARGB(255, 27, 17, 17)),
                                          highlightColor: (Color.fromARGB(
                                              255, 239, 138, 138)),
                                          enabled: isLoadingSliderDetail,
                                          child: CircleAvatar(
                                            radius: 50,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              AssetImage("assets/ups.jpg"),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  isLoadingSliderDetail == true
                                      ? Shimmer.fromColors(
                                          baseColor:
                                              (Color.fromARGB(255, 19, 13, 13)),
                                          highlightColor: (Color.fromARGB(
                                              255, 184, 84, 84)),
                                          enabled: isLoadingSliderDetail,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 150,
                                                color: Color.fromARGB(
                                                    255, 40, 24, 24),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 10,
                                                width: 100,
                                                color: Color.fromARGB(
                                                    255, 26, 19, 19),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              nombre,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    letterSpacing: 0.6,
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 15, 10, 10),
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "@" + username,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                    letterSpacing: 0.6,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                            255, 21, 14, 14)
                                                        .withOpacity(0.4),
                                                  ),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  icon1 = true;

                                  icon3 = false;
                                  icon4 = false;
                                });
                              },
                              child: GradientIcon(
                                FontAwesomeIcons.borderAll,
                                25,
                                LinearGradient(
                                  colors: icon1 == true
                                      ? [
                                          Theme.of(context).primaryColor,
                                          Color(0xfff78361),
                                        ]
                                      : [
                                          Color.fromARGB(255, 17, 15, 15)
                                              .withOpacity(0.7),
                                          Color.fromARGB(255, 26, 20, 20)
                                              .withOpacity(0.7)
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  icon1 = false;

                                  icon3 = true;
                                  icon4 = false;
                                });
                              },
                              child: GradientIcon(
                                Icons.play_circle_fill,
                                28,
                                LinearGradient(
                                  colors: icon3 == true
                                      ? [
                                          Theme.of(context).primaryColor,
                                          Color(0xfff78361),
                                        ]
                                      : [
                                          Color.fromARGB(255, 23, 18, 18)
                                              .withOpacity(0.7),
                                          Color.fromARGB(255, 9, 7, 7)
                                              .withOpacity(0.7)
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  icon1 = false;

                                  icon3 = false;
                                  icon4 = true;
                                });
                              },
                              child: GradientIcon(
                                Icons.queue_music,
                                28,
                                LinearGradient(
                                  colors: icon4 == true
                                      ? [
                                          Theme.of(context).primaryColor,
                                          Color(0xfff78361),
                                        ]
                                      : [
                                          Color.fromARGB(255, 18, 14, 14)
                                              .withOpacity(0.7),
                                          Color.fromARGB(255, 21, 15, 15)
                                              .withOpacity(0.7)
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 5,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      icon1 == true
                          ? TimeLineScreen(idperson: widget.idperson)
                          : icon3 == true
                              ? PlayVideoScreen(nombre: nombre)
                              : icon4 == true
                                  ? PlayMusicScreen()
                                  : SizedBox(),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CrearTweetScreen(
                                  idperson: widget.idperson,
                                  name: nombre,
                                ))).then((value) => setState(() {}));
                  },
                  label: const Text('Crear tweet'),
                  icon: const Icon(FontAwesomeIcons.featherAlt),
                  backgroundColor: Colors.blue,
                ),
              )),
        );
      },
    );
  }
}
