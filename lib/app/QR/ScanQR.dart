// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pkmzuhal/api/DatabaseServices.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';


class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  TextEditingController nama = TextEditingController();
  TextEditingController noHP = TextEditingController();
  TextEditingController umurcontrol = TextEditingController();
  TextEditingController alamat = TextEditingController();

  late bool switchnama = false;
  late bool switchgender = false;
  late bool switchumur = false;
  late bool switchnotelepon = false;
  late bool switchalamat = false;
  late bool switchnikah = false;
  late bool switchagama = false;
  late bool switchpekerjaan = false;
  late bool switchsuku = false;
  late bool switchkeluhan = false;
  late bool switchfoto = false;
  late bool consent = false;

  String? tanggal, bulan, tahun;
  String? gender;

  String? genderr;

  int? umur;
  int? tanggalawal = 0, bulanawal = 0, tahunawal = 0;

  bool? switchimpor;

//////////////////////////////////////////////////////
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference console = firestore.collection('console');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final useremail = user?.email;

    const String url = 'https://drive.google.com/file/d/1BUdlCvgmFK54FieXmDaxlljE8H9vISQX/view?usp=sharing';
    void _launchURL() async {
      if (!await launch(url)) throw 'Could not launch $url';
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: (result != null)
          ? Center(
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: ListView(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.white38,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 64,
                      color: Colors.red.shade50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            LineIcons.questionCircle,
                            size: 24,
                            color: Colors.red.shade500,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Mohon untuk mengisi data berikut dengan baik dan benar, demi terpenuhinya darah untuk Indonesia',
                              style: TextStyle(
                                  color: Colors.red.shade500, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text('Golongan Darah :  '),
                      Text(
                        '${result?.code}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: nama,
                        onChanged: (value) {
                          setState(() {
                            switchnama = true;
                          });
                        },
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          //add prefix icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          fillColor: Colors.grey,

                          //create lable
                          labelText: 'Nama',
                          //lable style
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Jenis Kelamin : ',
                        textAlign: TextAlign.left,
                      ),
                      GenderPickerWithImage(
                        showOtherGender: false,
                        verticalAlignedText: true,
                        equallyAligned: true,

                        selectedGenderTextStyle: const TextStyle(
                            color: Color(0xFF8b32a8),
                            fontWeight: FontWeight.bold),
                        unSelectedGenderTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                        selectedGender: (genderr == 'Laki-Laki')
                            ? Gender.Male
                            : (genderr == 'Perempuan')
                                ? Gender.Female
                                : null,
                        onChanged: (Gender) async {
                          switchgender = true;

                          if (Gender?.index == 0) {
                            genderr = 'Laki-Laki';
                          } else {
                            genderr = 'Perempuan';
                          }
                          if (kDebugMode) {
                            print(Gender?.index);
                          }
                        },
                        animationDuration: const Duration(milliseconds: 300),
                        isCircular: true,
                        // default : true,
                        opacityOfGradient: 0.4,
                        padding: const EdgeInsets.all(3),
                        size: 80,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: umurcontrol,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            switchumur = true;
                          });
                        },
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          //add prefix icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          fillColor: Colors.grey,

                          //create lable
                          labelText: 'Umur',
                          //lable style
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: noHP,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            switchnotelepon = true;
                          });
                        },
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          //add prefix icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          fillColor: Colors.grey,

                          //create lable
                          labelText: 'Nomor Telepon',
                          //lable style
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: alamat,
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (value) {
                          setState(() {
                            switchalamat = true;
                          });
                        },
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          //add prefix icon
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          fillColor: Colors.grey,

                          //create lable
                          labelText: 'Alamat',
                          //lable style
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: console
                              .doc('nomorantriangolongandarah')
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              int count = data['count'];

                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE1001E),
                                      foregroundColor: Colors
                                          .white, // foreground (text) color
                                    ),
                                    onPressed: () {
                                      DatabaseServices.inccountgolongandarah();
                                      DatabaseServices
                                          .setdatagolongandarahorang(
                                              count,
                                              nama.text,
                                              genderr,
                                              noHP.text,
                                              alamat.text,
                                              result?.code);
                                      DatabaseServices
                                          .setdatagolongandarahorangperuser(
                                              count,
                                              useremail!,
                                              nama.text,
                                              genderr,
                                              noHP.text,
                                              alamat.text,
                                              result?.code);
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text(
                                              "Kontak Admin Blood Type Checker"),
                                          content: const Text(
                                              "Terima kasih sudah melakukan cek golongan darah, jika anda ingin membaca materi mengenai darah, bisa download lewat tombol berikut",
                                              textAlign: TextAlign.justify),
                                          actions: <Widget>[
                                            Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      result = null;

                                                      Navigator.pop(ctx);
                                                      nama.text = '';
                                                      umurcontrol.text = '';
                                                      alamat.text = '';
                                                      noHP.text = '';
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .pressed)) {
                                                            return const Color(
                                                                0xFFE1001E);
                                                          }
                                                          return Colors
                                                              .white; // Use the component's default.
                                                        },
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Kembali",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFFE1001E)),
                                                    )),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _launchURL();
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .pressed)) {
                                                            return Colors.white;
                                                          }
                                                          return const Color(
                                                              0xFFE1001E); // Use the component's default.
                                                        },
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Download",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            )),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Kirim',
                                      style: TextStyle(fontSize: 14),
                                    )),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ))
          : Column(
              children: <Widget>[
                Expanded(flex: 6, child: _buildQrView(context)),
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (result != null)
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                        else
                          const Text('Scan Golongan Darah'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Card(
                                elevation: 0,
                                color: Colors.grey.shade400,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    return IconButton(
                                      onPressed: () async {
                                        await controller?.toggleFlash();
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        LineIcons.lightningBolt,
                                        color: (snapshot.data!)
                                            ? Colors.yellow
                                            : Colors.black,
                                      ),
                                      color: Colors.red,
                                    );
                                  },
                                )),
                            Card(
                                elevation: 0,
                                color: Colors.grey.shade400,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: FutureBuilder(
                                  future: controller?.getCameraInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return IconButton(
                                        onPressed: () async {
                                          await controller?.flipCamera();
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          LineIcons.camera,
                                          color:
                                              (describeEnum(snapshot.data!) ==
                                                      'front')
                                                  ? Colors.black
                                                  : Colors.white,
                                        ),
                                        color: Colors.red,
                                      );
                                    } else {
                                      return const Text('loading');
                                    }
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 12,
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width * 0.75
        : MediaQuery.of(context).size.width * 0.75;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    bool cek = false;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.code == 'A+') {
          cek = true;
        } else if (scanData.code == 'A-') {
          cek = true;
        } else if (scanData.code == 'B+') {
          cek = true;
        } else if (scanData.code == 'B-') {
          cek = true;
        } else if (scanData.code == 'AB+') {
          cek = true;
        } else if (scanData.code == 'AB-') {
          cek = true;
        } else if (scanData.code == 'O+') {
          cek = true;
        } else if (scanData.code == 'O-') {
          cek = true;
        } else {
          cek = false;
        }

        if (cek == true) {
          result = scanData;
        } else {
          result = null;
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
