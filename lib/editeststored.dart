///----------Real Rastaurant Page--------///

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtsuvai/apihome.dart';
import 'package:gtsuvai/pg3.dart';
import 'package:location/location.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import 'colors.dart';
import 'models/eachrestaurant.dart';
import 'models/restaurant.dart';



class HotelDescriptionApiedit extends StatefulWidget {
  final int? restaurantId;
  HotelDescriptionApiedit({ Key?key, required this.restaurantId}): super(key: key);



  @override
  State<HotelDescriptionApiedit> createState() => _HotelDescriptionApieditState();
}

class _HotelDescriptionApieditState extends State<HotelDescriptionApiedit> {
  Future<void> _launchGoogleMapsDirections(double endLatitude, double endLongitude) async {
    LocationData currentLocation = await Location().getLocation();
    final String googleMapsUrl = "https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=$endLatitude,$endLongitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  Future<List<RestaurantDtlsById>> fetchrestaurantdetails() async {
    var resp= await http.get(Uri.parse("http://gtsuvai.gtcollege.in/Master/GetRestaurantDetailsById?restaurantId=${widget.restaurantId}"));
    var datalist=jsonDecode(resp.body)["restaurantDtlsById"];
    return (datalist as List).map((e)=>RestaurantDtlsById.fromJson(e)).toList();

  }
  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    fetchrestaurantdetails();

  }

  var currentIndex = 0;

  // final number='9876543210';
  double star=0;
  @override
  Widget build(BuildContext context) {

    return

      FutureBuilder(
        future: fetchrestaurantdetails(),
        builder: ( context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available');
          }

          return  Scaffold(
            body: SafeArea(
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  children:[
                    SingleChildScrollView(
                        child: Column(
                            children: [
                              Stack(
                                children: [

                                  Container(
                                    height: MediaQuery.of(context).size.height*0.3,
                                    width: MediaQuery.of(context).size.width*1,
                                    decoration:
                                    const BoxDecoration(),
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        stops: [0, 10.0],
                                      ),
                                    ),
                                    child: Image(
                                      image: NetworkImage("http://gtsuvai.gtcollege.in/"+"${snapshot.data![0].restaurantImage.toString()}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // Positioned(
                                  //   left: MediaQuery.of(context).size.height*.37,
                                  //   top: MediaQuery.of(context).size.height*.26,
                                  //   child: const Text(
                                  //     "Gallery >",
                                  //     style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "Outfit-SemiBold"),
                                  //   ),
                                  // ),

                                  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>
                                                home()),
                                          );
                                        });
                                      },
                                      child: Icon(Icons.arrow_left,size: 40,color: Colors.white,)),
                                  Positioned(
                                    left: 10,
                                    bottom: 10,
                                    //top: MediaQuery.of(context).size.height*.3,
                                    child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![0].restaurantName.toString(),
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold
                                                )
                                            )
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Text("Menu from Google",style: dividertext,),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: bgclr,
                                  child: Container(

                                    height: MediaQuery.of(context).size.height *0.2,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(

                                    ),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,

                                        itemCount: gt.length,
                                        itemBuilder: (BuildContext con, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => m1(
                                                      Gts: gt[index],
                                                    )));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image(image: AssetImage(gt[index].image),fit: BoxFit.fill,),
                                              ));
                                        }),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Text("payment Offer",style: dividertext,),
                                  Expanded(child: Divider()),

                                ],
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*.18,
                                width: MediaQuery.of(context).size.width*1,
                                child:
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height*.16,
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
                                  ), itemCount:dis.length ,
                                  itemBuilder: (BuildContext context, int index, int realIndex) {
                                    return
                                      Container(
                                        height: MediaQuery.of(context).size.height*.25,
                                        width: MediaQuery.of(context).size.width*1,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: gtgreen,
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: Offset(0, 5)
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(25),
                                            image: DecorationImage(

                                                image:AssetImage(dis[index].image),fit: BoxFit.fill
                                            )
                                        ),

                                      );
                                  },


                                ),),
                              Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Text("Location and timing",style: dividertext,),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.location_on_outlined,size: 38,color: Colors.black54,),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:   Text(snapshot.data![0].address.toString(),
                                        style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,
                                            fontSize: 18,fontFamily: "Outfit-SemiBold"),


                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder(
                                  future: fetchrestaurantdetails(),
                                  builder: ( context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    } else if (!snapshot.hasData || snapshot.data == null) {
                                      return Text('No data available');
                                    }
                                    return  GestureDetector(
                                      onTap: (){
                                        _launchGoogleMapsDirections( snapshot.data![0].latitude!.toDouble(),snapshot.data![0].longtitude!.toDouble());
                                      },
                                      child: Card(
                                        elevation: 20,
                                        child: Row(children: [SizedBox(width: 80,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("View On Map",style:
                                            TextStyle(color: gtgreen,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                          )
                                        ],
                                        ),
                                      ),
                                    );
                                  },


                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.access_time_outlined,size: 38,color: Colors.black54,),
                                ),
                                SizedBox(width: 25,),
                                Text("CLOSED, OPEN AT 11AM",style:
                                TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18,fontFamily: "Outfit-SemiBold")),
                              ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                  title: Text("         Weekly Timings",style:
                                  TextStyle(color: gtgreen,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),
                                  ),
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height*0.7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),

                                      ),
                                      child: const Column(
                                        children: [

                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  Text("Monday",style:
                                                  TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  Text("11AM - 9.30PM",style:
                                                  TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  SizedBox(height: 5,),
                                                  Text("Tuesday",style:
                                                  TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  Text("11AM - 9.30PM",style:
                                                  TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  SizedBox(height: 5,),
                                                  Text("Wednesday",style:
                                                  TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  Text("11AM - 9.30PM",style:
                                                  TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  SizedBox(height: 5,),
                                                  Text("Thursday",style:
                                                  TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  Text("11AM - 9.30PM",style:
                                                  TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  SizedBox(height: 5,),
                                                  Text("Friday",style:
                                                  TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  Text("11AM - 9.30PM",style:
                                                  TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  SizedBox(height: 5,),
                                                  Text("Saturday",style:
                                                  TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  Text("11AM - 9.30PM",style:
                                                  TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  SizedBox(height: 5,),
                                                  Text("Sunday",style:
                                                  TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                  Text("11AM - 9.30PM",style:
                                                  TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                                ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Row(children: [
                                Expanded(child: Divider()),
                                Text("Features",style: dividertext,),
                                Expanded(child: Divider()),
                              ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Row(children: [
                                  Icon(Icons.wifi,size: 30,color: Colors.black54,),
                                  Text(" Free Wifi",style: TextStyle(color: Colors.black54,fontFamily: "Outfit-SemiBold"),),
                                  SizedBox(width: 50,),
                                  Icon(Icons.credit_card,color: Colors.black54),
                                  Text(" Card Accepted",style: TextStyle(color: Colors.black54,fontFamily: "Outfit-SemiBold"),),

                                ],
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 10,),
                              Container(
                                  height: 425,
                                  color: bgclr,
                                  child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Similar restaurant",style:
                                              TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
                                            ),
                                          ],
                                        ),
                                        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Card(
                                              elevation:20,
                                              child: Container(
                                                  height:290,
                                                  width: MediaQuery.of(context).size.width*1,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),

                                                  ),
                                                  child:

                                                  ListView.builder   (
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: Similar.length,
                                                    itemBuilder: (BuildContext context, int index) {

                                                      return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Stack(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Container(
                                                                    height:MediaQuery.of(context).size.height*.20,
                                                                    width: MediaQuery.of(context).size.width*1,
                                                                    foregroundDecoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      gradient: LinearGradient(
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
                                                                            image: NetworkImage("http://gtsuvai.gtcollege.in/"+"${snapshot.data![0].restaurantImage.toString()}"),fit: BoxFit.fill
                                                                        ),
                                                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25),
                                                                          topRight: Radius.circular(20),topLeft: Radius.circular(20),)
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: MediaQuery.of(context).size.height*.020,
                                                                  bottom: MediaQuery.of(context).size.height*.035,
                                                                  child: Text(snapshot.data![0].restaurantName.toString(),
                                                                    style: GoogleFonts.openSans(
                                                                        color: Colors.white,
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.bold
                                                                    ),),
                                                                ),
                                                                ///cusine type
                                                                Positioned(
                                                                  left: MediaQuery.of(context).size.height*.04,
                                                                  bottom: MediaQuery.of(context).size.height*.02,
                                                                  child: Text(snapshot.data![0].restaurantId.toString(),
                                                                    style: GoogleFonts.openSans(
                                                                      color: Colors.white,
                                                                      fontSize: 15,
                                                                    ),),
                                                                ),
                                                              ]
                                                          ),
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top:2.0),
                                                                  child: Icon(Icons.location_on_outlined,color: gtgreen,),
                                                                ),
                                                                Text(  Similar[index].place,
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 16,fontWeight: FontWeight.bold,fontFamily:"Outfit-SemiBold"
                                                                  ),),
                                                              ],),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 10.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                                                                    Text("${star}",
                                                                      style: GoogleFonts.openSans(
                                                                          color: Colors.black,
                                                                          fontSize: 16,fontWeight: FontWeight.bold
                                                                      ),)
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(Similar[index].distance,
                                                                style: TextStyle(
                                                                    color: Colors.black,fontFamily: "Outfit-SemiBold",
                                                                    fontSize: 16,fontWeight: FontWeight.bold
                                                                ),),

                                                            ],),
                                                          Row(children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("Parking",style: GoogleFonts.openSans(fontSize:16,color: Colors.black,fontWeight: FontWeight.bold),),
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                  height: 25,
                                                                  width:45,
                                                                  decoration: BoxDecoration(border: Border.all(),color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(5),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors.black87,
                                                                          spreadRadius: 0.5,
                                                                          blurRadius: 25,
                                                                          offset: const Offset(0, 5),
                                                                        )
                                                                      ]
                                                                  ),
                                                                  child: Center(child: Icon(Icons.directions_car,color:Colors.red,))),
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                  height: 25,
                                                                  width:45,
                                                                  decoration: BoxDecoration(border: Border.all(),color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(5),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors.black87,
                                                                          spreadRadius: 0.5,
                                                                          blurRadius: 25,
                                                                          offset: const Offset(0, 5),
                                                                        )
                                                                      ]
                                                                  ),
                                                                  child: Center(child: Icon(Icons.two_wheeler,color:Colors.green,))),
                                                            ),
                                                            SizedBox(width: 150,),

                                                            GestureDetector(
                                                                onTap: (){
                                                                  _launchGoogleMapsDirections( snapshot.data![0].latitude!.toDouble(),snapshot.data![0].longtitude!.toDouble());

                                                                },
                                                                child: Icon(Icons.directions,color:Colors.green,size: 35,))

                                                          ],)
                                                        ],);
                                                    },

                                                  )
                                              ),
                                            ),





                                          ],
                                        ),
                                      ]
                                  )








                              ),
                            ] )
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.black38,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*.4,
                            decoration: BoxDecoration(
                                color: gtgreen,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child:Container(
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () async{
                                    final Uri url=Uri(
                                      scheme: 'tel',
                                      path: snapshot.data![0].mobileNo.toString(),
                                    );
                                    if(await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }else{
                                      print('cannot launch the url');
                                    }
                                  }
                                  , child:Icon(Icons.call)),
                            ),

                          ),

                          Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width*.4,
                              decoration: BoxDecoration(
                                  color: gtgreen,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child:ElevatedButton(onPressed: ()async{
                                final weburl = 'google.com/';
                                Share.share('${weburl}');
                              }, child: Icon(Icons.share))

                          ),
                        ],
                      ),
                    )
                  ]
              ),
            ),

          );
        },


      );





  }
}
