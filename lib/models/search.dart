class search {
  bool? success;
  List<RestaurantDtls>? restaurantDtls;

  search({this.success, this.restaurantDtls});

  search.fromJson(Map<String, dynamic> json) {
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
  double? latitude;
  double? longtitude;
  String? itemName;
  double? price;
  String? itemImage;
  double? distance;
  String? isRestaurantORItem;
  String? restaurantImage;
  int? restaurantRating;
  int? itemRating;

  RestaurantDtls(
      {this.restaurantId,
        this.restaurantName,
        this.latitude,
        this.longtitude,
        this.itemName,
        this.price,
        this.itemImage,
        this.distance,
        this.isRestaurantORItem,
        this.restaurantImage,
        this.restaurantRating,
        this.itemRating});

  RestaurantDtls.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    itemName = json['itemName'];
    price = json['price'];
    itemImage = json['itemImage'];
    distance = json['distance'];
    isRestaurantORItem = json['isRestaurantORItem'];
    restaurantImage = json['restaurantImage'];
    restaurantRating = json['restaurantRating'];
    itemRating = json['item_Rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurantId'] = this.restaurantId;
    data['restaurantName'] = this.restaurantName;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    data['itemImage'] = this.itemImage;
    data['distance'] = this.distance;
    data['isRestaurantORItem'] = this.isRestaurantORItem;
    data['restaurantImage'] = this.restaurantImage;
    data['restaurantRating'] = this.restaurantRating;
    data['item_Rating'] = this.itemRating;
    return data;
  }
}
