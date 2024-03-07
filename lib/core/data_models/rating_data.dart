class ConsultantsRatingsReviews {
  int? id;
  int? cid;
  int? uid;
  int? bid;
  int? rating;
  String? review;
  String? createdAt;
  String? updatedAt;

  ConsultantsRatingsReviews({
    this.id,
    this.cid,
    this.uid,
    this.bid,
    this.rating,
    this.review,
    this.createdAt,
    this.updatedAt,
  });
  ConsultantsRatingsReviews.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    cid = int.tryParse(json['cid']?.toString() ?? '');
    uid = int.tryParse(json['uid']?.toString() ?? '');
    bid = int.tryParse(json['bid']?.toString() ?? '');
    rating = int.tryParse(json['rating']?.toString() ?? '');
    review = json['review']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['cid'] = cid;
    data['uid'] = uid;
    data['bid'] = bid;
    data['rating'] = rating;
    data['review'] = review;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ConsultantsRatings {
  List<ConsultantsRatingsReviews?>? reviews;
  int? total;

  ConsultantsRatings({
    this.reviews,
    this.total,
  });
  ConsultantsRatings.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null && (json['reviews'] is List)) {
      final v = json['reviews'];
      final arr0 = <ConsultantsRatingsReviews>[];
      v.forEach((v) {
        arr0.add(ConsultantsRatingsReviews.fromJson(v));
      });
      reviews = arr0;
    }
    total = int.tryParse(json['total']?.toString() ?? '');
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (reviews != null) {
      final v = reviews;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['reviews'] = arr0;
    }
    data['total'] = total;
    return data;
  }
}
