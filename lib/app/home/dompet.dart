
// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';

class dompet extends StatefulWidget {
  const dompet({Key? key}) : super(key: key);

  @override
  State<dompet> createState() => _dompetState();
}

class _dompetState extends State<dompet> {
  @override
  Widget build(BuildContext context) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference pengguna = firestore.collection('user');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final UserEmail = user?.email;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child:  Column(
                            children: [
                              Row(children: [
                                LineIcon.wallet(),
                                const SizedBox(width: 8,),
                                const Text(
                                  'isiquepay',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],),
                              const SizedBox(
                                height: 8,
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                stream: pengguna.doc(UserEmail!).collection('isiquepay').doc('isiquepay').snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    Map<String, dynamic> data =
                                    snapshot.data!.data() as Map<String, dynamic>;

                                    int saldo;
                                    saldo = data['saldo'];
                                    final currencyFormatter = NumberFormat('#,##0.00', 'ID');
                                    return
                                      Text('Rp ${currencyFormatter.format(saldo)}');
                                  }
                      return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ],
                          ),
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child:
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: LineIcon.cashRegister(),
                                iconSize: 24,
                              ),
                              const Text('withdraw'),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: LineIcon.wallet(),
                                iconSize: 24,
                              ),
                              const Text('top up'),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
