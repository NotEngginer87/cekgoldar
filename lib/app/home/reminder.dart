// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:firebase_auth/firebase_auth.dart';

class reminder extends StatefulWidget {
  const reminder({Key? key}) : super(key: key);

  @override
  State<reminder> createState() => _reminderState();
}

class _reminderState extends State<reminder> {
  bool valueNutrisi = false;
  bool valueLatihan = false;
  bool valueFarmako = false;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userdata = firestore.collection('user');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final useremail = user?.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DIA.BETO'),
        centerTitle: true,
        titleTextStyle: GoogleFonts.pathwayGothicOne(
            fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
        backgroundColor: const Color(0xFFE1001E),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
          color: Colors.grey.shade50,
          height: MediaQuery.of(context).size.height,
          child: Container(
              color: const Color(0xFFE1001E),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: userdata
                            .doc(useremail)
                            .collection('Reminder')
                            .snapshots(),
                        builder: (_, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                                children: snapshot.data.docs
                                    .map<Widget>((e) => ReminderCARD(
                                          e.data()['id'],
                                          e.data()['remindername'],
                                          e.data()['reminderdescription'],
                                          e.data()['reminderhour'],
                                          e.data()['reminderminute'],
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
                    ],
                  ),
                ),
              ))),
    );
  }
}

class ReminderCARD extends StatefulWidget {
  const ReminderCARD(this.id, this.remindername, this.reminderdescription,
      this.reminderhour, this.reminderminute,
      {Key? key})
      : super(key: key);

  final int id;
  final String remindername, reminderdescription, reminderhour, reminderminute;
  @override
  State<ReminderCARD> createState() => _ReminderCARDState();
}

class _ReminderCARDState extends State<ReminderCARD> {
  bool valueN = false;
  late String jam, menit;

  late TextEditingController _controller4 ;
  TextEditingController controllerN = TextEditingController();
  TextEditingController controllerJam = TextEditingController();
  TextEditingController controllerMenit = TextEditingController();

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'pt_BR';
    //_initialValue = DateTime.now().toString();

    String lsHour = TimeOfDay.now().hour.toString().padLeft(2, '0');
    String lsMinute = TimeOfDay.now().minute.toString().padLeft(2, '0');
    _controller4 = TextEditingController(text: '$lsHour:$lsMinute');

    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _controller4.text = '17:01';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(
              value: valueN,
              onChanged: (value) {
                setState(() {
                  valueN = value!;
                });
              },
            ),
            Text(widget.remindername),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            controller: controllerN,
            decoration: const InputDecoration(
              labelText: 'isi sesuai yang ingin anda isi'
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
              child: TextFormField(
                controller: controllerJam,
                decoration: const InputDecoration(
                    labelText: 'jam'
                ),
              ),
            ),
            const SizedBox(width: 12,),
            SizedBox(
              width: 32,
              child: TextFormField(
                controller: controllerMenit,
                decoration: const InputDecoration(
                    labelText: 'menit'
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
