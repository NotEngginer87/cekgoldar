import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:pkmzuhal/api/DatabaseServices.dart';
import 'package:pkmzuhal/app/QR/isidataQR.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../HalamanRumah/HalamanRumah.dart';

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
    final emaila = user!.email;
    return Scaffold(
      body: (result != null)
          ? Center(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            child: ListView(
              children: [
                Text('Golongan Darah :  ${result?.code}'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'nama : ',
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      controller: nama,
                      onChanged: (value) {
                        setState(() {
                          switchnama = true;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
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
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
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
                        print(Gender?.index);
                      },
                      animationDuration:
                      const Duration(milliseconds: 300),
                      isCircular: true,
                      maleText: 'Laki-Laki',
                      femaleText: 'Perempuan',
                      // default : true,
                      opacityOfGradient: 0.4,
                      padding: const EdgeInsets.all(3),
                      size: 120, //default : 40
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Umur : ',
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      controller: umurcontrol,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          switchumur = true;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Nomor HP : ',
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      controller: noHP,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          switchnotelepon = true;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text('Alamat'),
                    TextFormField(
                      controller: alamat,
                      keyboardType: TextInputType.streetAddress,
                      onChanged: (value) {
                        setState(() {
                          switchalamat = true;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: console
                          .doc('nomorantriangolongandarah')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data = snapshot.data!
                              .data() as Map<String, dynamic>;

                          int count = data['count'];

                          return ElevatedButton(
                              onPressed: () {
                                DatabaseServices
                                    .inccountgolongandarah();
                                DatabaseServices
                                    .setdatagolongandarahorang(
                                    count,
                                    nama.text,
                                    genderr,
                                    noHP.text,
                                    alamat.text,
                                    result?.code);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const HalamanRumah()),
                                );
                              },
                              child: const Text('Kirim'));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ))
          : Column(
              children: <Widget>[
                Expanded(flex: 4, child: _buildQrView(context)),
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
                          const Text('Scan a code'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getFlashStatus(),
                                    builder: (context, snapshot) {
                                      return Text('Flash: ${snapshot.data}');
                                    },
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller?.flipCamera();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getCameraInfo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        return Text(
                                            'Camera facing ${describeEnum(snapshot.data!)}');
                                      } else {
                                        return const Text('loading');
                                      }
                                    },
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.pauseCamera();
                                },
                                child: const Text('pause',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await controller?.resumeCamera();
                                },
                                child: const Text('resume',
                                    style: TextStyle(fontSize: 20)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
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
