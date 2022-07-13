
// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api/ColorsApi.dart';
import 'app/HalamanRumah/HalamanRumah.dart';
import 'onboard2.0/introduction_animation_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);


  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,

    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ControllerAuth(),
    );
  }
}

class ControllerAuth extends StatelessWidget {
  ControllerAuth({Key? key}) : super(key: key);

  late int versiappbawaan = 1;
  late int versiapp2bawaan = 0;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference versiaplikasi = firestore.collection('versi aplikasi');
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
              stream: versiaplikasi.doc('versiapp').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

                  int versiapp = data['versiapp'];
                  int versiapp2 = data['versiapp2'];
                  bool perluupdate = data['perluupdate'];
                  int countversiserver = versiapp * 100 + versiapp2;
                  int countversiapp = versiappbawaan * 100 + versiapp2bawaan;

                  if (countversiserver >= countversiapp) {
                    if (perluupdate == false) {
                      return const HalamanRumah();
                    } else {
                      return Scaffold(
                        appBar: AppBar(
                          title: const Text('update aplikasi'),
                          backgroundColor: IsiQueColors.isiqueblue.shade400,
                          elevation: 0,
                          centerTitle: true,
                        ),
                        body: Center(
                            child: Column(
                              children: [
                                const Text('aplikasi anda belum update !!!'),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text('Update aplikasi anda di playstore !!!'),
                                const Text('aplikasi anda belum update !!!'),
                                ElevatedButton(
                                  child: const Text('update'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            )),
                      );
                    }
                  }
                }
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('update aplikasi'),
                    backgroundColor: IsiQueColors.isiqueblue.shade400,
                    elevation: 0,
                    centerTitle: true,
                  ),
                  body: Center(
                      child: Column(
                        children: [
                          const Text('aplikasi anda belum update !!!'),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text('Update aplikasi anda di playstore !!!'),
                          const Text('aplikasi anda belum update !!!'),
                          ElevatedButton(
                            child: const Text('update'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )),
                );
              },
            );
          } else {
            return const OnBoardScreen();
          }
        });
  }
}
