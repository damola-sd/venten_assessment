import 'dart:core';




class Filter {
  final int id;
  final int startYear;
  final int endYear;
  final String gender;
  final List countries;
  final List colors;


  Filter({this.id, this.startYear, this.endYear, this.gender, this.countries, this.colors});
  factory Filter.fromMap(Map<String, dynamic> json) {
    return Filter(
      id: json['id'],
      startYear: json['start_year'],
      endYear: json['end_year'], 
      gender: json['gender'],
      countries: json['countries'].cast<String>(),
      colors: json['colors'].cast<String>()
   );
  }
  
}
