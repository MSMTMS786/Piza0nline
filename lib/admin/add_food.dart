import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:sign_in/service/database.dart';
import 'package:sign_in/widgets/wigdets%20_support.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String>Fooditems=['Ice-cream','Burger','Salad','Pizza',];
   String? value;
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController itempricecontroller = TextEditingController();
  TextEditingController itemdetailcontroller = TextEditingController();
  final ImagePicker _picker=ImagePicker();
  File? selectedImage;

Future getImage() async{
  var image=await _picker.pickImage(source: ImageSource.gallery);

  selectedImage=File(image!.path);
  setState(() {
    
  });
}


uploadItem()async{
  if(selectedImage!=null && itemnamecontroller.text!="" &&itemdetailcontroller.text!="" && itempricecontroller.text!=""){
      String addId=randomAlphaNumeric(10);
      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child("BLocgImages").child(addId);
      final UploadTask task=firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl=await (await task).ref.getDownloadURL();

      Map<String,dynamic>addItem={

        "Image":downloadUrl,
        "Name":itemnamecontroller.text,
        "Price":itempricecontroller.text,
        "Detail":itemdetailcontroller.text,
        // "category":value,
      };
      await DataBaseMethods().addFoodItem(addItem, value!).then((value){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Item Added Successfully"),));
          Navigator.pop(context);
      });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined,color: Color(0xff373866),)),
        title:  Text("Add Food",style: AppWidget.HeadlineTextFieldStyle(),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload The Item Picture",style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 30,),
             selectedImage==null? GestureDetector(
                onTap: (){
                  getImage();
                },
               child: Center(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1.5),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.camera_alt_outlined,size: 50,color: Colors.black,),
                    ),
                  ),
                ),
             ):Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 1.5),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ClipRect(
                      // borderRadius: BorderRadius.circular(10),
                      child: Image.file(selectedImage!,fit:BoxFit.cover)),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Item Name",style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: itemnamecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Name",
                    hintStyle: AppWidget.LightTextFieldStyle(),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Item Price",style: AppWidget.semiBoldTextFieldStyle(),),
              SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: itempricecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Item Price",
                    hintStyle: AppWidget.LightTextFieldStyle(),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            Text("Item Detail",style: AppWidget.semiBoldTextFieldStyle(),),
            SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: itemdetailcontroller,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  
                  hintText: "Enter Item Detail",
                  hintStyle: AppWidget.LightTextFieldStyle(),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("Select Category",style: AppWidget.semiBoldTextFieldStyle(),),
            SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                
                color: Color(0xffececf8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items:Fooditems.map((item)=>DropdownMenuItem<String>(value: item,child: Text(item,style: TextStyle(fontSize: 15,color: Colors.black),))).toList(),
                  onChanged: ((value){ 
                    setState(() {
                      this.value=value;
                    }); 
                  }),
                  dropdownColor: Colors.white,
                  hint: Text("Select Category"),
                  iconSize: 35,
                  icon: Icon(Icons.arrow_drop_down,color: Colors.black,),value: value,)
                  ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                uploadItem();
                
              },
              child: Center(
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text("Add",
                      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}