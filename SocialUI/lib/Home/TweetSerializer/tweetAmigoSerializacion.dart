class Like {
  int? idpersona;
  bool? verificar;
  int? idtweet;
  Like(
      {required this.verificar,
      required this.idpersona,
      required this.idtweet});
  factory Like.fromJson(Map<String, dynamic>? parsedJson) {
    return Like(
        verificar: parsedJson?['like_verificar'] as bool?,
        idpersona: parsedJson?['idpersona'] as int,
        idtweet: parsedJson?['idtweet'] as int);
  }
}

class Tweet {
  int? idtweet;
  String? contenido;
  String? estado;
  String? utc;
  List<Like>? like;
  Tweet(
      {required this.like,
      required this.idtweet,
      required this.contenido,
      required this.utc,
      required this.estado});
  factory Tweet.fromJson(Map<String, dynamic>? json) {
    var list = json?['likes'] as List;
    List<Like> like2 = list.map((i) => Like.fromJson(i)).toList();
    return Tweet(
        idtweet: json?['idtweet'],
        utc: json?['utc'],
        contenido: json?['contenido'],
        estado: json?['estado'],

        // ignore: unnecessary_null_comparison
        like: like2);
  }
}

class Persona2 {
  int? idpersona;
  String? nombres;
  String? telefono;
  String? correo;
  String? dni;
  List<Tweet>? tweet;
  Persona2(
      {required this.idpersona,
      this.nombres,
      required this.telefono,
      required this.correo,
      required this.dni,
      required this.tweet});
  factory Persona2.fromJson(Map<String, dynamic>? parsedJson) {
    var list = parsedJson?['tweets'] as List;
    List<Tweet>? tweet2 = list.map((i) => Tweet.fromJson(i)).toList();
    return Persona2(
        idpersona: parsedJson?['idpersona'],
        nombres: parsedJson?['nombres'],
        telefono: parsedJson?['telefono'],
        correo: parsedJson?['correo'],
        dni: parsedJson?['dni'],
        tweet: tweet2);
  }
}

class Amigo {
  String? estado;
  Persona2? persona;
  Amigo({required this.estado, required this.persona});
  factory Amigo.fromJson(Map<String, dynamic>? parsedJson) {
    return Amigo(
        estado: parsedJson?['estado'],
        persona: Persona2.fromJson(parsedJson?['persona']));
  }
}
