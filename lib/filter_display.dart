import 'package:damolaAdewunmi/car_owner.dart';
import 'package:damolaAdewunmi/car_owners_page.dart';
import 'package:flutter/material.dart';

import 'filter.dart';

class FilterBoxList extends StatelessWidget {
  final List<Filter> items;
  List<CarOwner> owners;
  FilterBoxList({Key key, this.items, this.owners});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: FilterBox(item: items[index]),
          onTap: () {
            var filteredOwners = filterData(owners, items[index]);
            print(owners);
            print(filteredOwners);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarOwnersPage(owners: filteredOwners),
              ),
            );
          },
        );
      },
    );
  }
}

List<CarOwner> filterData(List<CarOwner> owners, Filter fil) {
  return owners
      .where((owner) => owner.carModelYear >= fil.startYear)
      .where((owner) => owner.carModelYear <= fil.endYear)
      .where((owner) => fil.gender.length > 0
          ? owner.gender.toLowerCase() == fil.gender.toLowerCase()
          : true)
      .where((owner) => fil.countries.length > 0
          ? fil.countries.any(
              (country) => owner.country.toLowerCase() == country.toLowerCase())
          : true)
      .where((owner) => fil.colors.length > 0
          ? fil.colors.any(
              (color) => owner.carColor.toLowerCase() == color.toLowerCase())
          : true)
      .toList();
}

class FilterBox extends StatelessWidget {
  FilterBox({Key key, this.item}) : super(key: key);
  final Filter item;
  final primary = Color(0xFF696B9E);
  final secondary = Color(0xFFF29A94);
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  Widget getItems(String shown, List data) {
    List<Widget> wid = new List<Widget>();
    wid.add(new Text(shown + ": ", 
    style: TextStyle(color: primary, fontSize: 10)
    ));
    if (data.length == 0) {
      wid.add(new Text("All", style: TextStyle(color: secondary, fontSize: 9)));
    }
    for(var i = 0; i < data.length; i++) {
      wid.add(new Text(
       i == data.length - 1 ? data[i] :  data[i] + " , ",
        style: TextStyle(color: secondary, fontSize: 9)
      ));
    }
    return new Wrap(
      children: wid
    );
  }

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  RichText(
                    text: TextSpan(
                        text: "Date Range: ",
                        style: TextStyle(color: primary, fontSize: 10),
                        children: [
                          TextSpan(
                            text: this.item.startYear.toString() + " - ",
                            style: TextStyle(color: secondary, fontSize: 10),
                          ),
                          TextSpan(
                            text: this.item.endYear.toString(),
                            style: TextStyle(color: secondary, fontSize: 10),
                          )
                        ]),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                        text: "Gender: ",
                        style: TextStyle(color: primary, fontSize: 10),
                        children: [
                          TextSpan(
                            text: this.item.gender.length == 0 ? "All" : this.item.gender ,
                            style: TextStyle(color: secondary, fontSize: 10),
                          )
                        ]),
                  ),
                  SizedBox(height: 5),
                  //Get Countries
                  getItems("Colors", this.item.colors),
                  SizedBox(height: 5),
                  getItems("Countries", this.item.countries)
                ]))
          ],
        ));
  }
}
