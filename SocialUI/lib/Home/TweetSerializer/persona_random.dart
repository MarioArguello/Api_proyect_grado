class personaRandom {
  int? idpersona;
  String? nombres;
  String? telefono;
  String? correo;
  String? dni;
  String? utc;
  personaRandom(
      {required this.idpersona,
      this.nombres,
      required this.telefono,
      required this.correo,
      required this.dni,
      required this.utc});
  factory personaRandom.fromJson(Map<String, dynamic>? parsedJson) {
    return personaRandom(
        idpersona: parsedJson?['idpersona'],
        nombres: parsedJson?['nombres'],
        telefono: parsedJson?['telefono'],
        correo: parsedJson?['correo'],
        dni: parsedJson?['dni'],
        utc: parsedJson?['utc']);
  }
}
