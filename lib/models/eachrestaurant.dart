class restraurant {
  bool? success;
  List<RestaurantDtlsById>? restaurantDtlsById;
  List<ItemDtlsResId>? itemDtlsResId;

  restraurant({this.success, this.restaurantDtlsById, this.itemDtlsResId});

  restraurant.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['restaurantDtlsById'] != null) {
      restaurantDtlsById = <RestaurantDtlsById>[];
      json['restaurantDtlsById'].forEach((v) {
        restaurantDtlsById!.add(new RestaurantDtlsById.fromJson(v));
      });
    }
    if (json['itemDtlsRes_id'] != null) {
      itemDtlsResId = <ItemDtlsResId>[];
      json['itemDtlsRes_id'].forEach((v) {
        itemDtlsResId!.add(new ItemDtlsResId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.restaurantDtlsById != null) {
      data['restaurantDtlsById'] =
          this.restaurantDtlsById!.map((v) => v.toJson()).toList();
    }
    if (this.itemDtlsResId != null) {
      data['itemDtlsRes_id'] =
          this.itemDtlsResId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RestaurantDtlsById {
  int? restaurantId;
  String? restaurantName;
  int? mobileNo;
  String? address;
  String? pincode;
  String? restaurantImage;
  int? restaurantRating;
  double? latitude;
  double? longtitude;

  RestaurantDtlsById(
      {this.restaurantId,
        this.restaurantName,
        this.mobileNo,
        this.address,
        this.pincode,
        this.restaurantImage,
        this.restaurantRating,
        this.latitude,
        this.longtitude});

  RestaurantDtlsById.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    pincode = json['pincode'];
    restaurantImage = json['restaurantImage'];
    restaurantRating = json['restaurant_Rating'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
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
    return data;
  }
}

class ItemDtlsResId {
  String? sId;
  int? restaurantId;
  String? restaurantName;
  double? latitude;
  double? longtitude;
  String? type;
  int? categoryId;
  String? categoryName;
  int? itemId;
  String? itemName;
  int? price;
  String? itemImage;
  int? itemRating;
  bool? mustTry;
  bool? commonImage;

  ItemDtlsResId(
      {this.sId,
        this.restaurantId,
        this.restaurantName,
        this.latitude,
        this.longtitude,
        this.type,
        this.categoryId,
        this.categoryName,
        this.itemId,
        this.itemName,
        this.price,
        this.itemImage,
        this.itemRating,
        this.mustTry,
        this.commonImage});

  ItemDtlsResId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    type = json['type'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    price = json['price'];
    itemImage = json['itemImage'];
    itemRating = json['itemRating'];
    mustTry = json['mustTry'];
    commonImage = json['commonImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['restaurantId'] = this.restaurantId;
    data['restaurantName'] = this.restaurantName;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['type'] = this.type;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    data['itemImage'] = this.itemImage;
    data['itemRating'] = this.itemRating;
    data['mustTry'] = this.mustTry;
    data['commonImage'] = this.commonImage;
    return data;
  }
}
