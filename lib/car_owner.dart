// import 'dart:html';

class CarOwner {
  final int id;
  final String fullName;
  final String email;
  final String country;
  final String carModel;
  final int carModelYear;
  final String carColor;
  final String gender;
  final String jobTitle;
  final String bio;

  CarOwner(
      {this.id,
      this.fullName,
      this.email,
      this.country,
      this.carModel,
      this.carModelYear,
      this.carColor,
      this.jobTitle,
      this.gender,
      this.bio});

  factory CarOwner.fromList(List<dynamic> json) {
     return CarOwner(
          id: json[0],
          fullName: json[1] + " " + json[2],
          email: json[3],
          country: json[4],
          carModel: json[5],
          carModelYear: json[6],
          carColor: json[7],
          gender: json[8],
          jobTitle: json[9],
          bio: json[10]);
    }
}
