import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialui/Home/TweetSerializer/persona_random.dart';
import 'package:socialui/Profile/otherProfileScreen.dart';

class sugerenciasScreen extends StatefulWidget {
  const sugerenciasScreen(
      {key, required this.idperson, required this.animationController})
      : super(key: key);
  final int idperson;
  final AnimationController animationController;
  @override
  _sugerenciasScreen createState() => _sugerenciasScreen();
}

Future<List<personaRandom>> getDataHisorial() async {
  http.Response response = await http.get(
      Uri.parse(
          'http://192.168.56.1:4000/proceso/invitarpersona/getaAll'), //url
      headers: {"Accept": "application/json"});
  return await Future.delayed(Duration(seconds: 2), () {
    List<dynamic> data = convert.jsonDecode(response.body);
    List<personaRandom> users =
        data.map((data) => personaRandom.fromJson(data)).toList();
    print(users);
    return users;
  });
}

class _sugerenciasScreen extends State<sugerenciasScreen> {
  bool isLoadingSliderDetail = false;
  var sliderImageHieght = 0.0;
  void initState() {
    getDataHisorial();
    super.initState();
  }

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
                backgroundColor: Colors.white,
                appBar: AppBar(
                    toolbarHeight: 80,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    title: Container(
                        child: Column(children: <Widget>[
                      SizedBox(
                        height: 5,
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
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Text("Sugerencias"),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ]))),
                body: Container(
                  child: FutureBuilder<List<personaRandom>>(
                      future: getDataHisorial(),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.all(15),
                                    elevation: 10,
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OtheProfileScreen(
                                                  profile:
                                                      'assets/twitter2.png',
                                                  name: userData.nombres!,
                                                  personaBusqueda:
                                                      userData.idpersona!,
                                                  persona: widget.idperson,
                                                  correo: userData.correo!,
                                                  username: "Historial",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    'assets/historial_persona.png'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    17,
                                                                    16,
                                                                    16),
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        19,
                                                                        17,
                                                                        17)
                                                                .withOpacity(
                                                                    0.3),
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
                            ],
                          );
                        }
                      }),
                )),
          ),
        );
      },
    );
  }

  Widget customRow(
    String txt1,
    String txt2,
    String img,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(img),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txt1,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 9, 9, 9),
                        ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    txt2,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color:
                              Color.fromARGB(255, 16, 15, 15).withOpacity(0.3),
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Color(0xfff78361),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          thickness: 2,
        ),
      ],
    );
  }

  Widget customRow2(
    String txt1,
    String txt2,
    String img,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
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
