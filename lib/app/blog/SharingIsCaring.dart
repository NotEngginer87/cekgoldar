// ignore_for_file: file_names, non_constant_identifier_names, library_private_types_in_public_api, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/DatabaseServices.dart';


class HalamanTulisanUser extends StatefulWidget {
  const HalamanTulisanUser({Key? key}) : super(key: key);

  @override
  State<HalamanTulisanUser> createState() => _HalamanTulisanUserState();
}

class _HalamanTulisanUserState extends State<HalamanTulisanUser> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference SharingIsCaring =
        firestore.collection('SharingIsCaring');
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Pengalaman menarik : ',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
        ),
        StreamBuilder(
          stream: SharingIsCaring.snapshots(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.docs
                    .map<Widget>((e) => SICCard(
                          e.data()['id'],
                          e.data()['judul'],
                          e.data()['penulis'],
                          e.data()['urlgambar1'],
                          e.data()['terbaca'],
                          e.data()['posting'],
                        ))
                    .toList(),
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
        ),
      ]),
    );
  }
}

class SICCard extends StatelessWidget {
  final String? judul;
  final String? penulis;
  final String? urlgambar1;
  final String? id;
  final int terbaca;
  final bool posting;

  const SICCard(
    this.id,
    this.judul,
    this.penulis,
    this.urlgambar1,
    this.terbaca,
    this.posting, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: (posting == true)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                    top: 12,
                    bottom: 12,
                  ),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        child: Ink.image(
                          image: NetworkImage(
                            '$urlgambar1',
                          ),
                          height: 120,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          judul!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          'sudah terbaca : $terbaca',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(),
      onTap: () {
        DatabaseServices.terbacaBlog(id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => tampilanSIC(id, urlgambar1)));
      },
    );
  }
}

class tampilanSIC extends StatefulWidget {
  const tampilanSIC(
    this.id,
    this.urlgambar, {
    Key? key,
  }) : super(key: key);

  final String? id;
  final String? urlgambar;

  @override
  _tampilanSICState createState() => _tampilanSICState();
}

class _tampilanSICState extends State<tampilanSIC> {
  int k1 = 0;
  int k2 = 0;
  int k3 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'blog',
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 24,
              ),
              stretchTriggerOffset: 200,
              foregroundColor: Colors.black,
              expandedHeight: MediaQuery.of(context).size.width,
              collapsedHeight: 56,
              floating: false,
              pinned: true,
              snap: false,
              elevation: 2,
              forceElevated: false,
              stretch: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network(
                  widget.urlgambar!,
                  fit: BoxFit.fitWidth,
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(_buildList()),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> listItems = [];

    listItems.add(Padding(
      padding: const EdgeInsets.all(24),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('SharingIsCaring')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            //String id = data['id'];
            String judul = data['judul'];
            bool posting = data['posting'];
            String narasumber = data['narasumber'];
            String umurnarasumber = data['umurnarasumber'];
            int terbaca = data['terbaca'];
            String text1 = data['text1'];
            String text2 = data['text2'];
            String text3 = data['text3'];
            String text4 = data['text4'];
            String text5 = data['text5'];
            String text6 = data['text6'];
            String text7 = data['text7'];
            String text8 = data['text8'];
            String text9 = data['text9'];
            String text10 = data['text10'];

            if (text1 != '') {
              k1 += 1;
            }
            if (text2 != '') {
              k1 += 1;
            }
            if (text3 != '') {
              k1 += 1;
            }
            if (text4 != '') {
              k1 += 1;
            }
            if (text5 != '') {
              k1 += 1;
            }
            if (text6 != '') {
              k1 += 1;
            }
            if (text7 != '') {
              k2 += 1;
            }
            if (text8 != '') {
              k2 += 1;
            }
            if (text9 != '') {
              k2 += 1;
            }
            if (text10 != '') {
              k2 += 1;
            }
            if (narasumber != '') {
              k3 += 1;
            }
            if (umurnarasumber != '') {
              k3 += 1;
            }

            return (posting == true)
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              judul,
                              style: GoogleFonts.poppins( fontSize: 20),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'sudah dibaca : $terbaca kali',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ],
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'narasumber : $narasumber',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ],
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'umur  : $umurnarasumber',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      (k1 > 0)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      (text1 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text1,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.justify,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text2 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text2,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text3 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text3,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text4 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text4,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text5 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text5,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text6 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text6,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      (k2 > 0)
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      (text7 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text7,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text8 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text8,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text9 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text9,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      (text10 != '')
                                          ? Column(
                                              children: [
                                                Text(
                                                  text10,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  )
                : Container();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));

    return listItems;
  }
}
