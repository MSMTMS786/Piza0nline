import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/pages/details.dart';
import 'package:sign_in/service/database.dart';
// import 'package:piza0nline/pages/details.dart';

import '../widgets/wigdets _support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false;
  bool salaad = false;
  bool pizza = false;
  bool burger = false;
  Stream<QuerySnapshot<Object?>>? fooditemStream;
  ontheload()async{
    fooditemStream=(await DataBaseMethods().getFoodItem("Pizza"));
    setState(() {
      // allItems();
    });}
initState() {
    ontheload();

    super.initState();

  }
Widget allItems(){
  return StreamBuilder(stream: fooditemStream, builder: (context,AsyncSnapshot snapshot){
  return snapshot.hasData?ListView.builder(
    padding: EdgeInsets.zero,
    itemCount: snapshot.data.docs.length,
    shrinkWrap: true ,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context,index){
      DocumentSnapshot ds=snapshot.data.docs[index];
      return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Details(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                ds["Image"],
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                ds["Name"],
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                ds["Detail"],
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "\$"+ds["Price"],
                                style: AppWidget.semiBoldTextFieldStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
    },):Center(child: CircularProgressIndicator());
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hallo,Misbah",
                  style: AppWidget.boldTextFieldStyle(),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Delicius Food",
              style: AppWidget.HeadlineTextFieldStyle(),
            ),
            Text(
              "Discovery and Get Great Food",
              style: AppWidget.LightTextFieldStyle(),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
                margin: const EdgeInsets.only(right: 20), child: showItem()),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 150,
              
              child: allItems()),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                margin: const EdgeInsets.only(right: 5),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/salad4.png",
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Meditrranean Chickpea Salad",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Honey Goot Cheese",
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "\$59",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNav(),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            pizza = true;
            icecream = false;
            burger = false;
            salaad = false;
            setState(() {});
          },
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/pizza.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            pizza = false;
            icecream = true;
            burger = false;
            salaad = false;
            setState(() {});
          },
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/ice-cream.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            pizza = false;
            icecream = false;
            burger = false;
            salaad = true;
            setState(() {});
          },
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                  color: salaad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/salad.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: salaad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            pizza = false;
            icecream = false;
            burger = true;
            salaad = false;
            setState(() {});
          },
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                "images/burger.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
