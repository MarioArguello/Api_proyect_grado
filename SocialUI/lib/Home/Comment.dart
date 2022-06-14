import 'package:flutter/material.dart';
import 'package:socialui/Home/TweetSerializer/selializacionComent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialui/enviorement/enviroment.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.idTweet, required this.idperson})
      : super(key: key);
  final int idTweet;
  final int idperson;
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  Future<List<TweetComentario>> getDataComentaioTweet(idTweet) async {
    http.Response response = await http.get(
        Uri.parse(
            '${Enviroment.Api_url}proceso/Comentario_tweet/$idTweet'), //url
        headers: {"Accept": "application/json"});
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = convert.jsonDecode(response.body);
      List<TweetComentario> users =
          data.map((data) => TweetComentario.fromJson(data)).toList();
      return users;
    });
  }

  TextEditingController comentario_contenido = TextEditingController();
  late int idusuario_2;
  late int idusuario;
  Future obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idusuario_2 = preferences.getInt("id_usuariopref") ?? 0;
      setState(() {
        idusuario = idusuario_2;
      });
    });
    return null;
  }

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
  @override
  void initState() {
    obtenerPreferencias();
    this.getDataComentaioTweet(widget.idTweet);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Form(
          key: _formKey,
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2)),
            child: TextFormField(
              style: Theme.of(context).textTheme.caption!.copyWith(
                    letterSpacing: 0.6,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 23, 22, 22).withOpacity(0.3),
                  ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 13),
                border: InputBorder.none,
                hintText: "Comentar",
                hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                      letterSpacing: 0.6,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 13, 12, 12).withOpacity(0.3),
                    ),
                prefixIcon: Icon(
                  FontAwesomeIcons.featherAlt,
                  color: Color.fromARGB(255, 5, 5, 5),
                ),
              ),
              controller: comentario_contenido,
              validator: (value) => value!.isEmpty
                  ? 'Por favor ingresa comentario'
                  : value.length < 7
                      ? 'Ingresa al menos 7 caracteres'
                      : null,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.send, size: 40, color: Colors.blue),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("enviar");
                bool valid = false;
                for (var n in validChar) {
                  print(n);
                  if (comentario_contenido.text.contains(n)) {
                    print("insulto detectado");
                    valid = true;
                  } else {
                    print("sms enviado");
                  }
                }
                if (valid) {
                  Fluttertoast.showToast(
                      msg: "Se detecto insulto ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1);
                  comentario_contenido.clear();
                } else {
                  Fluttertoast.showToast(
                      msg: "Comentario enviado.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1);
                  crear_Comentario(widget.idperson, widget.idTweet,
                      comentario_contenido.text);
                  comentario_contenido.clear();
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: FutureBuilder<List<TweetComentario>>(
            future: getDataComentaioTweet(widget.idTweet),
            builder: (context, data) {
              if (data.connectionState != ConnectionState.waiting &&
                  data.hasData) {
                var userList = data.data;
                return ListView.builder(
                    itemCount: userList!.length,
                    itemBuilder: (context, index) {
                      var userData = userList[index];

                      return Card(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.all(17),
                          elevation: 20,
                          child: Container(
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.only(
                                top: 5,
                                left: 40,
                                right: 20,
                              ),
                              // height: 500,

                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  customRow(
                                    userData.persona.nombres,
                                    userData.utc,
                                    userData.nombre,
                                    "Like",
                                    'assets/coment.png',
                                  ),
                                ],
                              )));
                    });
              } else {
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    customeCardShimmer(),
                    customeCardShimmer(),
                    customeCardShimmer(),
                    customeCardShimmer(),
                  ],
                );
              }
            }),
      ),
    ));
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
            height: 150,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 246, 246),
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
                  color: Colors.grey[200],
                ),
                SizedBox(width: 25),
                Container(
                  height: 10,
                  width: 100,
                  color: Colors.grey[200],
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

  crear_Comentario(id_person_, idtweet, contenido) async {
    var url4 = Uri.parse('${Enviroment.Api_url}comentario/create');
    Map data4 = {
      "idpersona": id_person_,
      "idtweet": idtweet,
      "nombre": contenido,
    };
    var body4 = convert.json.encode(data4);
    var response4 = await http.post(url4,
        headers: {"Content-Type": "application/json"}, body: body4);
    if (response4.statusCode == 200) {
      setState(() {
        Fluttertoast.showToast(
            msg: "Nuevo comentario",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      });
    } else {
      print('Falla al conectar al API REST: ${response4.statusCode}.');
    }
  }

  Widget customRow(
    String txt1,
    String txt2,
    String txt3,
    String txt4,
    String img,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(img),
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 230,
                        child: Text(
                          txt1,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 18, 15, 15),
                              ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Text(
                        txt2,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color:
                                  Color.fromARGB(255, 5, 5, 5).withOpacity(0.4),
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 230,
                        child: Text(
                          txt3,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 18, 16, 16),
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          txt4,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                letterSpacing: 0.6,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Divider(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          thickness: 2,
        ),
      ],
    );
  }
}
