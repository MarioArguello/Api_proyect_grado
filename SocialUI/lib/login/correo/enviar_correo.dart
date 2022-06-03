import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final key = encrypt.Key.fromUtf8('my 32 length key................');
final iv = encrypt.IV.fromLength(16);
final encrypter =
    encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
sendmain(codigo, correo_persona) async {
  String username = 'arguellocalle@gmail.com';
  String password = 'mariohack16';
  // conditions for validating
  final decrypted_code = encrypter.decrypt(codigo, iv: iv);
  print("codigo : " + decrypted_code);
  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Aplicacion twitter')
    ..bccRecipients.add(correo_persona)
    ..subject = 'Codigo de verificacion ${DateTime.now()}'
    ..text = 'Texto sin formato.'
    ..html =
        "<h1>Codigo: $decrypted_code</h1>\n<p>Codigo para verificar en la aplicacion twitter.</p>";

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
