import 'package:socialui/Home/Comment.dart';
import 'package:socialui/Home/sugerencias.dart';
import 'package:socialui/Home/openCamera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:socialui/Home/TweetSerializer/tweetAmigoSerializacion.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialui/enviorement/enviroment.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController animationController;
  final int iduser;
  const HomeScreen(
      {key, required this.animationController, required this.iduser})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool popular = true;
  bool friends = false;
  bool stories = false;
  Future<List<Amigo>> getDataTweetuser(idusuario_) async {
    print(idusuario_.toString());
    http.Response response = await http.get(
        Uri.parse('${Enviroment.Api_url}proceso/tweet_amigo/$idusuario_'), //url
        headers: {"Accept": "application/json"});

    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = convert.jsonDecode(response.body);
      List<Amigo> users = data.map((data) => Amigo.fromJson(data)).toList();
      print(users);
      return users;
    });
  }

  late AnimationController _animationController;
  late ScrollController controller;
  bool isLoadingSliderDetail = false;
  var sliderImageHieght = 0.0;
  late List data = [];
  late List data2;

  var validChar = [
    "crvga",
    "mmvga",
    "hdpta",
    "mama huevo",
    "mojón",
    "miseria",
    "ladilla",
    "negro",
    "negra",
    "mrda",
    "gusano",
    "puto",
    "maricon",
    "zorro",
    "perra",
    "gay",
    "joto",
    "princeso",
    "mija",
    "hijo de puta",
    "sopa",
    "Arrastracueros",
    "Atarre",
    "baboso",
    "bellaco"
  ];
  void initState() {
    this.getDataTweetuser(widget.iduser);
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

  late List<bool> isLiked;
  @override
  Widget build(BuildContext context) {
    sliderImageHieght = MediaQuery.of(context).size.width * 1.3;
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
              appBar: AppBar(
                  toolbarHeight: 130,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  title: Container(
                      child: Column(children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CameraExampleHome()));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: new LinearGradient(
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Color.fromARGB(255, 139, 77, 58),
                                        ],
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 40,
                        child: isLoadingSliderDetail
                            ? Shimmer.fromColors(
                                baseColor: (Colors.grey[200]!),
                                highlightColor: (Colors.grey[400]!),
                                enabled: isLoadingSliderDetail,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        popular = false;
                                        stories = true;
                                        friends = false;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: stories == true
                                          ? BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  Color(0xfff78361),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )
                                          : BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                      child: Center(
                                        child: Text(
                                          "Eventos",
                                          style: stories == true
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      letterSpacing: 0.6,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)
                                              : Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      letterSpacing: 0.6,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        popular = true;
                                        stories = false;
                                        friends = false;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: popular == true
                                          ? BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  Color(0xfff78361),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )
                                          : BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                      child: Center(
                                        child: Text(
                                          "Tweet",
                                          style: popular == true
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      letterSpacing: 0.6,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)
                                              : Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      letterSpacing: 0.6,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        popular = false;

                                        stories = false;
                                        friends = true;
                                      });

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  sugerenciasScreen(
                                                    idperson: widget.iduser,
                                                    animationController: widget
                                                        .animationController,
                                                  )));
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: friends == true
                                          ? BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  Color(0xfff78361),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            )
                                          : BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                      child: Center(
                                        child: Text(
                                          "Sugerencias",
                                          style: friends == true
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      letterSpacing: 0.6,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)
                                              : Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      letterSpacing: 0.6,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 6, 5, 5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ]))),
              body: Container(
                child: FutureBuilder<List<Amigo>>(
                    future: getDataTweetuser(widget.iduser),
                    builder: (context, data) {
                      if (data.connectionState != ConnectionState.waiting &&
                          data.hasData) {
                        var userList = data.data;
                        return ListView.builder(
                            itemCount: userList!.length,
                            itemBuilder: (context, index) {
                              var userData = userList[index];
                              return Column(
                                children: userData.persona!.tweet!
                                    .map(
                                      (item) => Column(children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.all(5),
                                          elevation: 10,
                                          color: Colors.white,
                                          child: Column(
                                            children: <Widget>[
                                              // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 10,
                                                          bottom: 10),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.person,
                                                          color: Colors.pink,
                                                          size: 30,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              userData.persona!
                                                                  .nombres!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                      letterSpacing:
                                                                          0.6,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          10,
                                                                          10,
                                                                          10)),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Text(
                                                              item.utc!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    letterSpacing:
                                                                        0.6,
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color.fromARGB(
                                                                            255,
                                                                            17,
                                                                            16,
                                                                            16)
                                                                        .withOpacity(
                                                                            0.7),
                                                                  ),
                                                            ),
                                                          ],
                                                        )
                                                      ])),
                                              SizedBox(height: 16),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 4),
                                                    Text(
                                                      item.contenido!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                            letterSpacing: 0.6,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    19,
                                                                    19,
                                                                    19),
                                                            height: 1.5,
                                                          ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 13,
                                                              bottom: 17,
                                                              left: 15,
                                                              right: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          (item.like!
                                                                      .map((e) => e
                                                                          .verificar!)
                                                                      .contains(
                                                                          true) &&
                                                                  item.like!
                                                                      .map((e) => e
                                                                          .idpersona!)
                                                                      .contains(
                                                                          widget
                                                                              .iduser) &&
                                                                  item.like!
                                                                      .map((e) => e
                                                                          .idtweet!)
                                                                      .contains(
                                                                          item.idtweet))
                                                              ? IconButton(
                                                                  icon: const Icon(
                                                                      FontAwesomeIcons
                                                                          .solidHeart,
                                                                      color: Colors
                                                                          .pink),
                                                                  onPressed:
                                                                      () {
                                                                    Like_validacion(
                                                                        widget
                                                                            .iduser,
                                                                        item.idtweet);
                                                                  },
                                                                )
                                                              : IconButton(
                                                                  icon: const Icon(
                                                                      FontAwesomeIcons
                                                                          .solidHeart,
                                                                      color: Colors
                                                                          .grey),
                                                                  onPressed:
                                                                      () {
                                                                    Like_validacion(
                                                                        widget
                                                                            .iduser,
                                                                        item.idtweet);
                                                                  },
                                                                ),
                                                          SizedBox(width: 1),
                                                          Text(
                                                            item.like!.length
                                                                .toString(),
                                                            style:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                      letterSpacing:
                                                                          0.6,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          14,
                                                                          13,
                                                                          13),
                                                                    ),
                                                          ),
                                                          SizedBox(width: 25),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CommentScreen(
                                                                              idTweet: item.idtweet!,
                                                                              idperson: widget.iduser,
                                                                            )),
                                                              );
                                                            },
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .solidCommentDots,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      43,
                                                                      110,
                                                                      46),
                                                              size: 20,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Expanded(
                                                            child: SizedBox(),
                                                          ),
                                                          Stack(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .bottomStart,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  Share.share("*" +
                                                                      userData
                                                                          .persona!
                                                                          .nombres! +
                                                                      " : " +
                                                                      item.contenido!);
                                                                },
                                                                child: Icon(
                                                                  FontAwesomeIcons
                                                                      .share,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Usamos una fila para ordenar los botones del card
                                              SizedBox(height: 9),
                                            ],
                                          ),
                                        ), //Mostrar el titulo principal aqui

                                        //Mostar items
                                      ]),
                                    )
                                    .toList(),
                              );
                            });
                      } else {
                        return ListView(
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            customeCardShimmer(),
                            customeCardShimmer(),
                            customeCardShimmer(),
                          ],
                        );
                      }
                    }),
              ),
            ),
          ),
        );
      },
    );
  }

  Like_validacion(id_person, idtweet) async {
    var url = Uri.parse(
        '${Enviroment.Api_url}proceso/filtrodeLike/$id_person/$idtweet');
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var msg_existente = jsonResponse['msg'];
      var idlike = jsonResponse['idlike'];
      bool validar_like = jsonResponse['validar_like'];
      if (msg_existente == '1' && validar_like == true) {
        var url3 = Uri.parse('${Enviroment.Api_url}like/delete/$idlike');
        Map data2 = {
          'like_verificar': false,
        };

        var body2 = convert.json.encode(data2);
        var response3 = await http.delete(url3);
        if (response3.statusCode == 200) {
          setState(() {
            Fluttertoast.showToast(
                msg: "put con exito false delete..",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          });
        } else {
          print('Falla al conectar al API REST: ${response.statusCode}.');
        }
      } else if (msg_existente == '2' && validar_like == false) {
        var url4 = Uri.parse('${Enviroment.Api_url}like/create');
        Map data4 = {
          "idtweet": idtweet,
          "idpersona": id_person,
          "like_verificar": true
        };
        var body4 = convert.json.encode(data4);
        var response3 = await http.post(url4,
            headers: {"Content-Type": "application/json"}, body: body4);
        if (response3.statusCode == 200) {
          setState(() {
            Fluttertoast.showToast(
                msg: "Like create..",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          });
        } else {
          print('Falla al conectar al API REST: ${response.statusCode}.');
        }
      }
    }
  }

  Widget customeCardShimmer() {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).textTheme.bodyText1!.color,
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 220, 220),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.grey[200],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: 10,
                        width: 100,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: 100,
                  color: Colors.grey[200],
                ),
                SizedBox(height: 4),
                Container(
                  height: 10,
                  width: 200,
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding:
                const EdgeInsets.only(top: 13, bottom: 16, left: 14, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 10,
                  width: 100,
                  color: Color.fromARGB(255, 117, 108, 108),
                ),
                SizedBox(width: 25),
                Container(
                  height: 10,
                  width: 100,
                  color: Color.fromARGB(255, 243, 200, 200),
                ),
                // Expanded(
                //   child: SizedBox(),
                // ),
                // Container(
                //   height: 10,
                //   width: 100,
                //   color: Colors.grey[200],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
Column(
                  children: (item['items'] as List)
                      .map(
                        (subItem) =>
                            // titulo del item aqui
                            Text(subItem['title']),
                      )
                      .toList())
*/ 