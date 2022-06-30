
import '../Models/Obat.dart';
import '../Models/Pasien.dart';
import '../Models/Resep.dart';
import 'package:intl/intl.dart';
class Services{

  List<Resep> getResep(Pasien pasien,List<Resep> resep_list){
    List<Resep> resep=[];
    for(int i=0;i<resep_list.length;i++){
      if(pasien.resep.contains(resep_list[i].id)){
        resep.add(resep_list[i]);
      }
    }
    return resep;
  }
  List<Resep> getJadwalHarian(List<Resep> resep){
    List<Resep> harian=[];
    int jam=0;
    for(int i=0;i<resep.length;i++){
      Resep rep=resep[i];
      for(int j=0;j<resep[i].dosis;j++){
          jam=rep.jam_konsumsi;
          harian.add(rep);
          jam=jam+rep.jeda_konsumsi;
          rep.jam_konsumsi=jam;
      }
    }
    return harian;
  }


  Pasien getPasienData(Pasien pasien,List<Pasien> pasien_list){
    for(int i=0;i<pasien_list.length;i++){
      if(pasien_list[i].uid.contains(pasien.uid)){
        pasien=pasien_list[i];
      }
    }
    return pasien;
  }

  String jadwalPasien(DateTime date){
    return DateFormat('dd--MM--yyy').format(date);
  }
  Obat getObat(String nama,List<Obat> obat){
    Obat temp=Obat(id: "",nama: "",desc: "");
    obat.forEach((element){
      if(element.nama.contains(nama)){
        temp=element;
      }
    });
    return temp;
  }

}