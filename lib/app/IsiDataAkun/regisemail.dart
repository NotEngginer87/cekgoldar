// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../api/AuthServices.dart';
import '../../api/ColorsApi.dart';
import '../HalamanRumah/HalamanRumah.dart';
import 'isidata.dart';

class RegisEmailScreen extends StatefulWidget {
  const RegisEmailScreen({Key? key}) : super(key: key);

  @override
  _RegisEmailScreenState createState() => _RegisEmailScreenState();
}

class _RegisEmailScreenState extends State<RegisEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).size.width) /
                                3),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Image.asset(
                            'assets/onboard/Logo transparan.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StreamBuilder(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Builder(
                                  builder: (context) {
                                    final GlobalKey<SlideActionState> key =
                                        GlobalKey();
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SlideAction(
                                        outerColor:
                                            IsiQueColors.isiqueblue.shade400,
                                        innerColor: Colors.white,
                                        key: key,
                                        text:
                                            "Let's Controll Diabetic Until Zero",
                                        textStyle: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                        onSubmit: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return const IsiData();
                                          }));
                                          Future.delayed(
                                            const Duration(seconds: 1),
                                            () => key.currentState?.reset(),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return InkWell(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 48,
                                    child: Card(
                                      color: IsiQueColors.isiqueblue.shade400,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 12,
                                            bottom: 12),
                                        child: Text(
                                          'Masuk dengan Akun Google',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    AuthServices.signInWithGoogle();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const HalamanRumah();
                                    }));
                                  },
                                );
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
