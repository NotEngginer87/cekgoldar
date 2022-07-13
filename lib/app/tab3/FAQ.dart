// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../api/ColorsApi.dart';
import '../../api/DatabaseServices.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference faq = firestore.collection('FAQ');


    return Scaffold(
        appBar: AppBar(
          title: const Text('FAQ'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: IsiQueColors.isiqueblue.shade400,
        ),
        body: Container(
            color: IsiQueColors.isiqueblue.shade400,
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child:  ListView(children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: faq.snapshots(),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                            children: snapshot.data.docs
                                .map<Widget>((e) => FAQCARD(
                              e.data()['id'],
                              e.data()['pertanyaan'],
                              e.data()['jawaban'],
                              e.data()['expand'],
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
                  )
                ]),)));
  }
}
class FAQCARD extends StatefulWidget {
  const FAQCARD(this.id, this.pertanyaan, this.jawaban, this.expand, {Key? key})
      : super(key: key);
  final int id;
  final String pertanyaan;
  final String jawaban;
  final bool expand;

  @override
  _FAQCARDState createState() => _FAQCARDState();
}

class _FAQCARDState extends State<FAQCARD> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final email = user!.email;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 12, left: 12, right: 12),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(email.toString())
                  .collection('FAQ')
                  .doc(widget.id.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  bool expand = data['expand'];

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.pertanyaan),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  DatabaseServices.expandFAQ(
                                      widget.id, expand, email!);
                                });
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                      (expand) ? Text(widget.jawaban) : Container(),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )),
    );
  }
}
