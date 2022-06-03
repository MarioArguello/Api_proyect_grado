import 'package:socialui/widget/GredianIcon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialui/Home/Busqueda_amigo/historial.dart';
import 'package:socialui/Home/Busqueda_amigo/amigo_busqueda_datos.dart';

class Buscar_amigoScreen extends StatefulWidget {
  final AnimationController animationController;

  const Buscar_amigoScreen(
      {key, required this.animationController, required this.idperson})
      : super(key: key);
  final int idperson;
  @override
  _Buscar_amigoScreen createState() => _Buscar_amigoScreen();
}

class _Buscar_amigoScreen extends State<Buscar_amigoScreen>
    with TickerProviderStateMixin {
  List data = [];
  bool icon1 = true;
  bool icon2 = false;
  late AnimationController _animationController;
  bool isLoadingSliderDetail = false;
  late ScrollController controller;
  var sliderImageHieght = 0.0;
  late String nombre = "";
  late String username = "";
  late String fecha_nacimiento = "";
  late String correo = "";
  late String telefono = "";

  void initState() {
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

  TextEditingController busqueda = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                children: [
                  Container(
                    height: 115,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.2)),
                            child: TextFormField(
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 23, 22, 22)
                                            .withOpacity(0.3),
                                      ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 13),
                                border: InputBorder.none,
                                hintText: "Ingrese nombre",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      letterSpacing: 0.6,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 13, 12, 12)
                                          .withOpacity(0.3),
                                    ),
                                prefixIcon: Icon(Icons.search,
                                    size: 25, color: Colors.grey),
                                suffixIcon:

                                    //camera
                                    IconButton(
                                  onPressed: () async {
                                    //take image from camera

                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                              controller: busqueda,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor ingrese nombre';
                                }
                                return null;
                              },
                            ),
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
                              icon2 = false;
                            });
                          },
                          child: GradientIcon(
                            FontAwesomeIcons.search,
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
                              icon2 = true;
                            });
                          },
                          child: GradientIcon(
                            Icons.history,
                            25,
                            LinearGradient(
                              colors: icon2 == true
                                  ? [
                                      Theme.of(context).primaryColor,
                                      Color(0xfff78361),
                                    ]
                                  : [
                                      Color.fromARGB(255, 18, 15, 15)
                                          .withOpacity(0.7),
                                      Color.fromARGB(255, 31, 25, 25)
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
                      ? (busqueda.text == null || busqueda.text == '')
                          ? amigos_busqueda_datosScreen(
                              idperson: widget.idperson,
                              nombre_person: "default")
                          : amigos_busqueda_datosScreen(
                              idperson: widget.idperson,
                              nombre_person: busqueda.text)
                      : icon2 == true
                          ? HistorialScreen(idperson: widget.idperson)
                          : SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
