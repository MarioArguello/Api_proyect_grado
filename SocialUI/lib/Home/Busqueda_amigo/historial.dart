import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialui/Home/TweetSerializer/historialbusquedaserialize.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialui/Profile/otherProfileScreen.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({key, required this.idperson}) : super(key: key);
  final int idperson;
  @override
  _HistorialScreen createState() => _HistorialScreen();
}

class _HistorialScreen extends State<HistorialScreen> {
  bool isLoadingSliderDetail = false;
  void initState() {
    this.getDataHisorial(widget.idperson);
    loadingSliderDetail();
    super.initState();
  }

  Future<List<historial>> getDataHisorial(idusuario_) async {
    print(idusuario_.toString());
    http.Response response = await http.get(
        Uri.parse(
            'http://192.168.56.1:4000/proceso/historialpersona/$idusuario_'), //url
        headers: {"Accept": "application/json"});
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = convert.jsonDecode(response.body);
      List<historial> users =
          data.map((data) => historial.fromJson(data)).toList();
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
    return Expanded(
        child: Container(
      child: FutureBuilder<List<historial>>(
          future: getDataHisorial(widget.idperson),
          builder: (context, data) {
            if (data.connectionState != ConnectionState.waiting &&
                data.hasData) {
              var userList = data.data;
              return ListView.builder(
                  itemCount: userList!.length,
                  itemBuilder: (context, index) {
                    var userData = userList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtheProfileScreen(
                                  profile: 'assets/twitter2.png',
                                  name: userData.persona!.nombres!,
                                  personaBusqueda:
                                      userData.persona!.idpersonahistorial!,
                                  persona: widget.idperson,
                                  correo: userData.persona!.correo!,
                                  username: "Historial",
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/historial_persona.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData.persona!.nombres!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            letterSpacing: 0.6,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 17, 16, 16),
                                          ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      userData.utc!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            letterSpacing: 0.6,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 19, 17, 17)
                                                    .withOpacity(0.3),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              InkWell(
                                onTap: () {
                                  historial_delete(widget.idperson,
                                      userData.idpersonabusqueda!);
                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Color(0xfff78361),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "X",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            letterSpacing: 0.6,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.4),
                          thickness: 2,
                        ),
                      ],
                    );
                  });
            } else {
              return ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  customeShimerCard(),
                  customeShimerCard(),
                  customeShimerCard(),
                  customeShimerCard(),
                ],
              );
            }
          }),
    ));
  }

  historial_delete(id_person, idpersona_busqueda) async {
    var url3 = Uri.parse(
        'http://192.168.56.1:4000/historialpersona/delete/$id_person/$idpersona_busqueda');
    var response3 = await http.delete(url3);
    if (response3.statusCode == 200) {
      setState(() {
        Fluttertoast.showToast(
            msg: "Eliminado del historial.....",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      });
    } else {
      print('Falla al conectar al API REST: ${response3.statusCode}.');
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
