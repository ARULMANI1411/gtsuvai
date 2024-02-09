///---------------------search----------------///
// ///search Api
// // Modify your search API response
// Future<List<SearchResult>> searchRestaurant(String query) async {
//   final String apiUrl = 'http://gtsuvai.gtcollege.in/User/GetItem_ResDtlsByUser?Key=cof&Lat=11.0190694&Long=76.990981';
//
//   try {
//     final response = await http.get(Uri.parse(apiUrl));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = json.decode(response.body)['restaurantDtls'];
//       List<SearchResult> searchResults = responseData
//           .map((result) => SearchResult.fromJson(result))
//           .toList();
//
//       return searchResults;
//     } else {
//       print('Failed to load data: ${response.statusCode}');
//       return [];
//     }
//   } catch (error) {
//     print('Error during API request: $error');
//     return [];
//   }
// }
//
//
//
// ///Search method
// Future handleSearch() async {
//   // Call the searchRestaurant function to get the search results
//   List<SearchResult> searchResults = await searchRestaurant(searchcontroller.text);
//
//   // Sort the search results based on distance
//   searchResults.sort((a, b) {
//     double distanceA = calculateDistance(
//       currentLocationLatitude, currentLocationLongitude,
//       a.latitude, a.longitude,
//     );
//
//     double distanceB = calculateDistance(
//       currentLocationLatitude, currentLocationLongitude,
//       b.latitude, b.longitude,
//     );
//
//     return distanceA.compareTo(distanceB);
//   });
//
//   // Navigate to the second page with the sorted search results
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => SearchResultsPage(
//         searchResults: searchResults,
//         currentLocationLatitude: currentLocationLatitude,
//         currentLocationLongitude: currentLocationLatitude,),
//     ),
//   );
// }
//
//
//
//
// // Add these functions outside the _homeState class
// double calculateDistance(double? startLat, double? startLng, double? endLat, double? endLng) {
//   if (startLat == null || startLng == null || endLat == null || endLng == null) {
//     // Handle null values, return an appropriate default or throw an exception
//     return 0.0; // Or any other default value
//   }
//
//   const double earthRadius = 6371; // Radius of the Earth in kilometers
//
//   // Convert latitude and longitude from degrees to radians
//   double lat1Rad = _degreesToRadians(startLat);
//   double lon1Rad = _degreesToRadians(startLng);
//   double lat2Rad = _degreesToRadians(endLat);
//   double lon2Rad = _degreesToRadians(endLng);
//
//   // Calculate differences
//   double dLat = lat2Rad - lat1Rad;
//   double dLon = lon2Rad - lon1Rad;
//
//   // Haversine formula
//   double a = pow(sin(dLat / 2), 2) +
//       cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
//   double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//
//   // Calculate distance
//   double distance = earthRadius * c;
//
//   return distance;
// }
//
//
//
// List<Map<String, dynamic>> filterAndSortResults(List<Map<String, dynamic>> allResults) {
//   // Assuming current location has 'currentLocationLatitude' and 'currentLocationLongitude'
//   allResults.sort((a, b) {
//     double distanceA = calculateDistance(
//       currentLocationLatitude, currentLocationLongitude,
//       a['latitude'] as double, a['longitude'] as double,
//     );
//
//     double distanceB = calculateDistance(
//       currentLocationLatitude, currentLocationLongitude,
//       b['latitude'] as double, b['longitude'] as double,
//     );
//
//     return distanceA.compareTo(distanceB);
//   });
//
//   // Return only restaurants (not items) that are nearby
//   return allResults.where((result) => result['isRestaurantORItem'] == 'Restaurant').toList();
// }
//
//
//
///---------------------search----------------///