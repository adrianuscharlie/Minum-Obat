import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Models/Jadwal.dart';
import '../../Models/Obat.dart';
import '../../Models/Pasien.dart';
import '../../Models/Resep.dart';
import '../../service/Database.dart';

class ListJadwal extends StatefulWidget {
  ListJadwal({Key? key}) : super(key: key);
  List<Jadwal> jadwal = [];
  Pasien pasien = Pasien(uid: "");

  ListJadwal.Pasien({jadwal, pasien}) {
    this.jadwal = jadwal;
    this.pasien = pasien;
  }

  @override
  State<ListJadwal> createState() => _ListJadwalState();
}

class _ListJadwalState extends State<ListJadwal> {
  @override
  Widget build(BuildContext context) {
    List<Jadwal> jadwal = widget.jadwal;
    Pasien pasien = widget.pasien;
    return Container(
        padding: EdgeInsets.all(3.0),
        child: ListView.builder(
            itemCount: jadwal.length,
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                    child: ListTile(
                  tileColor: Colors.lightBlueAccent,
                  title: Text(jadwal[index].nama_obat,
                      style: GoogleFonts.ubuntu(
                          fontSize: 24.0, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(jadwal[index].desc_obat,
                            style: GoogleFonts.ubuntu(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      //Text("Tanggal Mulai :"+Services().jadwalPasien(resep[index].tanggal_mulai)),
                      //Text("Tanggal Selesai : "+Services().jadwalPasien(resep[index].tanggal_selesai)),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Jadwal Konsumsi : " + jadwal[index].formattedDate,
                          style: GoogleFonts.ubuntu(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          setState(() {
                            DatabaseServices(uid: pasien.uid)
                                .sendRecord(pasien, jadwal[index]);
                            DatabaseServices(uid: pasien.uid)
                                .deleteJadwal(pasien, jadwal[index].id);
                            jadwal.removeAt(index);
                          });
                        },
                        child: Text(
                          "Sudah Minum",
                          style: GoogleFonts.ubuntu(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )),
              );
            }));
  }
}
