import 'package:flutter/material.dart';
import 'package:gulferp/components/globalData.dart';
import 'package:gulferp/model/itemCategoryModel.dart';
import 'package:gulferp/model/routeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/network_connectivity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  bool isLoading = false;
  bool filter = false;
  String? routeName;
  String? staff_name;
  String? branch_name;
  String? cusName1;
  String? cartCount;
  List<bool> errorClicked = [];
  List<String> uniquelist = [];
  List<String> uniquecustomerlist = [];

  List<String> filtereduniquelist = [];

  List<Map<String, dynamic>> filteredproductList = [];
  List<Map<String, dynamic>> loadingList = [];
  List<RouteModel> routeList = [];

  List<String> productbar = [];
  List<String> customerbar = [];

  List<String> filteredproductbar = [];

  bool isProdLoading = false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> customerList = [];

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

  ////////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getCustomerList(String routeId) async {
    print("routeId.......$routeId.");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? branch_id = prefs.getString("branch_id");
      // String? staff_name = prefs.getString("staff_name");
      // String? branch_name = prefs.getString("branch_name");
      // String? branch_prefix = prefs.getString("branch_prefix");
      // String? user_id = prefs.getString("user_id");
      // print("kjn---------------$branch_id----$user_id-");
      Uri url = Uri.parse("$urlgolabl/customer_list.php");

      Map body = {'r_id': routeId};
      print("body----${body}");
      // isDownloaded = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );

      isLoading = false;
      notifyListeners();

      print("body ${body}");
      var map = jsonDecode(response.body);

      print("customer list-------${map}");
      customerList.clear();
      customerbar.clear();

      // cartCount = map["cart_count"].toString();

      notifyListeners();
      // print("map["product_list"]")
      for (var item in map) {
        print("pro------$item");
        customerbar.add(item["Customer"][0]);
        customerList.add(item);
      }
      // qty =
      //     List.generate(productList.length, (index) => TextEditingController());
      // errorClicked = List.generate(productList.length, (index) => false);

      // print("qty------$qty");

      // for (int i = 0; i < productList.length; i++) {
      //   print("qty------${productList[i]["qty"]}");
      //   qty[i].text = productList[i]["qty"].toString();
      // }
      notifyListeners();
      var seen = Set<String>();
      uniquecustomerlist =
          customerbar.where((customerbar) => seen.add(customerbar)).toList();
      uniquecustomerlist.sort();
      print("productDetailsTable--map ${customerList}");
      print("productbar--map ${uniquecustomerlist}");

      return customerList;
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      // return null;
      return [];
    }
  }

  setCustomerName(String cusName) {
    cusName1 = cusName;

    print("cysujkjj------$cusName1");
    notifyListeners();
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

  userDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? staff_nam = prefs.getString("staff_name");
    String? branch_nam = prefs.getString("branch_name");

    staff_name = staff_nam;
    branch_name = branch_nam;

    print("staff_name----$staff_name---$branch_name");
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
  getRouteList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          RouteModel routemodel = RouteModel();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // branch_id = prefs.getString("branch_id");
          Uri url = Uri.parse("$urlgolabl/route_list.php");
          Map body = {
            // 'branch_id': branch_id,
          };
          isLoading = true;
          // notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          // print("body ${body}");
          var map = jsonDecode(response.body);
          print("branchlist-----$map");
          routeList.clear();
          // productbar.clear();
          for (var item in map) {
            routemodel = RouteModel.fromJson(item);
            routeList.add(routemodel);
          }

          // if (page == "history") {
          //   for (var i = 0; i < routeList.length; i++) {
          //     // if (routeList[i].uID == brId) {
          //     //   routeName = routeList[i].branchName;
          //     // }
          //   }
          //   // print("brId------${branchist[i].branchName}");
          // }

          isLoading = false;
          notifyListeners();
          return routeList;
          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////
  getvehicleLoadingList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/stock_approve_list.php");
          Map body = {
            // 'branch_id': branch_id,
          };
          print("mbody-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("stock approval list-----------------$map");

          isLoading = false;
          notifyListeners();
          loadingList.clear();
          if (map != null) {
            for (var item in map) {
              loadingList.add(item);
            }
          }

          print("stock_approve_list---$loadingList");
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////// get bag list from api///////////////////
// getbagData1(BuildContext context) async {
//     NetConnection.networkConnection(context).then((value) async {
//       if (value == true) {
//         try {
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           branch_id = prefs.getString("branch_id");
//           user_id = prefs.getString("user_id");
//           print("kjn---------------$branch_id----$user_id-");
//           Uri url = Uri.parse("$urlgolabl/cart_list.php");
//           Map body = {
//             'staff_id': user_id,
//             'branch_id': branch_id,
//           };
//           print("cart body-----$body");

//           isLoading = true;
//           notifyListeners();

//           http.Response response = await http.post(
//             url,
//             body: body,
//           );

//           var map = jsonDecode(response.body);
//           print("cart response-----------------${map}");

//           ProductListModel productListModel;
//           bagList.clear();
//           if (map != null) {
//             for (var item in map) {
//               productListModel = ProductListModel.fromJson(item);
//               bagList.add(item);
//             }
//           }
//           print("bag list data........${bagList.length}");
//           isLoading = false;
//           notifyListeners();

//           /////////////// insert into local db /////////////////////
//         } catch (e) {
//           print("error...$e");
//           // return null;
//           return [];
//         }
//       }
//     });
//   }

}
