// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class TerimaKasih extends StatefulWidget {
  const TerimaKasih({Key? key}) : super(key: key);

  @override
  State<TerimaKasih> createState() => _TerimaKasihState();
}

class _TerimaKasihState extends State<TerimaKasih> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle KontakButton = ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      minimumSize: Size(MediaQuery.of(context).size.width * 2 / 3, 48),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
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
                    onPressed: () {},
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
                child: const Text('ganteng')
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
                        const Icon(LineIcons.phone),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Download Materi Darah PDF',
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
