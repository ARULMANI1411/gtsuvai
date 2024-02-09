// Create SearchResultsPage.dart
import 'package:flutter/material.dart';
import 'models/apiSearch.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;

  SearchResultsPage({
    required this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index]['restaurantName']),
            // Add other information as needed
          );
        },
      ),
    );
  }
}



// // Create SearchResultsPage.dart
// import 'package:flutter/material.dart';
// import 'models/apiSearch.dart';
// import 'dart:math';
//
// class SearchResultsPage extends StatelessWidget {
//   final List<SearchResult> searchResults;
//   final double currentLocationLatitude;
//   final double currentLocationLongitude;
//
//   SearchResultsPage({
//     required this.searchResults,
//     required this.currentLocationLatitude,
//     required this.currentLocationLongitude,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search Results'),
//       ),
//       body: ListView.builder(
//         itemCount: searchResults.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(searchResults[index].restaurantName),
//             subtitle: Text('Distance: ${calculateDistance(currentLocationLatitude, currentLocationLongitude, searchResults[index].latitude, searchResults[index].longitude)} km'),
//             // Add other information as needed
//           );
//         },
//       ),
//     );
//   }
//
//   double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
//     const double earthRadius = 6371;
//     double lat1Rad = _degreesToRadians(startLat);
//     double lon1Rad = _degreesToRadians(startLng);
//     double lat2Rad = _degreesToRadians(endLat);
//     double lon2Rad = _degreesToRadians(endLng);
//
//     double dLat = lat2Rad - lat1Rad;
//     double dLon = lon2Rad - lon1Rad;
//
//     double a = pow(sin(dLat / 2), 2) +
//         cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//
//     return earthRadius * c;
//   }
//
//   double _degreesToRadians(double degrees) {
//     return degrees * (pi / 180);
//   }
// }
