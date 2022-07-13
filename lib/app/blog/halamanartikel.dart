import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/DatabaseServices.dart';
import 'tampilanblog.dart';




class HalamanArtikel extends StatefulWidget {
  const HalamanArtikel({Key? key}) : super(key: key);

  @override
  State<HalamanArtikel> createState() => _HalamanArtikelState();
}

class _HalamanArtikelState extends State<HalamanArtikel> {
  @override
  Widget build(BuildContext context) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference blog = firestore.collection('blog');
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Artikel terpopuler : ',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: blog
                  .orderBy('terbaca', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: snapshot.data.docs
                            .map<Widget>((e) => BlogPopulerCard(
                          e.data()['id'],
                          e.data()['urlgambar1'],
                          e.data()['bab'],
                          e.data()['posting'],
                          e.data()['penulis'],
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
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Artikel terbaru : ',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
            ),
            StreamBuilder(
              stream: blog.snapshots(),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.docs
                        .map<Widget>((e) => BlogCard(
                      e.data()['id'],
                      e.data()['bab'],
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
          ]
      ),
    );
  }
}

class BlogPopulerCard extends StatelessWidget {
  final String? urlgambar1;
  final String? bab;
  final String? id;
  final bool posting;
  final String penulis;

  // ignore: prefer_const_constructors_in_immutables
  BlogPopulerCard(
      this.id,
      this.urlgambar1,
      this.bab,
      this.posting,
      this.penulis,{
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (posting == true)
            ? Padding(
          padding: const EdgeInsets.only(
            left: 2,
            right: 2,
          ),
          child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: InkWell(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            child: Ink.image(
                              image: NetworkImage(
                                '$urlgambar1',
                              ),
                              colorFilter: const ColorFilter.mode(
                                  Colors.grey, BlendMode.softLight),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        DatabaseServices.terbacaBlog(id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    tampilanblog(id, bab, urlgambar1)));
                      }))),
        )
            : Container(),
      ],
    );
  }
}

class BlogCard extends StatelessWidget {
  final String? bab;
  final String? judul;
  final String? penulis;
  final String? urlgambar1;
  final String? id;
  final int terbaca;
  final bool posting;

  const BlogCard(
      this.id,
      this.bab,
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
      child: Row(
        children: [
          (posting == true)
              ? Padding(
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
          )
              : Container(),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    bab!,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
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
                    'penulis : $penulis',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'sudah terbaca : $terbaca',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        DatabaseServices.terbacaBlog(id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => tampilanblog(id, bab, urlgambar1)));
      },
    );
  }
}
