
import 'package:flutter/material.dart';

import 'filter.dart';

class FilterBoxList extends StatelessWidget { 
   final List<Filter> items;
   FilterBoxList({Key key, this.items}); 
   
   @override 
   Widget build(BuildContext context) {
      return ListView.builder(
         itemCount: items.length,
         itemBuilder: (context, index) {
            return GestureDetector(
               child: FilterBox(item: items[index]), 
               onTap: () {
                  // Navigator.push(
                  //    context, MaterialPageRoute(
                  //       builder: (context) => FilterPage(item: items[index]), 
                  //    ), 
                  // ); 
               }, 
            ); 
         }, 
      ); 
   } 
}

class FilterBox extends StatelessWidget {
   FilterBox({Key key, this.item}) : super(key: key); 
   final Filter item; 
   
   Widget build(BuildContext context) {
      return Container(
         padding: EdgeInsets.all(2), height: 140, 
         child: Card(
            child: Row( 
               mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
               children: <Widget>[
                  Expanded( 
                     child: Container( 
                        padding: EdgeInsets.all(5), 
                        child: Column( 
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                           children: <Widget>[ 
                              Text(this.item.startYear.toString(), style:TextStyle(fontWeight: FontWeight.bold)), 
                              Text(this.item.endYear.toString()), 
                              Text(this.item.gender),

                              Text("colors:" +this.item.colors[0]),
                           ], 
                        )
                     )
                  )
               ]
            ), 
         )
      ); 
   } 
}

// class FilterPage extends StatelessWidget { 
//    FilterPage({Key key, this.item}) : super(key: key); 
//    final Filter item; 
//    @override 
//    Widget build(BuildContext context) {
//       return Scaffold(
//          appBar: AppBar(title: Text(this.item.name),), 
//          body: Center( 
//             child: Container(
//                padding: EdgeInsets.all(0), 
//                child: Column( 
//                   mainAxisAlignment: MainAxisAlignment.start, 
//                   crossAxisAlignment: CrossAxisAlignment.start, 
//                   children: <Widget>[
//                      Image.asset("assets/appimages/" + this.item.image), 
//                      Expanded( 
//                         child: Container( 
//                            padding: EdgeInsets.all(5), 
//                            child: Column( 
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
//                               children: <Widget>[ 
//                                  Text(this.item.name, style: 
//                                     TextStyle(fontWeight: FontWeight.bold)), 
//                                  Text(this.item.description), 
//                                  Text("Price: " + this.item.price.toString()), 
                                 
//                               ], 
//                            )
//                         )
//                      ) 
//                   ]
//                ), 
//             ), 
//          ), 
//       ); 
//    } 
// }