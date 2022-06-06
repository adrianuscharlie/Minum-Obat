import 'dart:core';
import 'package:farmasi/Models/User.dart';
import 'package:farmasi/service/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Pasien.dart';

class AuthService {
   FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebase(User? user) {
    if(user==null){
      return null;
    }
    return MyUser(uid: user.uid);
  }

  Stream<MyUser?>? get user {
      return _auth
          .authStateChanges()
          .map(_userFromFirebase);
  }

  Future signInWithEmailandPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return _userFromFirebase(user!);
    }catch(e){
    print(e.toString());
    return null;
    }
  }

  Future  registerWithEmailandPassword(String email, String password, String nama, String id, String gender) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      DatabaseServices(uid: user!.uid).addPasien(user.uid, nama, id, gender);
      return  _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
