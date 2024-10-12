
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
  Future addFoodItem(Map<String,dynamic>userinfoMap,String name)async{
    return await FirebaseFirestore.instance
    .collection(name)
    .add(userinfoMap); 
  }
  Future<Stream<QuerySnapshot>>getFoodItem(String name)async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodToCart(Map<String,dynamic>userinfoMap,String id)async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id).collection("Cart")
    .add(userinfoMap); 
  }
   Future<Stream<QuerySnapshot>>getFoodCart(String id)async{
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("Cart").snapshots();
  }

  // UpdateUserwallet(String id,String amount)async{
  //   return await FirebaseFirestore.instance.collection("users").doc(id).update({
  //     "Wallet":amount}); 
  // }

}