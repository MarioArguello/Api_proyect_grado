class Usuario {
  String? username;
  Usuario({required this.username});
  factory Usuario.fromJson(Map<String, dynamic>? parsedJson) {
    return Usuario(
      username: parsedJson?['username'] as String,
    );
  }
}

class Persona {
  int? idpersonabusqueda;
  String? nombres;
  String? telefono;
  String? correo;
  String? dni;
  String? utc;
  Usuario? usuario;

  Persona(
      {required this.idpersonabusqueda,
      this.nombres,
      required this.telefono,
      required this.correo,
      required this.dni,
      required this.utc,
      required this.usuario});

  factory Persona.fromJson(Map<String, dynamic>? parsedJson) {
    return Persona(
      idpersonabusqueda: parsedJson?['idpersona'] as int,
      nombres: parsedJson?['nombres'] as String,
      telefono: parsedJson?['telefono'] as String,
      correo: parsedJson?['correo'] as String,
      dni: parsedJson?['dni'] as String,
      utc: parsedJson?['utc'] as String,
      usuario: Usuario.fromJson(parsedJson?['usuario']),
    );
  }
}
