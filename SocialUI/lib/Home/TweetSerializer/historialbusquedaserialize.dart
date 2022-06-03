class Persona {
  int? idpersonahistorial;
  String? nombres;
  String? telefono;
  String? correo;
  String? dni;
  Persona(
      {required this.idpersonahistorial,
      this.nombres,
      required this.telefono,
      required this.correo,
      required this.dni});

  factory Persona.fromJson(Map<String, dynamic>? parsedJson) {
    return Persona(
        idpersonahistorial: parsedJson?['idpersona'],
        nombres: parsedJson?['nombres'] as String,
        telefono: parsedJson?['telefono'] as String,
        correo: parsedJson?['correo'] as String,
        dni: parsedJson?['dni'] as String);
  }
}

class historial {
  int? idpersona;
  int? idpersonabusqueda;
  String? utc;
  Persona? persona;
  historial(
      {required this.utc,
      required this.persona,
      required this.idpersona,
      required this.idpersonabusqueda});
  factory historial.fromJson(Map<String, dynamic>? parsedJson) {
    return historial(
        persona: Persona.fromJson(parsedJson?['persona']),
        utc: parsedJson?['utc'] as String,
        idpersona: parsedJson?['idpersona'] as int,
        idpersonabusqueda: parsedJson?['idpersonabusqueda'] as int);
  }
}
