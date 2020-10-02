import 'package:flutter/material.dart';

import 'car_owner.dart';

class CarOwnersPage extends StatelessWidget {
  CarOwnersPage({Key key, this.owners}) : super(key: key);
  List<CarOwner> owners;

  final noResult = SnackBar(content: Text('This filter returns no results'));
  final primary = Color(0xFF696B9E);
  final secondary = Color(0xFFF29A94);
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  Widget ownerCard(BuildContext context, int index) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 230,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  owners[index].fullName,
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.email, color: secondary, size: 15),
                    SizedBox(width: 5),
                    Text(owners[index].email,
                        style: TextStyle(
                            color: primary, fontSize: 10, letterSpacing: .1)),
                    SizedBox(width: 8),
                    Icon(Icons.person, color: secondary, size: 15),
                    SizedBox(width: 5),
                    Text(owners[index].gender,
                        style: TextStyle(
                            color: primary, fontSize: 10, letterSpacing: .1)),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.directions_car, color: secondary, size: 15),
                    SizedBox(width: 5),
                    RichText(
                        text: TextSpan(
                            text: owners[index].carColor + " ",
                            style: TextStyle(
                                color: primary, fontSize: 8, letterSpacing: .1),
                            children: [
                          TextSpan(
                            text: owners[index].carModelYear.toString() + " ",
                            style: TextStyle(
                                color: primary, fontSize: 8, letterSpacing: .1),
                          ),
                          TextSpan(
                            text: owners[index].carModel,
                            style: TextStyle(
                                color: primary, fontSize: 8, letterSpacing: .1),
                          ),
                        ])),
                    SizedBox(width: 10),
                    Icon(Icons.work, color: secondary, size: 15),
                    SizedBox(width: 5),
                    Text(owners[index].jobTitle,
                        style: TextStyle(
                            color: primary, fontSize: 8, letterSpacing: .1)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_city, color: secondary, size: 15),
                    SizedBox(width: 5),
                    Text(owners[index].country,
                        style: TextStyle(
                            color: primary, fontSize: 8, letterSpacing: .3)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book, color: secondary, size: 15),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(owners[index].bio,
                        style: TextStyle(
                            color: primary, fontSize: 9, letterSpacing: .3)),
                  ],
                )
              ],
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 145),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: owners.length == 0 ? Scaffold.of(context).showSnackBar(noResult) : ListView.builder(
                      itemCount: owners.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ownerCard(context, index);
                      }),
                ),
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:
                                  Icon(Icons.arrow_back, color: Colors.white)),
                          Text(
                            "Car Owners",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.menu, color: Colors.white))
                        ],
                      )),
                ),
                Container(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 110,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextField(
                              cursorColor: Theme.of(context).primaryColor,
                              style: dropdownMenuItem,
                              decoration: InputDecoration(
                                  hintText: "Search Full Name",
                                  hintStyle: TextStyle(
                                      color: Colors.black38, fontSize: 16),
                                  prefixIcon: Material(
                                    elevation: 0.0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Icon(Icons.search),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 13)),
                            )))
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
