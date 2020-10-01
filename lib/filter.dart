import 'dart:core';




class Filter {
  final String startYear;
  final String endYear;
  final String gender;
  final String countries;

  Filter({this.startYear, this.endYear, this.gender, this.countries});
  factory Filter.fromMap(Map<String, dynamic> json) {
    return Filter(
      startYear: json['start_year'],
      endYear: json['end_year'], 
      gender: json['gender'],
      countries: json['countries'],
   );
  }
  
}
