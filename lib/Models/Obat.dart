import 'package:cloud_firestore/cloud_firestore.dart';

class Obat{
  String id="";
  String nama="";
  String desc="";


  Obat({id, nama, desc}){
    this.nama=nama;
    this.desc=desc;
    this.id=id;
  }
  factory Obat.fromJson(dynamic json,id){
      return Obat(
        id: id,
        nama: json['nama'],
        desc: json['desc'],
      );
  }

}