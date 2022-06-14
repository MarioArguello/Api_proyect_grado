import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialui/Home/TweetSerializer/serializacionPerfil.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:socialui/Profile/otherProfileScreen.dart';
import 'package:socialui/enviorement/enviroment.dart';

class amigos_busqueda_datosScreen extends StatefulWidget {
  const amigos_busqueda_datosScreen(
      {key, required this.idperson, required this.nombre_person})
      : super(key: key);
  final int idperson;
  final String nombre_person;
  @override
  _amigos_busqueda_datosScreen createState() => _amigos_busqueda_datosScreen();
}

class _amigos_busqueda_datosScreen extends State<amigos_busqueda_datosScreen> {
  bool isLoadingSliderDetail = false;
  void initState() {
    this.getDatabusquedaPersona(widget.nombre_person);

    loadingSliderDetail();
    super.initState();
  }

  Future<List<Persona>> getDatabusquedaPersona(nombre_person) async {
    print(nombre_person.toString());

    http.Response response = await http.get(
        Uri.parse(
            '${Enviroment.Api_url}proceso/busqueda_nombre/$nombre_person'), //url
        headers: {"Accept": "application/json"});
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = convert.jsonDecode(response.body);
      List<Persona> users = data.map((data) => Persona.fromJson(data)).toList();
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
      child: FutureBuilder<List<Persona>>(
          future: getDatabusquedaPersona(widget.nombre_person),
          builder: (context, data) {
            if (data.connectionState != ConnectionState.waiting &&
                data.hasData) {
              var userList = data.data;
              return ListView.builder(
                  itemCount: userList!.length,
                  itemBuilder: (context, index) {
                    var userData = userList[index];
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.all(5),
                        elevation: 10,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                crear_historial(widget.idperson,
                                    userData.idpersonabusqueda!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtheProfileScreen(
                                      profile: 'assets/twitter2.png',
                                      name: userData.nombres!,
                                      personaBusqueda:
                                          userData.idpersonabusqueda!,
                                      persona: widget.idperson,
                                      correo: userData.correo!,
                                      username: userData.usuario!.username!,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                        'assets/historial_persona.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userData.nombres!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                letterSpacing: 0.6,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 17, 16, 16),
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
                                                color: Color.fromARGB(
                                                        255, 19, 17, 17)
                                                    .withOpacity(0.3),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
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
                        ));
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

  crear_historial(id_person_, idpersona_busqueda) async {
    var url4 = Uri.parse('${Enviroment.Api_url}historialpersona/create');
    Map data4 = {
      "idpersona": id_person_,
      "idpersonabusqueda": idpersona_busqueda
    };
    var body4 = convert.json.encode(data4);
    var response4 = await http.post(url4,
        headers: {"Content-Type": "application/json"}, body: body4);
    if (response4.statusCode == 200) {
      print("Nuevo historial. perfect");
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
                      Container(
                        height: 13,
                        width: 150,
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
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                  Container(
                    height: 13,
                    width: 100,
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
