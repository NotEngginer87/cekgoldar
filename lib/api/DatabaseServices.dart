// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference userdata = firestore.collection('user');
  static CollectionReference blog = firestore.collection('blog');
  static CollectionReference video = firestore.collection('videopembelajaran');
  static CollectionReference listusergoldar =
      firestore.collection('listusergoldar');
  static CollectionReference console = firestore.collection('console');

  static Future<void> updateakun(
      String? email,
      String nama,
      String gender,
      String? tanggal,
      String? bulan,
      String? tahun,
      String alamat,
      String noHP,
      String? imageUrl) async {
    await userdata.doc(email).set(
      {
        'email': email,
        'nama': nama,
        'gender': gender,
        'tanggal': tanggal,
        'bulan': bulan,
        'tahun': tahun,
        'alamat': alamat,
        'noHP': noHP,
        'imageurl': imageUrl,
      },
    );
  }

  static Future<void> setFAQ(String email, int n) async {
    await userdata
        .doc(email.toString())
        .collection('FAQ')
        .doc(n.toString())
        .set(
      {
        'expand': false,
        'id': n,
      },
    );
  }

  static Future<void> expandFAQ(
    int id,
    bool expand,
    String email,
  ) async {
    await userdata
        .doc(email.toString())
        .collection('FAQ')
        .doc(id.toString())
        .update(
      {
        'expand': !expand,
      },
    );
  }

  static Future<void> videoditonton(String? id) async {
    await video.doc(id).update(
      {
        'ditonton': FieldValue.increment(1),
      },
    );
  }

  static Future<void> postingkomentarvideoditonton(
      String? idvideo, email, String? idkomentar, String? komentar) async {
    await video
        .doc(idvideo)
        .collection('komentar')
        .doc(idkomentar.toString())
        .set(
      {
        'id': idkomentar,
        'email': email,
        'komentar': komentar,
      },
    );
  }

  static Future<void> likesvideoup(String? id) async {
    await video.doc(id).update(
      {
        'like': FieldValue.increment(1),
      },
    );
  }

  static Future<void> likesvideodown(String? id) async {
    await video.doc(id).update(
      {
        'like': FieldValue.increment(-1),
      },
    );
  }

  static Future<void> listuserlikevideo(
      String? idvideo, email, String? idlikes, bool setlike) async {
    await video.doc(idvideo).collection('likes').doc(idlikes.toString()).set(
      {
        'id': idlikes,
        'email': email,
        'likes': setlike,
      },
    );
  }

  static Future<void> naikkanbanyakkomentarvideoditonton(
    String? idvideo,
  ) async {
    await video.doc(idvideo).update(
      {
        'banyakkomentar': FieldValue.increment(1),
      },
    );
  }

  static Future<void> terbacaBlog(String? id) async {
    await blog.doc(id).update(
      {
        'terbaca': FieldValue.increment(1),
      },
    );
  }

  static Future<void> kritikdansaran(String keluhan) async {
    await userdata.doc().set(
      {
        'keluhan': keluhan,
      },
    );
  }

  static Future<void> setdatagolongandarahorang(
      int antrian,
      String nama,
      jeniskelamin,
      nomorHP,
      alamat,
      goldar,
      ) async {
    await listusergoldar.doc(antrian.toString()).set(
      {
        'nama': nama,
        'jeniskelamin': jeniskelamin,
        'nomorHP': nomorHP,
        'alamat': alamat,
        'golongan darah': goldar,
        'antrian':antrian,
      },
    );
  }


  static Future<void> setdatagolongandarahorang2(
    int antrian,
    String nama,
    jeniskelamin,
    nomorHP,
    alamat,
    goldar,
  ) async {
    await listusergoldar.doc(nama).set(
      {
        'nama': nama,
        'jeniskelamin': jeniskelamin,
        'nomorHP': nomorHP,
        'alamat': alamat,
        'golongan darah': goldar,
      },
    );
  }

  static Future<void> inccountgolongandarah() async {
    await console.doc('nomorantriangolongandarah').update(
      {
        'count': FieldValue.increment(1),
      },
    );
  }
}
