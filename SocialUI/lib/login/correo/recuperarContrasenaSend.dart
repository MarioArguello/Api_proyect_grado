import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final key = encrypt.Key.fromUtf8('my 32 length key................');
final iv = encrypt.IV.fromLength(16);
final encrypter =
    encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

sendmainActualizarContrasema(codigo, username_person, correo_persona) async {
  String username = 'arguellocalle@gmail.com';
  String password = 'mariohack16';

  final smtpServer = gmail(username, password);
  final decrypted_code = encrypter.decrypt(codigo, iv: iv);
  // Create our message.
  final message = Message()
    ..from = Address(username, 'Aplicacion Twitter')
    ..recipients.add(correo_persona)
    ..subject = 'Codigo de verificacion ${DateTime.now()}'
    ..text = 'Texto sin formato.'
    ..html =
        "<h1>Codigo: $decrypted_code</h1>\n<h1>Username: $username_person</h1>\n<p>Codigo para cambiar la contraseña.</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
