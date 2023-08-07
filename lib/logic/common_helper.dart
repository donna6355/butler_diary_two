import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
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

Future<String?> fetchPhoto(bool forPic) async {
  XFile? image;
  image = await ImagePicker().pickImage(
    source: forPic ? ImageSource.camera : ImageSource.gallery,
    maxWidth: 600,
  );

  if (image == null) return null;
  final appDir = await syspaths.getApplicationDocumentsDirectory();
  final savedImg =
      await File(image.path).copy('${appDir.path}/${DateTime.now().title()}');
  return savedImg.path;
}
