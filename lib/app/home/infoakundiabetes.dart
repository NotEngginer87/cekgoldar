
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/ColorsApi.dart';

class InfoAkunDiabetes extends StatefulWidget {
  const InfoAkunDiabetes({Key? key}) : super(key: key);

  @override
  State<InfoAkunDiabetes> createState() => _InfoAkunDiabetesState();
}

class _InfoAkunDiabetesState extends State<InfoAkunDiabetes> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final useremail = user!.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Akun'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.pathwayGothicOne(
            fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
        backgroundColor: IsiQueColors.isiqueblue.shade400,
        elevation: 0,
        automaticallyImplyLeading: true,

      ),
      body: Container(
          color: Colors.grey.shade50,
          height: MediaQuery.of(context).size.height,
          child:Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                  child: Card(
                      elevation: 4,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(
                              height: 8,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                              stream: userdata.doc(useremail.toString()).snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                                  int banyakukurstatusdiabetes = data['banyakukurstatusdiabetes'];

                                  return StreamBuilder<DocumentSnapshot>(
                                    stream: userdata.doc(useremail.toString()).collection('Status').doc(banyakukurstatusdiabetes.toString()).snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        Map<String, dynamic> data =
                                        snapshot.data!.data() as Map<String, dynamic>;

                                        int gdp = data['gdp'];
                                        int gds = data['gds'];
                                        int ttgo = data['ttgo'];
                                        bool poliuri = data['poliuri'];
                                        bool polidipsi = data['polidipsi'];
                                        bool polifagi = data['polifagi'];
                                        String textpoliuri, textpolidipsi, textpolifagi;
                                        textpoliuri = (poliuri == true) ?  'ya' :  'tidak';
                                        textpolidipsi = (polidipsi == true) ?  'ya' :  'tidak';
                                        textpolifagi = (polifagi == true) ?  'ya' :  'tidak';

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, right: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Gula Darah Puasa: ',
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [

                                                      Text(
                                                        gdp.toString(),
                                                        style: GoogleFonts.pathwayGothicOne(
                                                            fontWeight: FontWeight.w500, fontSize: 20),
                                                      ),
                                                      Text(
                                                        ' mg/dL',
                                                        style: GoogleFonts.pathwayGothicOne(
                                                            fontWeight: FontWeight.w500, fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, right: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Gula Darah Sewaktu: ',
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [

                                                      Text(
                                                        gds.toString(),
                                                        style: GoogleFonts.pathwayGothicOne(
                                                            fontWeight: FontWeight.w500, fontSize: 20),
                                                      ),
                                                      Text(
                                                        ' mg/dL',
                                                        style: GoogleFonts.pathwayGothicOne(
                                                            fontWeight: FontWeight.w500, fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, right: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Gula Darah TTGO: ',
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),

                                                  Row(
                                                    children: [

                                                      Text(
                                                        ttgo.toString(),
                                                        style: GoogleFonts.pathwayGothicOne(
                                                            fontWeight: FontWeight.w500, fontSize: 20),
                                                      ),

                                                      Text(
                                                        ' mg/dL',
                                                        style: GoogleFonts.pathwayGothicOne(
                                                            fontWeight: FontWeight.w500, fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, right: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Sering Berkemih : ',
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                  Text(
                                                    textpoliuri,
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, right: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Rasa haus terus menerus : ',
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                  Text(
                                                    textpolidipsi,
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4, right: 4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Makan berlebihan : ',
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                  Text(
                                                    textpolifagi,
                                                    style: GoogleFonts.pathwayGothicOne(
                                                        fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        );
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )
                  )),
            ],
          )),

    );
  }
}
