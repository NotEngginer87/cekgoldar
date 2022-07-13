// ignore_for_file: file_names, prefer_const_constructors, library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/ColorsApi.dart';
import 'Utils/LihatFoto.dart';

class LihatProfil extends StatefulWidget {
  const LihatProfil({Key? key}) : super(key: key);

  @override
  _LihatProfilState createState() => _LihatProfilState();
}

class _LihatProfilState extends State<LihatProfil> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: IsiQueColors.isiqueblue.shade400,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
          color: IsiQueColors.isiqueblue.shade400,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12)),
            ),
            child: StreamBuilder<DocumentSnapshot>(
              stream: userdata.doc(emaila.toString()).snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

                  String nama = data['nama'];
                  String? imageUrl = data['imageurl'];
                  String? email = data['email'];
                  String? alamat = data['alamat'];
                  String? noHP = data['noHP'];
                  String tahun = data['tahun'];
                  int tahunnow = DateTime.now().year;
                  int? year = tahunnow - int.parse(tahun);

                  return Padding(
                    padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Card(
                                elevation: 4,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200),
                                ),
                                child: Hero(
                                    tag: 'foto',
                                    child: Container(
                                      child: (imageUrl == null)
                                          ? Image(
                                        image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/foto_blog%2Fkosong.png?alt=media&token=652482ea-7fa4-451f-913a-912c83d3ebd1'),
                                        height: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.7,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.7,
                                        fit: BoxFit.cover,
                                      )
                                          : Image(
                                        image: NetworkImage(imageUrl),
                                        height: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.7,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.7,
                                        fit: BoxFit.cover,
                                      ),
                                    ))),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return LihatFoto(foto: imageUrl);
                                  }));
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 24, right: 24, bottom: 12, top: 12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'e-mail : ',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(email!),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info,
                                            size: 24,
                                          ),
                                          SizedBox(
                                            width: 24,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nama',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                              Text(nama),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 48,
                                          ),

                                        ],
                                      ),
                                      Text(year.toString() + ' tahun',textAlign: TextAlign.right,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.map,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Alamat : ',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(alamat!),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nomor HP',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(noHP!),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'kalau bisa nomor WA nya ya sanak',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ))
                        ],
                      ),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}

