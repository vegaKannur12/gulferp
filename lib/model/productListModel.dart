class ProductListModel {
  String? cartCount;
  List<ProductList>? productList;

  ProductListModel({this.cartCount, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    if (json['product_list'] != null) {
      productList = <ProductList>[];
      json['product_list'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_count'] = this.cartCount;
    if (this.productList != null) {
      data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? itemId;
  String? catId;
  String? itemName;
  String? batchCode;
  String? itemImg;
  String? sRate1;

  String? stock;
  String? qty;

  ProductList(
      {this.itemId,
      this.catId,
      this.itemName,
      this.batchCode,
      this.itemImg,
      this.sRate1,
      this.stock,
      this.qty});

  ProductList.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    catId = json['cat_id'];
    itemName = json['item_name'];
    batchCode = json['batch_code'];
    itemImg = json['item_img'];
    sRate1 = json['s_rate_1'];

    stock = json['stock'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['cat_id'] = this.catId;
    data['item_name'] = this.itemName;
    data['batch_code'] = this.batchCode;
    data['item_img'] = this.itemImg;
    data['s_rate_1'] = this.sRate1;

    data['stock'] = this.stock;
    data['qty'] = this.qty;
    return data;
  }
}
