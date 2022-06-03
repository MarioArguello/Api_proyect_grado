import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class OtheProfileScreen extends StatefulWidget {
  final String name;
  final String profile;
  final int personaBusqueda;
  final int persona;
  final String username;
  final String correo;
  const OtheProfileScreen(
      {key,
      required this.profile,
      required this.name,
      required this.personaBusqueda,
      required this.persona,
      required this.correo,
      required this.username})
      : super(key: key);

  @override
  _OtheProfileScreenState createState() => _OtheProfileScreenState();
}

class _OtheProfileScreenState extends State<OtheProfileScreen> {
  var data2 = [];
  late bool validar_persona2 = true;
  bool icon1 = true;
  bool icon2 = false;
  bool icon3 = false;
  bool icon4 = false;

  validar_persona_amigo_(idpersona, idamigo) async {
    var url = Uri.parse(
        'http://192.168.56.1:4000/proceso/validar_amigo_persona/$idpersona/$idamigo');
    print(url);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        bool validar_persona = jsonResponse['validar_amigo'];
        if (validar_persona == true) {
          validar_persona2 = true;
          print("si es amigo");
        } else {
          validar_persona2 = false;
          print("no es amigo");
        }
      });
    }
  }

  void initState() {
    this.validar_persona_amigo_(widget.persona, widget.personaBusqueda);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/fondo.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, bottom: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(widget.profile),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                    letterSpacing: 0.6,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 251, 229, 229),
                                  ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.username,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                    letterSpacing: 0.6,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 248, 228, 228)
                                        .withOpacity(0.8),
                                  ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17, left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 20),
                  SizedBox(width: 20),
                  Expanded(child: SizedBox()),
                  Container(
                    height: 40,
                    width: 110,
                    decoration: BoxDecoration(
                      color: validar_persona2
                          ? Color.fromARGB(255, 92, 89, 89)
                          : Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: validar_persona2
                            ? InkWell(
                                onTap: () {
                                  crear_eliminar_amigo_persona(
                                      widget.persona, widget.personaBusqueda);
                                },
                                child: Text(
                                  "Dejar de seguir",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                ))
                            : InkWell(
                                onTap: () {
                                  crear_eliminar_amigo_persona(
                                      widget.persona, widget.personaBusqueda);
                                },
                                child: Text(
                                  "Seguir",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        letterSpacing: 0.6,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                ))),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Correo",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.correo,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Fotos",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/ups3.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/img5.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/img3.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/ups2.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/img7.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Friends",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              letterSpacing: 0.6,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 37,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          AssetImage("assets/ups3.jpg"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 37,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          AssetImage("assets/ups2.jpg"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 37,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          AssetImage("assets/ups1.jpg"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 37,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          AssetImage("assets/ups.jpg"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 37,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          AssetImage("assets/p8.jpg"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  crear_eliminar_amigo_persona(id_person, idpersonaamigo) async {
    if (validar_persona2 == true) {
      print("eliminar");
      var url3 = Uri.parse(
          'http://192.168.56.1:4000/amigo/delete/$id_person/$idpersonaamigo');
      var response3 = await http.delete(url3);
      if (response3.statusCode == 200) {
        setState(() {
          validar_persona2 = false;
          Fluttertoast.showToast(
              msg: "Amigo Eliminado con exito..",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1);
        });
      } else {
        print('Falla al conectar al API REST: ${response3.statusCode}.');
      }
    } else {
      print("crear" +
          id_person.toString() +
          "idamigo : " +
          idpersonaamigo.toString());
      var url4 = Uri.parse('http://192.168.56.1:4000/amigo/create');
      Map data4 = {"idpersona": id_person, "idpersonaamigo": idpersonaamigo};
      var body4 = convert.json.encode(data4);
      var response4 = await http.post(url4,
          headers: {"Content-Type": "application/json"}, body: body4);
      if (response4.statusCode == 200) {
        setState(() {
          validar_persona2 = true;
          Fluttertoast.showToast(
              msg: "Felicidades eres amigo de " + widget.name,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1);
        });
      } else {
        print('Falla al conectar al API REST: ${response4.statusCode}.');
      }
    }
  }
}
