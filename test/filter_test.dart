import 'package:damolaAdewunmi/car_owner.dart';
import 'package:damolaAdewunmi/filter.dart';
import 'package:damolaAdewunmi/filter_display.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<CarOwner> mockCarOwners = new List<CarOwner>();
  Filter testFilter1 = new Filter(id: 1, startYear: 2000, endYear: 2016, countries: ["Thailand", "Montenegro", "France", "Vatican"], colors: ["Red", "Yellow", "Brown", "Blue"], gender: "Female");
  Filter testFilter2 = new Filter(id: 2, startYear: 1990, endYear: 2005, countries: [], colors: ["Red", "Brown", "Green"], gender: "");
  Filter testFilter3 = new Filter(id: 3, startYear: 1959, endYear: 2020, countries: [], colors:[] , gender: "");


  mockCarOwners.add(CarOwner(bio: "lorem ipsum", fullName: "Jack Smith", carColor: "green", carModel: "Honda", carModelYear: 1999, email: "test@test.com", jobTitle: 'QA Tester',gender: "Male", country: "USA", id: 1));
  mockCarOwners.add(CarOwner(bio: "lorem ipsum", fullName: "Mark Wiens", carColor: "Yellow", carModel: "Toyota", carModelYear: 2016, email: "test123@test.com", jobTitle: 'Food Blogger',gender: "Female", country: "Thailand", id: 2)); 
  mockCarOwners.add(CarOwner(bio: "lorem ipsum", fullName: "Donny", carColor: "Brown", carModel: "Suzuki 2200c", carModelYear: 2004, email: "test@yahoo.com", jobTitle: 'Software Developer',gender: "Unknown", country: "China", id: 1)); 

  group('Filter Function', () {
    test('Returns one item', () {
      var result = filterData(mockCarOwners, testFilter1);
      expect(result.length, 1);
  });
  test('Finds right name', () {
      var result = filterData(mockCarOwners, testFilter1);
      expect(result[0].fullName.contains("Mark"), true);
  });
  test('Finds right Car', () {
      var result = filterData(mockCarOwners, testFilter1);
      expect(result[0].carColor, "Yellow");
  });


  test('Fetches two car owners', () {
      var result = filterData(mockCarOwners, testFilter2);
      expect(result.length, 2);
  });

  test('Finds all', () {
      var result = filterData(mockCarOwners, testFilter3);
      expect(result.length, 3);
  });
  });
  


}