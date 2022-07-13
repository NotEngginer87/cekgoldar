import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/DatabaseServices.dart';
import 'videoplayer.dart';

class HalamanVideo extends StatefulWidget {
  const HalamanVideo({Key? key}) : super(key: key);

  @override
  State<HalamanVideo> createState() => _HalamanVideoState();
}

class _HalamanVideoState extends State<HalamanVideo> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference video = firestore.collection('videopembelajaran');
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Video terpopuler : ',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
        ),
        StreamBuilder<QuerySnapshot>(
          stream:
              video.orderBy('ditonton', descending: true).limit(5).snapshots(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: snapshot.data.docs
                        .map<Widget>((e) => VideoPopulerCard(
                              e.data()['id'],
                              e.data()['judul'],
                              e.data()['kreator'],
                              e.data()['ditonton'],
                              e.data()['like'],
                              e.data()['banyakkomentar'],
                              e.data()['link'],
                              e.data()['thumbnail'],
                              e.data()['posting'],
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
        const SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Video terbaru : ',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: video.snapshots(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                  children: snapshot.data.docs
                      .map<Widget>((e) => VideoCard(
                            e.data()['id'],
                            e.data()['judul'],
                            e.data()['kreator'],
                            e.data()['ditonton'],
                            e.data()['like'],
                            e.data()['banyakkomentar'],
                            e.data()['link'],
                            e.data()['thumbnail'],
                            e.data()['posting'],
                          ))
                      .toList());
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

class VideoCard extends StatelessWidget {
  final String? id;
  final String? judul, kreator;
  final int like, banyakkomentar, ditonton;
  final String link, thumbnail;
  final bool posting;

  // ignore: prefer_const_constructors_in_immutables
  VideoCard(
    this.id,
    this.judul,
    this.kreator,
    this.ditonton,
    this.like,
    this.banyakkomentar,
    this.link,
    this.thumbnail,
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
                    left: 2,
                    right: 2,
                  ),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
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
                                        thumbnail,
                                      ),
                                      colorFilter: const ColorFilter.mode(
                                          Colors.grey, BlendMode.softLight),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                DatabaseServices.videoditonton(id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoApp(
                                              id,
                                              judul,
                                              kreator,
                                              ditonton,
                                              like,
                                              banyakkomentar,
                                              link,
                                              thumbnail,
                                              posting,
                                            )));
                              }))),
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
                    judul!,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'kreator : $kreator',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'sudah ditonton : $ditonton',
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
        DatabaseServices.videoditonton(id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoApp(
                      id,
                      judul,
                      kreator,
                      ditonton,
                      like,
                      banyakkomentar,
                      link,
                      thumbnail,
                      posting,
                    )));
      },
    );
  }
}

class VideoPopulerCard extends StatelessWidget {
  final String? id;
  final String? judul, kreator;
  final int like, banyakkomentar, ditonton;
  final String link, thumbnail;
  final bool posting;

  // ignore: prefer_const_constructors_in_immutables
  VideoPopulerCard(
    this.id,
    this.judul,
    this.kreator,
    this.ditonton,
    this.like,
    this.banyakkomentar,
    this.link,
    this.thumbnail,
    this.posting, {
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
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
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
                                      thumbnail,
                                    ),
                                    colorFilter: const ColorFilter.mode(
                                        Colors.grey, BlendMode.softLight),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              DatabaseServices.videoditonton(id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoApp(
                                            id,
                                            judul,
                                            kreator,
                                            ditonton,
                                            like,
                                            banyakkomentar,
                                            link,
                                            thumbnail,
                                            posting,
                                          )));
                            }))),
              )
            : Container(),
      ],
    );
  }
}
