import 'package:flutter/material.dart';
import 'package:gulferp/components/globalData.dart';
import 'package:gulferp/model/itemCategoryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/network_connectivity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  bool isLoading = false;
  bool filter = false;

  String? cartCount;
  List<bool> errorClicked = [];
  List<String> uniquelist = [];
  List<String> filtereduniquelist = [];

  List<Map<String, dynamic>> filteredproductList = [];

  List<String> productbar = [];
  List<String> filteredproductbar = [];

  bool isProdLoading = false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> historyList = [];

  List<TextEditingController> qty = [];

  // List<BranchModel> branchist = [];
  // List<TransactionTypeModel> transactionist = [];

  List<ItemCategoryModel> itemCategoryList = [];

/////////////////////////////////////////////////////////////////
  getItemCategory(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/category_list.php");

          // isDownloaded = true;
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
          );

          // print("body ${body}");
          ItemCategoryModel itemCategory;
          List map = jsonDecode(response.body);
          productList.clear();
          productbar.clear();
          itemCategoryList.clear();
          for (var item in map) {
            itemCategory = ItemCategoryModel.fromJson(item);
            itemCategoryList.add(itemCategory);
          }

          isLoading = false;
          notifyListeners();
          return itemCategoryList;
          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getProductDetails() async {
    // print("sid.......$branchid........${sid}");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? branch_id = prefs.getString("branch_id");
      String? staff_name = prefs.getString("staff_name");
      String? branch_name = prefs.getString("branch_name");
      String? branch_prefix = prefs.getString("branch_prefix");
      String? user_id = prefs.getString("user_id");
      print("kjn---------------$branch_id----$user_id-");
      Uri url = Uri.parse("$urlgolabl/products_list.php");

      Map body = {'staff_id': user_id, 'branch_id': branch_id};
      print("body----${body}");
      // isDownloaded = true;
      isProdLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );

      isProdLoading = false;
      notifyListeners();

      print("body ${body}");
      var map = jsonDecode(response.body);

      print("nmnmkzd-------${map}");
      productList.clear();
      productbar.clear();

      cartCount = map["cart_count"].toString();

      notifyListeners();
      // print("map["product_list"]")
      for (var pro in map["product_list"]) {
        print("pro------$pro");
        productbar.add(pro["item_name"][0]);
        productList.add(pro);
      }
      qty =
          List.generate(productList.length, (index) => TextEditingController());
      errorClicked = List.generate(productList.length, (index) => false);

      print("qty------$qty");

      for (int i = 0; i < productList.length; i++) {
        print("qty------${productList[i]["qty"]}");
        qty[i].text = productList[i]["qty"].toString();
      }
      notifyListeners();
      var seen = Set<String>();
      uniquelist =
          productbar.where((productbar) => seen.add(productbar)).toList();
      uniquelist.sort();
      print("productDetailsTable--map ${productList}");
      print("productbar--map ${uniquelist}");

      return productList;
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

  /////////////////////////////////////////////////////////////////////////////
  filterProduct(String selected) {
    print("productzszscList----$productList");
    isLoading = true;
    filteredproductList.clear();
    filteredproductbar.clear();
    for (var item in productList) {
      if (item["cat_id"] == selected) {
        filteredproductbar.add(item["item_name"][0]);
        filteredproductList.add(item);
      }
    }

    isLoading = false;
    print("filsfns----$filteredproductList");
    notifyListeners();
  }
  ////////////////////////////////////////////////////////////
    setfilter(bool fff) {
    print("filter----$filter");
    filter = fff;
    notifyListeners();
  }
  ///////////////////////////////////////////////////////////
    setbardata() {
    filter = true;
    isLoading = true;
    notifyListeners();
    print("filterdeproductbar---$filteredproductbar");
    var seen = Set<String>();
    filtereduniquelist.clear();
    filtereduniquelist =
        filteredproductbar.where((productbar) => seen.add(productbar)).toList();
    filtereduniquelist.sort();
    notifyListeners();

    print("filtereduniquelist-----$filtereduniquelist");
    isLoading = false;
    notifyListeners();
  }
 ///////////////////////////////////////////////////
 
}
