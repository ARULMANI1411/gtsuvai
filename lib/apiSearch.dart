import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchBoxApi extends StatefulWidget {
  const SearchBoxApi({Key? key}) : super(key: key);

  @override
  State<SearchBoxApi> createState() => _SearchBoxApiState();
}

class _SearchBoxApiState extends State<SearchBoxApi> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  Future<void> searchRestaurant(String query) async {
    final String apiUrl =
        'http://gtsuvai.gtcollege.in/User/GetItem_ResDtlsByUser?Key=cof&Lat=11.0190694&Long=76.990981';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map && responseData.containsKey('success') && responseData['success']) {
          setState(() {
            searchResults = List<Map<String, dynamic>>.from(responseData['restaurantDtls']);
          });
        } else {
          // Handle API response indicating failure
          print('API request failed');
        }
      } else {
        // Handle HTTP errors
        print('Failed to load data: ${response.statusCode}');
        // You might want to show a user-friendly error message
        // through a SnackBar or another mechanism
      }
    } catch (error) {
      // Handle other errors, e.g., network issues
      print('Error during API request: $error');
      // You might want to show a user-friendly error message
      // through a SnackBar or another mechanism
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Your app bar code here
        backgroundColor: Colors.transparent,
        centerTitle: false,
        toolbarHeight: 120,
        title: SizedBox(
          height: 40,
          width: double.infinity,
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: "Search Restaurant",
              contentPadding: const EdgeInsets.only(top: 4, left: 10),
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              suffixIcon: IconButton(
                onPressed: () async {
                  await searchRestaurant(searchController.text);
                },
                icon: const Icon(Icons.search, color: Colors.grey),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
      ),
      body: searchResults.isNotEmpty
          ? ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> result = searchResults[index];
          return ListTile(
            title: Text(
              result['restaurantName'] ?? 'N/A',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              result['itemName'] ?? 'N/A',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            // You can customize this further with more widgets
          );
        },
      )
          : Center(
        child: Text('No results found'),
      ),
    );
  }
}
