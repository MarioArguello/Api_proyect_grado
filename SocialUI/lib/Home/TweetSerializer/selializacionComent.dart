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

class TweetComentario {
  int idtweet;
  int idcomentario;
  String nombre;
  String utc;
  Persona persona;
  TweetComentario(
      {required this.idcomentario,
      required this.idtweet,
      required this.nombre,
      required this.utc,
      required this.persona});
  factory TweetComentario.fromJson(Map<String, dynamic> parsedJson) {
    return TweetComentario(
        idtweet: parsedJson['idtweet'],
        idcomentario: parsedJson['idcomentario'],
        nombre: parsedJson['nombre'],
        utc: parsedJson['utc'],
        persona: Persona.fromJson(parsedJson['persona']));
  }
}
