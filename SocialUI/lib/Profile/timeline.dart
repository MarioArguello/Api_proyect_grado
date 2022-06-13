import 'package:socialui/Home/Comment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialui/Home/TweetSerializer/persona_tweet.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialui/Profile/editarTweet.dart';
import 'package:socialui/enviorement/enviroment.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({key, required this.idperson}) : super(key: key);
  final int idperson;
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  bool isLoadingSliderDetail = false;
  void initState() {
    this.getDataTweetuser(widget.idperson);
    loadingSliderDetail();
    super.initState();
  }

  Future<List<Persona3>> getDataTweetuser(idusuario_) async {
    print(idusuario_.toString());
    http.Response response = await http.get(
        Uri.parse(
            '${Enviroment.Api_url}proceso/tweet_persona/$idusuario_'), //url
        headers: {"Accept": "application/json"});
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = convert.jsonDecode(response.body);
      List<Persona3> users =
          data.map((data) => Persona3.fromJson(data)).toList();
      print(users);
      return users;
    });
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
    String? _value = "";
    return Expanded(
        child: Container(
      child: FutureBuilder<List<Persona3>>(
          future: getDataTweetuser(widget.idperson),
          builder: (context, data) {
            if (data.connectionState != ConnectionState.waiting &&
                data.hasData) {
              var userList = data.data;
              return ListView.builder(
                  itemCount: userList!.length,
                  itemBuilder: (context, index) {
                    var userData = userList[index];
                    return Column(
                        children: userData.tweet!
                            .map((item) => Column(children: [
                                  Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(5),
                                      elevation: 10,
                                      color: Colors.white,
                                      child: Column(children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10, bottom: 10),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        userData.nombres!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                letterSpacing:
                                                                    0.6,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
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
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .caption!
                                                                .copyWith(
                                                                  letterSpacing:
                                                                      0.6,
                                                                  fontSize: 11,
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
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  PopupMenuButton(
                                                      color: Colors.white,
                                                      elevation: 20,
                                                      enabled: true,
                                                      onSelected: (value) {
                                                        if (value == 'editar') {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      EditarTweetScreen(
                                                                        idtweet:
                                                                            item.idtweet!,
                                                                        tweet_contenido:
                                                                            item.contenido!,
                                                                      ))).then(
                                                              (value) =>
                                                                  setState(
                                                                      () {}));
                                                          print("editar");
                                                        } else if (value ==
                                                            "eliminar") {
                                                          print("eliminar");
                                                          alertaeliminarTweet(
                                                              item.idtweet);
                                                        }

                                                        // ignore: unnecessary_statements
                                                      },
                                                      itemBuilder: (context) =>
                                                          [
                                                            PopupMenuItem(
                                                              child: Text(
                                                                  "Editar"),
                                                              value: "editar",
                                                            ),
                                                            PopupMenuItem(
                                                              child: Text(
                                                                  "Eliminar"),
                                                              value: "eliminar",
                                                            ),
                                                          ]),
                                                  SizedBox(
                                                    width: 20,
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
                                                      color: Color.fromARGB(
                                                          255, 19, 19, 19),
                                                      height: 1.5,
                                                    ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 13,
                                                    bottom: 17,
                                                    left: 15,
                                                    right: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    (item
                                                                .like!
                                                                .map((e) => e
                                                                    .verificar!)
                                                                .contains(
                                                                    true) &&
                                                            item.like!
                                                                .map((e) => e
                                                                    .idpersona!)
                                                                .contains(widget
                                                                    .idperson) &&
                                                            item.like!
                                                                .map((e) =>
                                                                    e.idtweet!)
                                                                .contains(item
                                                                    .idtweet))
                                                        ? IconButton(
                                                            icon: const Icon(
                                                                FontAwesomeIcons
                                                                    .solidHeart,
                                                                color: Colors
                                                                    .pink),
                                                            onPressed: () {
                                                              Like_validacion(
                                                                  widget
                                                                      .idperson,
                                                                  item.idtweet);
                                                            },
                                                          )
                                                        : IconButton(
                                                            icon: const Icon(
                                                                FontAwesomeIcons
                                                                    .solidHeart,
                                                                color: Colors
                                                                    .grey),
                                                            onPressed: () {
                                                              Like_validacion(
                                                                  widget
                                                                      .idperson,
                                                                  item.idtweet);
                                                            },
                                                          ),
                                                    SizedBox(width: 1),
                                                    Text(
                                                      item.like!.length
                                                          .toString(),
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
                                                              builder: (context) =>
                                                                  CommentScreen(
                                                                    idTweet: item
                                                                        .idtweet!,
                                                                    idperson: widget
                                                                        .idperson,
                                                                  )),
                                                        );
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .solidCommentDots,
                                                        color: Color.fromARGB(
                                                            255, 43, 110, 46),
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
                                                                    .nombres! +
                                                                " : " +
                                                                item.contenido!);
                                                          },
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .share,
                                                            color: Colors.blue,
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
                                      ]))
                                ]))
                            .toList());
                  });
            } else {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  customeShimerCard(),
                  customeShimerCard(),
                  customeShimerCard()
                ],
              );
            }
          }),
    ));
  }

  void alertaeliminarTweet(idtweet) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Alerta !"),
        content: Text("Estas seguro que deseas eliminar tweet?"),
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                print("salir");
                elimar_tweet(idtweet);
                Navigator.of(context).pop();
              },
              child: Text("Eliminar")),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"))
        ],
      ),
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

  elimar_tweet(idtweet_) async {
    var url4 = Uri.parse('${Enviroment.Api_url}tweet/update/$idtweet_');
    Map data4 = {
      "estado": "E",
    };
    var body4 = convert.json.encode(data4);
    var response4 = await http.put(url4,
        headers: {"Content-Type": "application/json"}, body: body4);
    if (response4.statusCode == 200) {
      setState(() {
        Fluttertoast.showToast(
            msg: "Se a eliminado el tweet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      });
    } else {
      print('Falla al conectar al API REST: ${response4.statusCode}.');
    }
  }

  Widget customeShimerCard() {
    return Card(
      elevation: 5,
      shadowColor: Theme.of(context).textTheme.bodyText1!.color,
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Shimmer.fromColors(
              baseColor: (Colors.grey[200]!),
              highlightColor: (Colors.grey[400]!),
              enabled: isLoadingSliderDetail,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 13,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: 13,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Shimmer.fromColors(
              baseColor: (Colors.grey[200]!),
              highlightColor: (Colors.grey[400]!),
              enabled: isLoadingSliderDetail,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 13,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 13,
                    width: 270,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 13,
                    width: 260,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding:
                const EdgeInsets.only(top: 13, bottom: 17, left: 15, right: 15),
            child: Shimmer.fromColors(
              baseColor: (Colors.grey[200]!),
              highlightColor: (Colors.grey[400]!),
              enabled: isLoadingSliderDetail,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 10,
                    width: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 25),
                  Icon(
                    FontAwesomeIcons.solidCommentDots,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 10,
                    width: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 75),
                        child: CircleAvatar(
                          radius: 20,
                          child: CircleAvatar(
                            radius: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: CircleAvatar(
                          radius: 20,
                          child: CircleAvatar(
                            radius: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: CircleAvatar(
                          radius: 20,
                          child: CircleAvatar(
                            radius: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
