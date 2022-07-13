// ignore_for_file: avoid_print, deprecated_member_use, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class WhatsappSupport extends StatefulWidget {
  const WhatsappSupport({Key? key}) : super(key: key);

  @override
  _WhatsappSupportState createState() => _WhatsappSupportState();
}

class _WhatsappSupportState extends State<WhatsappSupport> {
  launchWhatsApp(String telepon, String text) async {
    final link = WhatsAppUnilink(
      phoneNumber: telepon,
      text: text,
    );
    await launch('$link');
  }

  Widget buildSupportCard(String? telepon, String? text, String? urlgambar,
      String? helptext1, String? helptext2) =>
      Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Ink.image(
          image: NetworkImage('$urlgambar'),
          height: MediaQuery.of(context).size.width / 4,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          child: InkWell(onTap: () {
            print(MediaQuery.of(context).size.width);
            launchWhatsApp(telepon!, text!);
          }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference csupport = firestore.collection('customersupport');
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: StreamBuilder<DocumentSnapshot>(
        stream: csupport.doc('csupport').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

            String? nomor;
            nomor = data['nomortelepon'];
            String? imageurl;
            imageurl = data['image'];
            String? defaultText;
            defaultText = data['text'];
            String? text1;
            text1 = data['helptext1'];
            String? text2;
            text2 = data['helptext2'];

            return buildSupportCard(
                nomor, defaultText, imageurl, text1, text2);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


