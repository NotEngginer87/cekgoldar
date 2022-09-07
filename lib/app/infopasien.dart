// ignore_for_file: camel_case_types, prefer_const_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lihatprofil.dart';

class infopasien extends StatefulWidget {
  const infopasien({Key? key}) : super(key: key);

  @override
  _infopasienState createState() => _infopasienState();
}

class _infopasienState extends State<infopasien> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE1001E),
      ),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: StreamBuilder<DocumentSnapshot>(
        stream: userdata.doc(emaila.toString()).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            String? imageUrl = data['imageurl'];

            return Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'hello',
                          style: TextStyle(color: Color(0xFFE1001E),),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'DIABETO',
                      style: GoogleFonts.pathwayGothicOne(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Card(
                          elevation: 4,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            child: (imageUrl == null)
                                ? Image(
                                    image: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/foto_blog%2Fkosong.png?alt=media&token=652482ea-7fa4-451f-913a-912c83d3ebd1'),
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  )
                                : Image(
                                    image: NetworkImage(imageUrl),
                                    height: 48,
                                    width: 48,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return LihatProfil();
                            }));
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
