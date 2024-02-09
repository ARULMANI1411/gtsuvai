import 'dart:convert';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtsuvai/Search.dart';
import 'package:gtsuvai/apiHotelDescroption.dart';
import 'package:gtsuvai/colors.dart';
import 'package:gtsuvai/edithotel%20description.dart';
import 'package:gtsuvai/page2.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_divider/text_divider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'SearchResultsPage.dart';
import 'apiSearch.dart';
import 'models/apiSearch.dart';
import 'models/eachrestaurant.dart';
import 'models/offer.dart';
import 'models/restaurant.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geolocator;


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  TextEditingController searchcontroller=TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  List searchdetails=[];


  double currentLocationLatitude = 0.0; // Add this line
  double currentLocationLongitude = 0.0; // Add this line
  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
  ///to ge map
  Future<void> _launchGoogleMapsDirections(double endLatitude, double endLongitude) async {
    LocationData currentLocation = await Location().getLocation();
    currentLocationLatitude = currentLocation.latitude!; // Add this line
    currentLocationLongitude = currentLocation.longitude!; // Add this line

    final String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=${currentLocationLatitude},${currentLocationLongitude}&destination=$endLatitude,$endLongitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
  /// to use api
  ///---------All restaurant api----------///
  // Future<List<RestaurantDtls>> getRestaurant() async {
  //   try {
  //     var resp = await http.get(Uri.parse("http://gtsuvai.gtcollege.in/Master/GetRestaurantDetails"));
  //
  //     if (resp.statusCode == 200) {
  //       var datalist = jsonDecode(resp.body)["restaurantDtls"];
  //
  //       if (datalist != null) {
  //         return (datalist as List).map((e) => RestaurantDtls.fromJson(e)).toList();
  //       }
  //     }
  //   } catch (error) {
  //     print('Error during API request: $error');
  //   }
  //
  //   return []; // Return an empty list in case of an error or null response
  // }
  ///---------NearBy restaurant api----------///

  // Future<List<RestaurantDtls>> getNearbyRestaurants() async {
  //   try {
  //     var resp = await http.get(Uri.parse("http://gtsuvai.gtcollege.in/Master/GetRestaurantDetails"));
  //
  //     if (resp.statusCode == 200) {
  //       var datalist = jsonDecode(resp.body)["restaurantDtls"];
  //
  //       if (datalist != null) {
  //         List<RestaurantDtls> allRestaurants = (datalist as List).map((e) => RestaurantDtls.fromJson(e)).toList();
  //
  //         print("All restaurants: $allRestaurants");
  //
  //         // Filter restaurants by distance
  //         List<RestaurantDtls> nearbyRestaurants = allRestaurants
  //             .where((restaurant) {
  //           if (restaurant.latitude != null && restaurant.longtitude != null) {
  //             double distance = Geolocator.distanceBetween(
  //               currentLocationLatitude,
  //               currentLocationLongitude,
  //               restaurant.latitude!,
  //               restaurant.longtitude!,
  //             );
  //
  //             // Adjust the distance threshold as needed (e.g., 2000 meters)
  //             return distance <= 2000;
  //           }
  //           return false;
  //         })
  //             .toList()..sort((a, b) {
  //             double distanceA = Geolocator.distanceBetween(
  //               currentLocationLatitude,
  //               currentLocationLongitude,
  //               a.latitude!,
  //               a.longtitude!,
  //             );
  //
  //             double distanceB = Geolocator.distanceBetween(
  //               currentLocationLatitude,
  //               currentLocationLongitude,
  //               b.latitude!,
  //               b.longtitude!,
  //             );
  //
  //             return distanceA.compareTo(distanceB);
  //           });
  //
  //         print("Nearby restaurants (sorted): $nearbyRestaurants");
  //
  //         return nearbyRestaurants;
  //       }
  //     }
  //   } catch (error) {
  //     print('Error during API request: $error');
  //   }
  //
  //   return [];  // Return an empty list in case of an error or null response
  // }

   List list=[];

           /// text form field
  // Future<void> getRestarunt(String query) async {
  //
  //   searchResults.clear();
  //   setState(() {
  //     print(allRestaurants);
  //     allRestaurants.clear();
  //     List<RestaurantDtls> filteredRestaurants = searchResults.where((e) =>
  //     e['restraurantName'].toString().toLowerCase().contains(query.toLowerCase()) ||
  //         e['categoryName'].toString().toLowerCase().contains(query.toLowerCase()))
  //         .map((e) => RestaurantDtls.fromJson(e))
  //         .toList();
  //     allRestaurants.addAll(filteredRestaurants);
  //     allRestaurants = allRestaurants.toSet().toList(); // Convert list to a set to remove duplicates, then back to list
  //     print("Filtered results: $allRestaurants");
  //   });
  // }




  Future<List<RestaurantDtls>> getNearbyRestaurants() async {
    try {
      var resp = await http.post(
        Uri.parse("http://gtsuvai.gtcollege.in/Master/GetRestaurantDetails"),
        headers: <String, String>{
          "Content-Type": "application/json;charset=UTF-8",
        },
        body: jsonEncode(<String, dynamic>{
          "Lat": currentLocationLatitude,
          "Long": currentLocationLongitude
        }),
      );

      if (resp.statusCode == 200) {
        var datalist = jsonDecode(resp.body)["restaurantDtls"];
        if (datalist != null && datalist is List) {
          List<RestaurantDtls> allRestaurants = datalist
              .map((json) => RestaurantDtls.fromJson(json))
              .toList();
          for (var restaurant in allRestaurants) {
          print(allRestaurants);
          }
          return allRestaurants;
        }
      } else {
        print("Error code: ${resp.statusCode}");
      }
    } catch (error) {
      print('Error during API request: $error');
    }

    return []; // Return an empty list in case of an error or null response
  }






  ///Offer api
  Future<List<OfferDtls>> getoffer() async{
    var resp=await http.get(Uri.parse("http://gtsuvai.gtcollege.in/Offer/GetOffer"));
    var offerlist=jsonDecode(resp.body)["offerDtls"];
    return (offerlist as List).map((offer) => OfferDtls.fromJson(offer)).toList();
  }


  ///simple search

  // Future<List<OfferDtls>> search() async{
  //   var resp=await http.get(Uri.parse("http://localhost:3002/User/GetItem_ResDtlsByUser?Key=$searchcontroller&Lat=11.0190694&Long=76.990981"));
  //   var offerlist=jsonDecode(resp.body)["offerDtls"];
  //   return (offerlist as List).map((offer) => OfferDtls.fromJson(offer)).toList();
  // }


  ///--------filter------///
  Future<void> _getLocation() async {
    try {
      geolocator.LocationPermission permission = await geolocator.Geolocator.requestPermission();


      if (permission == geolocator.LocationPermission.always ||
          permission == geolocator.LocationPermission.whileInUse) {
        geolocator.Position position = await geolocator.Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high,
        );


        setState(() {
          currentLocationLatitude = position.latitude;
          currentLocationLongitude = position.longitude;
        });

      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  ///Calculate Distance
  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude) / 1000.0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getRestaurant();
    _getLocation();
    getNearbyRestaurants();
    getoffer();

  }

  double star=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {return[
            SliverAppBar(
              toolbarHeight: 135,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Hello Hari..',
                      style:TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,color: Colors.black,fontFamily: "Outfit-SemiBold"),),
                    // In the _homeState class
                    Card(
                      elevation: 20,
                      shadowColor: Colors.black,
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: TextField(
                              onChanged:(values){
                                //getRestarunt(values);
                              } ,
                              controller: searchcontroller,
                              decoration: InputDecoration(
                                hintText: 'Search Restaurant ',
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    // Call the handleSearch method
                                    // await handleSearch();
                                  },
                                  icon: Icon(Icons.search, color: gtgreen),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [gtgreen,Colors.white],
                    ),
                  ),

                ),

              ),
            ),
          ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text("Today's Offers",style: headers,),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: getoffer(),
                  builder: ( context,snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: MediaQuery.of(context).size.height*.18, // Height of the Shimmer container
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [gtgreen, Colors.white],
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text('No data available');
                    }
                    List<OfferDtls> list = snapshot.data!;

                    return Container(
                      height: MediaQuery.of(context).size.height*.23,
                      width: MediaQuery.of(context).size.width*1,
                      child:
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height*.21,
                          aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ), itemCount:list.length ,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return
                            Container(
                              height: MediaQuery.of(context).size.height*.25,
                              width: MediaQuery.of(context).size.width*1,
                              decoration: BoxDecoration(
                                ///removed shadow
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: gtgreen,
                                //       spreadRadius: 1,
                                //       blurRadius: 3,
                                //       offset: Offset(0, 5)
                                //   )
                                // ],
                                ///Changes radius to 15 from 25
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(

                                      image:NetworkImage("http://gtsuvai.gtcollege.in/${list[index].offerImage.toString()}"),fit: BoxFit.fill
                                  )
                              ),

                            );
                        },


                      ),);
                  },


                ),

                // Budget
                TextDivider(text: Text("Budget",style: dividertext,),thickness: 1,),
                SizedBox(height: 5,),

                Container(
                  height: 100,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: budgetdetails.length,
                      itemBuilder: (BuildContext, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0,left: 15),
                              child: Container(
                                height: 80,
                                width:80 ,
                                decoration: BoxDecoration(
                                  ///Removed Shadow
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       color: gtgreen,
                                  //       spreadRadius: 1,
                                  //       blurRadius: 3,
                                  //       offset: Offset(0, 5)
                                  //   )
                                  // ],
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage(budgetdetails[index].image),fit: BoxFit.fill)
                                ),
                                child: Center(child: Text(budgetdetails[index].text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.white),)),

                              ),
                            ),


                          ],
                        );
                      },
                    ),
                  ),

                ),
                TextDivider(text: Text("Explore by Catogories",style: dividertext,),thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,left: 8),
                  child: Container(
                    height: 112,
                    width: double.infinity,
                    child: ListView.builder(
                      addRepaintBoundaries: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: cata.length,
                      itemBuilder: (BuildContext, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5),
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  ///Removed Shadow
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //       color: gtgreen,
                                  //       spreadRadius: 1,
                                  //       blurRadius: 3,
                                  //       offset: Offset(0, 5)
                                  //   )
                                  // ],


                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage(cata[index].image),fit: BoxFit.fill)
                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(cata[index].text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              ),

                            ],
                          ),

                        );
                      },
                    ),

                  ),
                ),



                TextDivider(text: Text("All Restaurants",style: dividertext,),thickness: 1,),

                FutureBuilder(
                  future: getNearbyRestaurants(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                       list = snapshot.data!;



                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height*3,
                        ),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,

                            itemBuilder: (BuildContext context, Index) {
                              double distance = calculateDistance(
                                currentLocationLatitude,
                                currentLocationLongitude,
                                list[Index].latitude!.toDouble(),
                                list[Index].longtitude!.toDouble(),
                              );

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:272,
                                  width: MediaQuery.of(context).size.width*1,
                                  decoration: BoxDecoration(color: Colors.white,
                                    /// --------------------------------------------- Colour of Shadow Changed---------------------------------------------------------------------------------
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 0,
                                          blurRadius: 12,
                                          offset: const Offset(0, 10)
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20),

                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => HotelDescriptionApiedit(
                                                    restaurantId: list[Index].restaurantId

                                                ) ));


                                              },
                                              child: Container(
                                                  height:180,
                                                  width: MediaQuery.of(context).size.width*1,
                                                  foregroundDecoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    gradient: const LinearGradient(
                                                        begin: Alignment.bottomCenter,
                                                        end: Alignment.topCenter,
                                                        colors: [
                                                          Colors.black,
                                                          Colors.black12,
                                                        ]
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage("http://gtsuvai.gtcollege.in/${list[Index].restaurantImage.toString().replaceAll('\\', '/')}"),
                                                          fit: BoxFit.fill
                                                      ),
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25),
                                                        topRight: Radius.circular(20),topLeft: Radius.circular(20),)
                                                  )
                                              ),
                                            ),
                                            Positioned(
                                              left: MediaQuery.of(context).size.height*.015,
                                              bottom: MediaQuery.of(context).size.height*.015,
                                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(alignment: Alignment.center,
                                                    height: 26,width: 200,
                                                    child: Text(list[Index].restaurantName.toString(),
                                                      style: GoogleFonts.openSans(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                  ),
                                                  // Container(alignment: Alignment.center,
                                                  //   height: 26,width: 200,
                                                  //   child: Text(list[Index].type.toString(),
                                                  //     style: TextStyle(fontFamily: "Outfit-SemiBold",
                                                  //       color: Colors.white,
                                                  //       fontSize: 15,
                                                  //     ),),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ]
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ///place name in list view
                                            // Row(children: [
                                            //   Icon(Icons.location_on_outlined,color: gtgreen,),
                                            //   Text(snapshot.data![Index].shortAddress.toString(),
                                            //     style: GoogleFonts.openSans(
                                            //         color: Colors.black,
                                            //         fontSize: 14,fontWeight: FontWeight.bold
                                            //     ),),
                                            // ],),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10.0,),
                                              child: Row(
                                                children: [

                                                  Padding(
                                                    padding: EdgeInsets.only(right: 8.0),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height:MediaQuery.of(context).size.height*.0185,
                                                      width: MediaQuery.of(context).size.width*.21,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        // border: Border.all(color: Colors.yellowAccent,width: 2),
                                                        color: Colors.green,
                                                      ),
                                                      child:
                                                      RatingBar.builder(
                                                        glowRadius: 3,
                                                        initialRating: 3,
                                                        minRating: 1,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 15,
                                                        itemPadding: const EdgeInsets.symmetric(horizontal:0),
                                                        itemBuilder: (context, _) => const Icon(
                                                          Icons.star_rate,
                                                          size:1,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate: (rating) {
                                                          setState(() {
                                                            star=rating;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Text(   '${star}'  ,
                                                    //Similar[Index].rating,
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.black,
                                                        fontSize: 16,fontWeight: FontWeight.bold
                                                    ),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ///distance
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Distance: ${distance.toStringAsFixed(2)} km',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Outfit-SemiBold",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text("   Parking",
                                                  style:TextStyle(fontSize:14,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                    height: 25,
                                                    width:45,
                                                    decoration: BoxDecoration(color: Colors.white,
                                                        borderRadius: BorderRadius.circular(5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black12,
                                                            spreadRadius: 0.5,
                                                            blurRadius: 10,
                                                            offset: const Offset(0, 7),
                                                          )
                                                        ]
                                                    ),
                                                    child: Center(child: Icon(Icons.directions_car,color:Colors.red,))),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                    height: 25,
                                                    width:45,
                                                    decoration: BoxDecoration(color: Colors.white,
                                                        borderRadius: BorderRadius.circular(5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black12,
                                                            spreadRadius: 0.5,
                                                            blurRadius: 10,
                                                            offset: const Offset(0, 7),
                                                          )
                                                        ]
                                                    ),
                                                    child: Center(child: Icon(Icons.two_wheeler,color:Colors.green,))),
                                              ),

                                            ],),
                                            GestureDetector(
                                              onTap: (){
                                                _launchGoogleMapsDirections( snapshot.data![Index].latitude!.toDouble(),snapshot.data![Index].longtitude!.toDouble()); //
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10.0),
                                                child: Icon(Icons.directions,color:Colors.green,size: 35,),
                                              ),
                                            )

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );

                    }
                    else if(snapshot.connectionState == ConnectionState.waiting){
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[500]!,
                        highlightColor: Colors.grey[100]!,
                        child:
                        Container(
                          height:272,
                          width: MediaQuery.of(context).size.width*1,
                        ),
                      );
                    }
                    else if(!snapshot.hasError || snapshot.data == null){
                      return Text("No data available");
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[500]!,
                      highlightColor: Colors.grey[100]!,
                      child:
                      Container(
                        height:272,
                        width: MediaQuery.of(context).size.width*1,
                      ),
                    );
                  },
                ),

              ],),
          ),
        ),
      ),
    );
  }
}






