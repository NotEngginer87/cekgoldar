// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_local_variable, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/ColorsApi.dart';

class tampilanblog extends StatefulWidget {
  tampilanblog(
    this.id,
    this.bab,
    this.urlgambar, {
    Key? key,
  }) : super(key: key);

  final String? id;
  final String? bab;
  final String? urlgambar;

  @override
  _tampilanblogState createState() => _tampilanblogState();
}

class _tampilanblogState extends State<tampilanblog> {
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
                icon: Icon(Icons.home),
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
                title: Text(
                  widget.bab!,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
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
            .collection('blog')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            String id = data['id'];
            String bab = data['bab'];
            String judul = data['judul'];
            String penulis = data['penulis'];
            bool posting = data['posting'];
            String sumber1 = data['sumber1'];
            String sumber2 = data['sumber2'];
            String sumber3 = data['sumber3'];
            int terbaca = data['terbaca'];
            String urlgambar1 = data['urlgambar1'];
            String urlgambar2 = data['urlgambar2'];
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
            if (sumber1 != '') {
              k3 += 1;
            }
            if (sumber2 != '') {
              k3 += 1;
            }
            if (sumber3 != '') {
              k3 += 1;
            }

            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        bab,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: IsiQueColors.isiqueblue.shade400,),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        judul,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'sudah dibaca : $terbaca kali',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                          Text(
                            'penulis : $penulis',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 8,
                ),
                (k1 > 0)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                (text1 != '')
                                    ? Column(
                                        children: [
                                          Text(
                                            text1,

                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.justify,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                SizedBox(
                  height: 8,
                ),
                (urlgambar2 != '')
                    ? Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 10,
                        child: Image.network(
                          urlgambar2,
                          height: MediaQuery.of(context).size.width - 60,
                          width: MediaQuery.of(context).size.width - 20,
                          fit: BoxFit.fitWidth,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                (k2 > 0)
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                (text7 != '')
                                    ? Column(
                                        children: [
                                          Text(
                                            text7,
                                            textDirection: TextDirection.ltr,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
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
                SizedBox(
                  height: 8,
                ),
                (k3 > 0)
                    ? Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'sumber :',
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            (sumber1 != '')
                                ? Column(
                                    children: [
                                      Text(
                                        sumber1,
                                        style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: IsiQueColors.isiqueblue.shade400,),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  )
                                : Container(),
                            (sumber2 != '')
                                ? Column(
                                    children: [
                                      Text(
                                        sumber2,
                                        style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: IsiQueColors.isiqueblue.shade400,),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  )
                                : Container(),
                            (sumber3 != '')
                                ? Column(
                                    children: [
                                      Text(
                                        sumber3,
                                        style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: IsiQueColors.isiqueblue.shade400,),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
              ],
            );
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
