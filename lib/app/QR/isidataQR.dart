// ignore_for_file: avoid_print, unnecessary_null_comparison, must_be_immutable, deprecated_member_use, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../api/DatabaseServices.dart';
import '../Utils/style.dart';

class RekamMedis extends StatefulWidget {
  RekamMedis(
    this.kegiatan, {
    Key? key,
  }) : super(key: key);
  String kegiatan;
  @override
  _RekamMedisState createState() => _RekamMedisState();
}

class _RekamMedisState extends State<RekamMedis> {
  int currentstep = 0;

  TextEditingController nama = TextEditingController();
  TextEditingController noHP = TextEditingController();
  TextEditingController umurcontrol = TextEditingController();
  TextEditingController alamat = TextEditingController();

  late bool switchnama = false;
  late bool switchgender = false;
  late bool switchumur = false;
  late bool switchnotelepon = false;
  late bool switchalamat = false;

  String? tanggal, bulan, tahun;
  String? gender;

  String? genderr;

  int? tanggalawal = 0, bulanawal = 0, tahunawal = 0;

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              'upload : $percentage %',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return const SizedBox(
              width: 0,
              height: 0,
            );
          }
        },
      );

  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference console = firestore.collection('console');
    CollectionReference userdata = firestore.collection('user');
    CollectionReference listpasiencount =
        firestore.collection('listpasiencount');

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final emaila = user!.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekam Medis'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal.shade900,
      ),
      body: Theme(
        data: ThemeData(
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(primary: Colors.teal.shade900)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: ListView(
            children: [
              Text('Golongan Darah :  ${widget.kegiatan}'),
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
                        color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
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
                      print(Gender?.index);
                    },
                    animationDuration: const Duration(milliseconds: 300),
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
                    stream:
                        console.doc('nomorantriangolongandarah').snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;

                        int count = data['count'];

                        return ElevatedButton(
                            onPressed: () {
                              DatabaseServices.inccountgolongandarah();
                              DatabaseServices.setdatagolongandarahorang(
                                  count,
                                  nama.text,
                                  genderr,
                                  noHP.text,
                                  alamat.text,
                                  widget.kegiatan);
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
        )),
      ),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image!.path);

      final fileName = basename(file.path);
      final destination = 'user/fotokonsultasi/$fileName';

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child(destination)
            .putFile(file)
            .whenComplete(() => null);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}

class AddUserCountCard extends StatelessWidget {
  final int? count;
  final Function? onUpdate;
  final String? documentId;
  final String nama;
  final String alamat;
  final String agama;
  final String telepon;
  final String pekerjaan;
  final String suku;
  final String gender;
  final String umur;
  final String keluhan;
  final String? gambar;

  AddUserCountCard(
      this.count,
      this.documentId,
      this.nama,
      this.alamat,
      this.agama,
      this.telepon,
      this.pekerjaan,
      this.suku,
      this.gender,
      this.umur,
      this.keluhan,
      this.gambar,
      {Key? key,
      this.onUpdate})
      : super(key: key);

  final ButtonStyle untukElevatedButtonSubmit = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color(0xFF5d1a77),
    elevation: 10,
    minimumSize: const Size(100, 48),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
  final ButtonStyle sepertiRaisedButton = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: const Color(0xFF5d1a77),
    minimumSize: const Size(90, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: untukElevatedButtonSubmit,
      onPressed: () {
        if (onUpdate != null) onUpdate!();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'PERHATIAN!!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            content: SizedBox(
              height: 240,
              child: Column(
                children: const [
                  Text(
                    'Setelah ini #sanak akan memilih dokter untuk konsultasi, Jika #sanak  keluar dari aplikasi, atau kembali ke halaman sebelumnya, maka data tidak akan terekam, dan #sanak diminta untuk mengisi form kembali data yang sudah diisikan hanya akan digunakan oleh dokter gigi.',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Kami selaku developer iDent menjamin data #sanak tidak akan terekam oleh pihak ketiga dan hanya akan disimpan oleh dokter gigi untuk kepentingan pelayanan medis yang akan diberikan',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: sepertiRaisedButton,
                onPressed: () {},
                child: const Text('Konsultasi'),
              )
            ],
          ),
        );
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Padding(
          padding: EdgeInsets.only(left: 0, right: 10),
          child: Icon(
            LineIcons.tooth,
            size: 24,
          ),
        ),
        Text(
          'Konsultasi',
          style: TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}
