import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/service/database.dart';
import 'package:sign_in/service/shared_pref.dart';
import 'package:sign_in/widgets/wigdets%20_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id,wallet;
  int total = 0,amount2=0;

  void startTimer() {
    Timer(Duration(seconds: 3),(){
      amount2=total;
      setState(() {
        
      });
    });
  }

  getthesharedpref() async {
    id = await SharedPrefrenceHelper().getUserId();
    wallet = await SharedPrefrenceHelper().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DataBaseMethods().getFoodCart(id!);
    setState(() {});
  }

  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;
  Widget foodCart() {
    return  StreamBuilder(
  stream: foodStream,
  builder: (context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    // Reset total before calculation
    total = 0;

    // Calculate the total price for all items
    for (var doc in snapshot.data.docs) {
      total += int.parse(doc["Total"].toString());
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          // Optional: You can add a method to refresh the data
          await ontheload(); // Reload the data from the database
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];

            return Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(ds["Quantity"].toString())),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            ds["image"],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              ds["Name"],
                              style: AppWidget.semiBoldTextFieldStyle(),
                            ),
                            Text(
                              "\$" + ds["Total"].toString(),
                              style: AppWidget.semiBoldTextFieldStyle(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  },
);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        // margin: const EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    'Food Cart',
                    style: AppWidget.HeadlineTextFieldStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 1.85,
                child: foodCart()),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                  "\$" + total.toString(),
                    style: AppWidget.HeadlineTextFieldStyle(),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: ()async{
              int amount = int.parse(wallet!)-amount2;
            await DataBaseMethods().UpdateUserwallet(id!, amount.toString());
            await SharedPrefrenceHelper().saveUserWallet(amount.toString());
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Order Placed"),
            ));
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pop(context);
            });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height/12,
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  "Checkout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
