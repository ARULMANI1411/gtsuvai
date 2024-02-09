import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gtsuvai/Search.dart';
import 'package:gtsuvai/apiHotelDescroption.dart';
import 'package:gtsuvai/colors.dart';
import 'package:gtsuvai/page2.dart';
import 'package:location/location.dart';
import 'package:text_divider/text_divider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'edithotel description.dart';
import 'models/restaurant.dart';



class homeedit extends StatefulWidget {
  const homeedit({super.key});

  @override
  State<homeedit> createState() => _homeeditState();
}

class _homeeditState extends State<homeedit> {
  ///to ge map
  Future<void> _launchGoogleMapsDirections(double endLatitude, double endLongitude) async {
    LocationData currentLocation = await Location().getLocation();
    final String googleMapsUrl = "https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=$endLatitude,$endLongitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
  /// to use api
///all restrurant
  Future<List<RestaurantDtls>> getRestaurant() async{
    var resp=await http.get(Uri.parse("http://gtsuvai.gtcollege.in/Master/GetRestaurantDetails"));
    var datalist=jsonDecode(resp.body)["restaurantDtls"];
    return (datalist as List).map((e) => RestaurantDtls.fromJson(e)).toList();
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRestaurant();
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
              pinned: true,

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
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                SearchBox()),
                          );
                        });
                      },
                      child: Card(
                        elevation: 20,
                        shadowColor: Colors.black,
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width*.9,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.search,color: gtgreen,)
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: AnimatedTextKit(
                                    totalRepeatCount: 5000,
                                    animatedTexts: [
                                      RotateAnimatedText('search Restaurants..',
                                          textStyle:abc),
                                      RotateAnimatedText('search dishes..',
                                          textStyle:abc),
                                      RotateAnimatedText('search favourite foods..',
                                          textStyle:abc),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                    ), itemCount:Offer_details.length ,
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

                                  image:AssetImage(Offer_details[index].image),fit: BoxFit.fill
                              )
                          ),

                        );
                    },


                  ),),

                // Budget
                TextDivider(text: Text("Budget",style: dividertext,),thickness: 1,),

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
                                    boxShadow: [
                                      BoxShadow(
                                          color: gtgreen,
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0, 5)
                                      )
                                    ],
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

                                    boxShadow: [
                                      BoxShadow(
                                          color: gtgreen,
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0, 5)
                                      )
                                    ],


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
                  future: getRestaurant(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      List<RestaurantDtls> list = snapshot.data!;
                      //print("$list");


                      return Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height*1.65,
                        ),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (BuildContext context,Index)
                            {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height:272,
                                  width: MediaQuery.of(context).size.width*1,
                                  decoration: BoxDecoration(color: Colors.white,

                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black38,
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
                                                          image: NetworkImage("http://gtsuvai.gtcollege.in/Master/GetRestaurantDetails/"+"${list[Index].restaurantImage.toString()}"),


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
                                                    child: Text('${list[Index].restaurantName.toString()}',
                                                      style: GoogleFonts.openSans(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                  ),
                                                  Container(alignment: Alignment.center,
                                                    height: 26,width: 200,
                                                    child: Text(list[Index].restaurantName.toString(),
                                                      style: TextStyle(fontFamily: "Outfit-SemiBold",
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),),
                                                  ),
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
                                            //   Text(Similar[Index].place,
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
                                                    ),)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ///distance
                                      // Padding(
                                      //   padding: const EdgeInsets.all(2.0),
                                      //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Row(children: [
                                      //
                                      //         Text('    Distance    ${Similar[Index].distance}',
                                      //           style: TextStyle(
                                      //               color: Colors.black,
                                      //               fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"
                                      //           ),),
                                      //       ],),
                                      //
                                      //     ],),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text("   Parking",style:TextStyle(fontSize:14,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Outfit-SemiBold"),),
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
                                                _launchGoogleMapsDirections( 10.998440,76.976533); //
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
                      return CircularProgressIndicator();
                    }
                    else if(!snapshot.hasError || snapshot.data == null){
                      return Text("No data available");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],),
          ),
        ),
      ),
    );
  }
}
