import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
  final FirebaseAuth INSTANCE=FirebaseAuth.instance;


  FirebaseAuth getInstance(){
    return INSTANCE;
  }

  
  
  
  
  
}