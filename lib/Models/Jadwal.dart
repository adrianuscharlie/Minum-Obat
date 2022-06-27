import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Obat.dart';

class Jadwal{
  String id="";
  String desc_obat="";
  String nama_obat="";
  DateTime jadwal=DateTime.now();
  String formattedDate = '';

  Jadwal({id}){
    this.id=id;
  }

  factory Jadwal.fromJson(dynamic json,id){
    Jadwal jadwal=Jadwal(id: id);
    jadwal.nama_obat=json['nama_obat'];
    jadwal.desc_obat=json['desc'];
    Timestamp stamp=json['waktu_minum'];
    jadwal.jadwal=stamp.toDate();
    jadwal.formattedDate=DateFormat('dd-MM-yyyy  – HH:mm WIB').format(jadwal.jadwal);
    return jadwal;
  }
}