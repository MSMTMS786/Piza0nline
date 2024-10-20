import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/pages/details.dart';
import 'package:sign_in/service/database.dart';
import 'package:sign_in/service/shared_pref.dart';
// import 'package:piza0nline/pages/details.dart';

import '../widgets/wigdets _support.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  String? name;
  bool icecream = false;
  bool salaad = false;
  bool pizza = false;
  bool burger = false;
  Stream? fooditemStream;

getthesharedpref() async {
    name = await SharedPrefrenceHelper().getUserName();
    setState(() {});
  }

  onthisload() async {
    await getthesharedpref();
    setState(() {
    });
  }

  ontheload() async {
    // fooditemStream=(await DataBaseMethods().getFoodItem("Pizza"));
    fooditemStream = await DataBaseMethods().getFoodItem("Burger") as Stream?;
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose the scroll controller to avoid memory leaks
    super.dispose();
  }

  initState() {
    ontheload();
    onthisload();
    super.initState();
  }

  Widget allItemsHorizontally() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                name: ds['Name'],
                                description: ds['Detail'],
                                image: ds['Image'],
                                price: ds['Price'],
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      ds["Image"],
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Text("Data",style: AppWidget.semiBoldTextFieldStyle(),),
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   ds["Detail"],
                                  //   style: AppWidget.LightTextFieldStyle(),
                                  // ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  Text(
                                    "\$" + ds["Price"],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget allItemsVertically() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              name: ds['Name'],
                              description: ds['Detail'],
                              image: ds['Image'],
                              price: ds['Price'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      ds["Image"],
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      width: MediaQuery.of(context).size.width /
                                          2.7,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                19,
                                        // width: MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          ds["Name"],
                                          style: AppWidget
                                              .semiBoldTextFieldStyle(),
                                        ),
                                      ),

                                      // Container(
                                      //   // width: MediaQuery.of(context).size.width / 2,

                                      //   // child: Text(
                                      //   //   ds["Detail"],

                                      //   //   style: AppWidget.LightTextFieldStyle(),
                                      //   // ),
                                      // ),
                                      Container(
                                        // width: MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          "\$" + ds["Price"],
                                          style: AppWidget
                                              .semiBoldTextFieldStyle(),
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
                    );
                  },
                ))
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              //Name,Detail and 4 catoegory

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hallo,$name",
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
                    margin: const EdgeInsets.only(right: 20),
                    child: showItem()),
              ],
            ), //Name,Detail and 4 catoegory

            const SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.69,
              child: Scrollbar(
                controller: _scrollController,
                scrollbarOrientation:
                    ScrollbarOrientation.left, // Scrollbar on the left
                thickness: 8.0,

                thumbVisibility: true, // Always show the thumb
                interactive: true,
                child: SingleChildScrollView(
                  controller:
                      _scrollController, // Attach the controller to sync scrolling
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: allItemsHorizontally(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: allItemsVertically(),
                      ),
                    ],
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
          onTap: () async {
            pizza = true;
            icecream = false;
            burger = false;
            salaad = false;
            fooditemStream =
                await DataBaseMethods().getFoodItem("Pizza") as Stream?;
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
          onTap: () async {
            pizza = false;
            icecream = true;
            burger = false;
            salaad = false;
            fooditemStream =
                await DataBaseMethods().getFoodItem("Ice-cream") as Stream?;
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
          onTap: () async {
            pizza = false;
            icecream = false;
            burger = false;
            salaad = true;
            fooditemStream =
                await DataBaseMethods().getFoodItem("Salad") as Stream?;
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
          onTap: () async {
            pizza = false;
            icecream = false;
            burger = true;
            salaad = false;
            fooditemStream =
                await DataBaseMethods().getFoodItem("Burger") as Stream?;
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






/*

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
                                      "images/salad2.png",
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
                                            "Chinese Salad",
                                            style: AppWidget.semiBoldTextFieldStyle(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 2,
                                          child: Text(
                                            "Tomatoes,Onions",
                                            
                                            style: AppWidget.LightTextFieldStyle(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 2,
                                          child: Text(
                                            "\$89",
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

*/




/*

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

*/
