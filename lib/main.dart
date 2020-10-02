import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

import 'car_owner.dart';
import 'filter.dart';
import 'filter_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<List<Filter>> filters;
  List<CarOwner> carOwners;
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
      home: MyHomePage(
          title: 'My Filters', filters: filters, carOwners: carOwners),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Future<List<Filter>> filters;
  List<CarOwner> carOwners;

  MyHomePage({Key key, this.title, this.filters, this.carOwners})
      : super(key: key);

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
  List<CarOwner> carOwners;

  final primary = Color(0xFF696B9E);
  final secondary = Color(0xFFF29A94);
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  @override
  void initState() {
    super.initState();
    filters = fetchFilters();
    carOwners = new List<CarOwner>();
    loadCsv();
  }

  loadCsv() async {
    final data = await rootBundle.loadString('venten/car_ownsers_data.csv');
    // final data2 = File.readAsLinesSync('venten/car_ownsers_data.csv')
    List<List<dynamic>> csvData = CsvToListConverter().convert(data);
    var owners = new List<CarOwner>();
    for (var i = 1; i < csvData.length; i++) {
      var tempy = CarOwner.fromList(csvData[i]);
      owners.add(tempy);
    }
    carOwners = owners;
    setState(() {});
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
      backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: primary,
        ),
        body: FutureBuilder<List<Filter>>(
                      future: filters,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? FilterBoxList(
                                items: snapshot.data, owners: carOwners)
                            :

                            // return the ListView widget :
                            Center(child: CircularProgressIndicator());
                      },
                    ),
                );
  }
}

List<Filter> parseFilters(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Filter>((json) => Filter.fromMap(json)).toList();
}

Future<List<Filter>> fetchFilters() async {
  final data = await http.get('https://ven10.co/assessment/filter.json');
  if (data.statusCode == 200) {
    return parseFilters(data.body);
  } else {
    throw Exception('Failed to load filters');
  }
}
