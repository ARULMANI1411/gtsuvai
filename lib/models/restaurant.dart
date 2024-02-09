class restraurant {
  bool? success;
  List<RestaurantDtls>? restaurantDtls;

  restraurant({this.success, this.restaurantDtls});

  restraurant.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['restaurantDtls'] != null) {
      restaurantDtls = <RestaurantDtls>[];
      json['restaurantDtls'].forEach((v) {
        restaurantDtls!.add(new RestaurantDtls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.restaurantDtls != null) {
      data['restaurantDtls'] =
          this.restaurantDtls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantDtls {
  int? restaurantId;
  String? restaurantName;
  int? mobileNo;
  String? address;
  String? pincode;
  String? restaurantImage;
  int? restaurantRating;
  double? latitude;
  double? longtitude;
  String? type;
  String? shortAddress;

  RestaurantDtls(
      {this.restaurantId,
        this.restaurantName,
        this.mobileNo,
        this.address,
        this.pincode,
        this.restaurantImage,
        this.restaurantRating,
        this.latitude,
        this.longtitude,
        this.type,
        this.shortAddress});

  RestaurantDtls.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    pincode = json['pincode'];
    restaurantImage = json['restaurantImage'];
    restaurantRating = json['restaurant_Rating'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    type = json['type'];
    shortAddress = json['shortAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    data['restaurantName'] = this.restaurantName;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['restaurantImage'] = this.restaurantImage;
    data['restaurant_Rating'] = this.restaurantRating;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['type'] = this.type;
    data['shortAddress'] = this.shortAddress;
    return data;
  }
}
