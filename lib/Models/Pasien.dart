import 'package:cloud_firestore/cloud_firestore.dart';

import 'Obat.dart';
import '../Models/Obat.dart';
import 'Resep.dart';

class Pasien {
  String nama = "";
  String id = "";
  String gender = "";
  List<String> resep = [];
  String uid = "";
  List<Resep> resep_obj = [];
  String token = "";
  int tahun_lahir = 0;

  Pasien({uid}) {
    this.uid = uid;
  }

  Pasien.Complete({nama, id, gender, token, tanggal_lahir}) {
    this.nama = nama;
    this.id = id;
    this.gender = gender;
    this.token = token;
    this.tahun_lahir = tanggal_lahir;
  }

  factory Pasien.fromJson(dynamic json, uid) {
    Timestamp stamp = json['tanggal_lahir'];
    DateTime dob = stamp.toDate();
    int year = dob.year;
    year = DateTime.now().year - year;
    Pasien pasien = Pasien.Complete(
        nama: json['nama'] as String,
        id: json['id'] as String,
        gender: json['gender'] as String,
        token: json['token'] as String,
        tanggal_lahir: year);
    pasien.uid = uid;
    return pasien;
  }
}
