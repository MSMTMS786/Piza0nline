import 'package:flutter/material.dart';
import 'package:sign_in/service/database.dart';
import 'package:sign_in/service/shared_pref.dart';
import 'package:sign_in/widgets/wigdets%20_support.dart';
// import 'package:piza0nline/widgets/wigdets%20_support.dart';

class Details extends StatefulWidget {
  String name;
  String image;
  String price;
  String description;
  Details(
      {required this.name,
      required this.image,
      required this.price,
      required this.description});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int total = 0;
  int addremove = 1;
  String? id;
  getthesharedpref() async {
    SharedPrefrenceHelper sharedPrefHelper = SharedPrefrenceHelper();
    id = await sharedPrefHelper.getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }




  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30, right: 20, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            Image.network(
              widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.3,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (addremove > 1) {
                      addremove--;
                    }
                    setState(() {
                      total = addremove * int.parse(widget.price);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  // "$addremove",
                  addremove.toString(),
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    addremove++;
                    total = int.parse(widget.price) * addremove;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.description,
              style: AppWidget.LightTextFieldStyle(),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  "Delivery Time",
                  style: AppWidget.boldTextFieldStyle(),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "30 min",
                  style: AppWidget.boldTextFieldStyle(),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      Text(
                        // "\$${int.parse(widget.price) * addremove}",
                        "\$${total}",
                        style: AppWidget.HeadlineTextFieldStyle(),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodTocart = {
                        "Name": widget.name,
                        "Quantity": addremove,
                        "Total": total,
                        "image": widget.image,
                      };
                      await DataBaseMethods().addFoodToCart(addFoodTocart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Added to cart"),
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            " Add to cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 8,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
