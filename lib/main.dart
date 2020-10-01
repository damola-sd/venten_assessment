import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'filter.dart';
import 'filter_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<List<Filter>> filters;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'My Filters', filters: filters,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Future<List<Filter>> filters;
  MyHomePage({Key key, this.title, this.filters}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Filter>> filters;

  List<List<dynamic>> car_owners_data = [];


  @override
  void initState() {
    super.initState();
    filters = fetchFilters();
  }
  loadCsv() async {
    final carOwners = await rootBundle.loadString('assets/car_ownsers_data.csv');
    print(carOwners);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Filter>>(
        future: filters, builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error); 
                  return snapshot.hasData ? FilterBoxList(items: snapshot.data) :
                  
                  // return the ListView widget : 
                  Center(child: CircularProgressIndicator()); 
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<Filter> parseFilters(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Filter>((json) =>Filter.fromMap(json)).toList(); 
} 

Future<List<Filter>> fetchFilters() async {
  final data = await http.get('https://ven10.co/assessment/filter.json');
  if (data.statusCode == 200) {
    return parseFilters(data.body);

  }else {
    throw Exception('Failed to load filters');
  }
}
