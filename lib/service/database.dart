
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{
  Future addUserDetail(Map<String,dynamic>userinfoMap,String Id)async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(Id)
    .set(userinfoMap); 
  }
  UpdateUserwallet(String id,String amount)async{
    return await FirebaseFirestore.instance.collection("users").doc(id).update({
      "Wallet":amount}); 
  }
}