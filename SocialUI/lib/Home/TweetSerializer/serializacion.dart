class Persona {
  String nombres;
  String telefono;
  String correo;
  String dni;

  Persona(
      {required this.nombres,
      required this.telefono,
      required this.correo,
      required this.dni});

  factory Persona.fromJson(Map<String, dynamic> parsedJson) {
    return Persona(
        nombres: parsedJson['nombres'],
        telefono: parsedJson['telefono'],
        correo: parsedJson['correo'],
        dni: parsedJson['dni']);
  }
}

class Tweet {
  int idtweet;
  String contenido;
  String estado;
  Persona persona;
  Tweet(
      {required this.idtweet,
      required this.estado,
      required this.contenido,
      required this.persona});
  factory Tweet.fromJson(Map<String, dynamic> parsedJson) {
    return Tweet(
        idtweet: parsedJson['idtweet'],
        contenido: parsedJson['contenido'],
        estado: parsedJson['estado'],
        persona: Persona.fromJson(parsedJson['persona']));
  }
}
