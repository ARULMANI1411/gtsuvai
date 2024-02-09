// apiSearch.dart

class SearchResult {
  final String restaurantName;
  final double latitude;
  final double longitude;
  // Add other properties as needed

  SearchResult({
    required this.restaurantName,
    required this.latitude,
    required this.longitude,
    // Initialize other properties
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      restaurantName: json['restaurantName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      // Parse other properties
    );
  }
}
