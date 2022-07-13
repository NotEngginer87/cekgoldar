// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';


class puskesmas extends StatefulWidget {
  const puskesmas({Key? key}) : super(key: key);

  @override
  State<puskesmas> createState() => _puskesmasState();
}

class _puskesmasState extends State<puskesmas> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');
    CollectionReference puskesmas = firestore.collection('listpuskemas');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    return Center(
      child: Column(
        children: [
          Text('hehe'),
          Text('hehe')
        ],
      ),
    );
  }

  launchWhatsApp(String telepon, String text) async {
    final link = WhatsAppUnilink(
      phoneNumber: telepon,
      text: text,
    );
    await launch('$link');
  }
}
