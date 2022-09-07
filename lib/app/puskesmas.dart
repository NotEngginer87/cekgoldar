// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
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
    CollectionReference puskesmas = firestore.collection('listpuskesmas');

    return StreamBuilder<QuerySnapshot>(
      stream: puskesmas.snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder<QuerySnapshot>(
            stream: puskesmas.snapshots(),
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: snapshot.data.docs
                          .map<Widget>((e) => PuskesmasCard(
                                e.data()['id'],
                                e.data()['nama'],
                                e.data()['lokasi'],
                                e.data()['image'],
                                e.data()['kota'],
                                e.data()['cp'],
                                e.data()['goldarA+'],
                                e.data()['goldarA-'],
                                e.data()['goldarB+'],
                                e.data()['goldarB-'],
                                e.data()['goldarAB+'],
                                e.data()['goldarAB-'],
                                e.data()['goldarO+'],
                                e.data()['goldarO-'],
                              ))
                          .toList()),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Center(
                  child: Text('data tidak ditemukan'),
                ),
              ),
            ],
          );
        }
      },
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

class PuskesmasCard extends StatelessWidget {
  final String? id, nama, lokasi, urlimage, kota;
  final String? cp;
  final int goldarAp,
      goldarAm,
      goldarBp,
      goldarBm,
      goldarABp,
      goldarABm,
      goldarOp,
      goldarOm;

  // ignore: prefer_const_constructors_in_immutables
  PuskesmasCard(
    this.id,
    this.nama,
    this.lokasi,
    this.urlimage,
    this.kota,
    this.cp,
    this.goldarAp,
    this.goldarAm,
    this.goldarBp,
    this.goldarBm,
    this.goldarABp,
    this.goldarABm,
    this.goldarOp,
    this.goldarOm, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image(
                  image: NetworkImage(urlimage!),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nama!,
                          style: GoogleFonts.pathwayGothicOne(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Icon(LineIcons.mapMarker),
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                lokasi!,
                                style: GoogleFonts.pathwayGothicOne(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 12, bottom: 12),
                  child: Center(
                    child: Card(
                      elevation: 4,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          launchWhatsApp(cp!,
                              'Halo Admin $nama saya ingin menanyakan sesuatu');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              LineIcons.whatSApp,
                              size: 48,
                              color: Colors.green.shade800,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Row(
                              children: [
                                const Text('Hubungi : '),
                                Text(nama!),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      const Text('Ketersediaan Darah'),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          bloodcard('A + ', goldarAp),
                          bloodcard('B + ', goldarBp),
                          bloodcard('AB + ', goldarABp),
                          bloodcard('O + ', goldarOp),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          bloodcard('A - ', goldarAm),
                          bloodcard('B - ', goldarBm),
                          bloodcard('AB - ', goldarABm),
                          bloodcard('O - ', goldarOm),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
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

class bloodcard extends StatelessWidget {
  const bloodcard(this.text, this.count, {Key? key}) : super(key: key);

  final String text;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        color: const Color(0xFFE1001E),
        width: (MediaQuery.of(context).size.width + 20) / 6,
        height: (MediaQuery.of(context).size.width + 20) / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(
                  Icons.bloodtype,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
