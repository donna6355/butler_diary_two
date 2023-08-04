import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../core/core.dart';

String ageCalc(DateTime birth) {
  DateTime now = DateTime.now();

  int years = now.year - birth.year;
  int months = now.month - birth.month;
  int days = now.day - birth.day;

  if (months < 0 || (months == 0 && days < 0)) {
    years--;
    months += (days < 0 ? 11 : 12);
  }

  return years > 0 ? '$years년 $months개월' : '$months개월';
}

void sendEmail(context) async {
  final Email email = Email(
    body: Lang.freeToDev,
    subject: Lang.toDev,
    recipients: [Lang.devMail],
  );
  try {
    await FlutterEmailSender.send(email);
  } catch (err) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(Lang.failToSend),
            content: const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ListBody(
                children: <Widget>[
                  Text(Lang.failAtMailSender),
                  SizedBox(height: 15),
                  Text(Lang.devMail),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(Lang.confirm),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }
}
