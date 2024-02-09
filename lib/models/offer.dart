class offer {
  bool? success;
  List<OfferDtls>? offerDtls;

  offer({this.success, this.offerDtls});

  offer.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['offerDtls'] != null) {
      offerDtls = <OfferDtls>[];
      json['offerDtls'].forEach((v) {
        offerDtls!.add(new OfferDtls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.offerDtls != null) {
      data['offerDtls'] = this.offerDtls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferDtls {
  int? offerId;
  String? resName;
  String? resImage;
  String? offerImage;
  String? validFrom;
  String? validTo;
  String? description;

  OfferDtls(
      {this.offerId,
        this.resName,
        this.resImage,
        this.offerImage,
        this.validFrom,
        this.validTo,
        this.description});

  OfferDtls.fromJson(Map<String, dynamic> json) {
    offerId = json['offerId'];
    resName = json['res_Name'];
    resImage = json['res_Image'];
    offerImage = json['offerImage'];
    validFrom = json['validFrom'];
    validTo = json['validTo'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerId'] = this.offerId;
    data['res_Name'] = this.resName;
    data['res_Image'] = this.resImage;
    data['offerImage'] = this.offerImage;
    data['validFrom'] = this.validFrom;
    data['validTo'] = this.validTo;
    data['description'] = this.description;
    return data;
  }
}
