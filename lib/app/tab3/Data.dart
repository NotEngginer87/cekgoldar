// ignore_for_file: file_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DataUserCekGoldar extends StatefulWidget {
  const DataUserCekGoldar({Key? key}) : super(key: key);

  @override
  State<DataUserCekGoldar> createState() => _DataUserCekGoldarState();
}

class _DataUserCekGoldarState extends State<DataUserCekGoldar> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final useremail = user?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.pathwayGothicOne(
            fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
        backgroundColor: const Color(0xFFE1001E),
        elevation: 0,
        automaticallyImplyLeading: true,
        actions: const <Widget>[
        ],
      ),
      body: Container(
          color: const Color(0xFFE1001E),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: ListView(children: [
              StreamBuilder<QuerySnapshot>(
                stream: userdata.doc(useremail.toString()).collection('user').snapshots(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data.docs
                            .map<Widget>((e) => datacard(

                          e.data()['nama'],
                          e.data()['jeniskelamin'],
                          e.data()['alamat'],
                          e.data()['nomorHP'],
                          e.data()['golongan darah'],
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
          )),
    );
  }
}



class datacard extends StatelessWidget {
  const datacard(this.nama, this.jeniskelamin, this.alamat,this.nomorHP,this.golongandarah,{Key? key}) : super(key: key);
  final String? nama;
  final String? nomorHP;
  final String? jeniskelamin;
  final String? golongandarah;
  final String? alamat;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 2),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(golongandarah!,style: const TextStyle(fontSize: 24),),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('nama : '),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Text(nama!,textAlign: TextAlign.justify,),
                                ],
                              ),),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('jenis kelamin : '),
                            Text(jeniskelamin!),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('alamat : '),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Text(alamat!,textAlign: TextAlign.justify,),
                              ],
                            ),),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Nomor Telepon : '),
                            Text(nomorHP!),
                          ],
                        ),
                      ),

                    ],
                  ),


                ],
              ),
            )
        ),));
  }
}
