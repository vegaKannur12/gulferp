class ItemCategoryModel {
  String? catId;
  String? catName;
  String? catImg;

  ItemCategoryModel({this.catId, this.catName, this.catImg});

  ItemCategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catImg = json['cat_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_img'] = this.catImg;
    return data;
  }
}

