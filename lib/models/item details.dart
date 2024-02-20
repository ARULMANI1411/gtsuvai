class images {
  bool? success;
  List<ItemDtls>? itemDtls;

  images({this.success, this.itemDtls});

  images.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['itemDtls'] != null) {
      itemDtls = <ItemDtls>[];
      json['itemDtls'].forEach((v) {
        itemDtls!.add(new ItemDtls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.itemDtls != null) {
      data['itemDtls'] = this.itemDtls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDtls {
  int? itemId;
  String? type;
  int? categoryId;
  String? categoryName;
  String? itemName;
  String? itemImage;

  ItemDtls(
      {this.itemId,
        this.type,
        this.categoryId,
        this.categoryName,
        this.itemName,
        this.itemImage});

  ItemDtls.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    type = json['type'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    itemName = json['itemName'];
    itemImage = json['itemImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['type'] = this.type;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['itemName'] = this.itemName;
    data['itemImage'] = this.itemImage;
    return data;
  }
}
