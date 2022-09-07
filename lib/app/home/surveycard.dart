// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class surveycard extends StatefulWidget {
  const surveycard(this.id, this.judul, this.deskripsisurvey, this.halaman,
      {Key? key})
      : super(key: key);

  final String id;
  final String judul;
  final String deskripsisurvey;
  final int halaman;

  @override
  State<surveycard> createState() => _surveycardState();
}

class _surveycardState extends State<surveycard> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference listsurvey = firestore.collection('ListSurvey');

    final ButtonStyle Buttonstyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: const Color(0xFFE1001E),
      elevation: 0,
      textStyle: const TextStyle(fontWeight: FontWeight.w900),
      minimumSize: const Size(96, 48),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
          clipBehavior: Clip.antiAlias,
          color: const Color(0xFFE1001E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.judul,
                          style: const TextStyle(fontSize: 18,color: Colors.white),
                          textAlign: TextAlign.left,

                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: listsurvey.doc(widget.id).snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              int setjam, setmnt;
                              setjam = data['setjam'];
                              setmnt = data['setmnt'];
                              int nowjam, nowmnt;
                              nowjam = DateTime.now().hour;
                              nowmnt = DateTime.now().minute;


                              int counthour = setjam - nowjam;
                              int countminute = setmnt - nowmnt;

                              return Row(
                                children: [
                                  const Text('Berakhir dalam hari ',style: TextStyle(color: Colors.white),),
                                  Text('$counthour jam ',style: const TextStyle(color: Colors.white),),
                                  Text('$countminute menit ',style: const TextStyle(color: Colors.white),),
                                ],
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: Buttonstyle,

                              onPressed: () {}, child: const Text('Jawab Survey')),
                        )
                      ],
                    ),
                  )))),
    );
  }
}
