import 'Obat.dart';
import '../Models/Obat.dart';
import 'Resep.dart';

class Pasien {
  String nama = "";
  String id = "";
  String gender = "";
  List<String> resep = [];
  String uid = "";
  List<Resep> resep_obj=[];

  Pasien({uid}) {
    this.uid=uid;
  }

  Pasien.Complete({nama,id,gender}) {
    this.nama = nama;
    this.id = id;
    this.gender = gender;
  }

  factory Pasien.fromJson(dynamic json,uid) {
    Pasien pasien = Pasien.Complete(
      nama: json['nama'] as String,
      id: json['id'] as String,
      gender: json['gender'] as String,
    );
    pasien.uid=uid;
    return pasien;
  }

  List<Obat> convertObat(List<String> id_obat, List<Obat> obat) {
    List<Obat> convert = [];
    for (int i = 0; i < obat.length; i++) {
      if (id_obat[i] == obat[i].id) {
        convert.add(obat[i]);
      }
    }
    return convert;
  }
}
