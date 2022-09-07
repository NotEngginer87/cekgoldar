// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_local_variable, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

const String _url = 'https://www.instagram.com/admin_ident/';

class kontak extends StatelessWidget {
  const kontak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _callNumber() async {
      const number = '+628176899355'; //set the number here
      bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    }

    final ButtonStyle KontakButton = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: Colors.white,
      minimumSize: Size(MediaQuery.of(context).size.width * 2 / 3, 48),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    launchWhatsApp(String telepon, String text) async {
      final link = WhatsAppUnilink(
        phoneNumber: telepon,
        text: text,
      );
      await launch('$link');
    }

    void _launchInstagram() async {
      if (!await launch(_url)) throw 'Could not launch $_url';
    }

    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Kontak Admin Blood Type Checker',
            style: GoogleFonts.pathwayGothicOne(
                fontWeight: FontWeight.w500, fontSize: 20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 7 / 8,
                child: ElevatedButton(
                    style: KontakButton,
                    onPressed: () {
                      launchWhatsApp('+628176899355',
                          'Halo Admin Dia.Beto, saya ingin menanyakan sesuatu');
                    },
                    child: Row(
                      children: [
                        const Icon(LineIcons.whatSApp),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'WhatsApp',
                          style: GoogleFonts.pathwayGothicOne(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 12,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 7 / 8,
                child: ElevatedButton(
                    style: KontakButton,
                    onPressed: () {
                      _launchInstagram();
                    },
                    child: Row(
                      children: [
                        const Icon(LineIcons.instagram),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Instagram',
                          style: GoogleFonts.pathwayGothicOne(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 7 / 8,
                child: ElevatedButton(
                    style: KontakButton,
                    onPressed: () {
                      _callNumber();
                    },
                    child: Row(
                      children: [
                        const Icon(LineIcons.phone),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Telepon',
                          style: GoogleFonts.pathwayGothicOne(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 7 / 8,
                child: ElevatedButton(
                    style: KontakButton,
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.mail),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'yn.zuhal28@gmail.com',
                          style: GoogleFonts.pathwayGothicOne(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
