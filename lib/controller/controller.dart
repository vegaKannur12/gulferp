import 'package:flutter/material.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/components/globalData.dart';
import 'package:gulferp/model/itemCategoryModel.dart';
import 'package:gulferp/model/productListModel.dart';
import 'package:gulferp/model/routeModel.dart';
import 'package:gulferp/screen/dashboard/maindashBoard.dart';
import 'package:gulferp/screen/sale/saleHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/network_connectivity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  bool isLoading = false;
  bool filter = false;
  String? routeName;
  String? dropdwnVal;
  String? dropdwnString;
  String? branch_id;
  String? staff_name;
  String? branch_name;
  String? branch_prefix;
  String? user_id;
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
  String? fromDate;
  String? todate;
  List<String> filteredproductbar = [];

  bool isProdLoading = false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> vehicle_loading_masterlist = [];
  List<Map<String, dynamic>> vehicle_loading_detaillist = [];
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> historyList = [];

  List<TextEditingController> qty = [];

  // List<BranchModel> branchist = [];
  // List<TransactionTypeModel> transactionist = [];

  List<ItemCategoryModel> itemCategoryList = [];
  int? qtyinc;

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
          ItemCategoryModel itemCategory;
          List map = jsonDecode(response.body);
          print("dropdwn------$map");
          productList.clear();
          productbar.clear();
          itemCategoryList.clear();
          for (var item in map) {
            itemCategory = ItemCategoryModel.fromJson(item);
            itemCategoryList.add(itemCategory);
          }

          dropdwnVal = itemCategoryList[0].catName.toString();
          notifyListeners();

          // notifyListeners();

          isLoading = false;
          notifyListeners();
          print("sdhjz-----$dropdwnVal");

          return dropdwnVal;
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
  Future<List<Map<String, dynamic>>> getProductDetails(
      String cat_id, String catName, String form_type) async {
    print("cat_id.......$cat_id---$catName");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      branch_id = prefs.getString("branch_id");
      staff_name = prefs.getString("staff_name");
      branch_name = prefs.getString("branch_name");
      branch_prefix = prefs.getString("branch_prefix");
      user_id = prefs.getString("user_id");
      print("kjn---------------$branch_id----$user_id-");
      Uri url = Uri.parse("$urlgolabl/products_list2.php");

      Map body = {
        'staff_id': user_id,
        'branch_id': branch_id,
        'cat_id': cat_id,
        'form_type': form_type
      };

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
      print("product list data..........$productList.............");
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
      dropdwnString = catName.toString();
      print("catName-----$dropdwnVal");
      notifyListeners();
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

  //////////////////////////////////////////////////////////////////////////
  Future addDeletebagItem(
      String itemId,
      String srate1,
      String qty,
      String event,
      String cart_id,
      BuildContext context,
      String action,
      String form_type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'item_id': itemId,
            'qty': qty,
            'event': event,
            'cart_id': cart_id,
            'form_type': form_type
          };
          print("body-----$body");
          if (action != "delete") {
            isLoading = true;
            notifyListeners();
          }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("save_cart---------------$map");
          if (action != "delete") {
            isLoading = false;
            notifyListeners();
          }
          print("delete response-----------------${map}");
          cartCount = map["cart_count"];
          var res = map["msg"];
          if (res == "Bag deleted Successfully") {
            getbagData1(context, form_type);
          }
          return res;
          /////////////// insert into local db /////////////////////
        } catch (e) {
          print(e);
          // return null;
          return [];
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////
  getbagData1(BuildContext context, String form_type) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn-----------$form_type----$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/cart_list.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'form_type': form_type,
          };
          print("cart body-----$body");

          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("cart response-----------------${map}");

          ProductListModel productListModel;
          bagList.clear();
          if (map != null) {
            for (var item in map) {
              productListModel = ProductListModel.fromJson(item);
              bagList.add(item);
            }
          }
          // qty =
          //     List.generate(bagList.length, (index) => TextEditingController());
          print("bag list data........${bagList}");
          for (int i = 0; i < bagList.length; i++) {
            print("qty------${productList[i]["qty"]}");
            qty[i].text = bagList[i]["qty"].toString();
          }
          isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

////////////////////////////////////////////////////////////////////

  setCustomerName(String cusName) {
    cusName1 = cusName;

    print("cysujkjj------$cusName1");
    notifyListeners();
  }

  ////////////////
  setQty(int qty) {
    qtyinc = qty;
    print("qty.......$qty");
    // notifyListeners();
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
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/stock_approve_list.php");
          Map body = {
            'branch_id': branch_id,
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

  //////////////////////////////////////////////////////////////////////
  getvehicleLoadingInfo(BuildContext context, String osId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/stock_approve_info.php");
          Map body = {
            'os_id': osId,
          };
          print("getvehicleLoadingInfo body-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("stockinfo----------$map");

          isLoading = false;
          notifyListeners();
          // ProductListModel productListModel;
          if (map != null) {
            vehicle_loading_masterlist.clear();
            for (var item in map["master"]) {
              print("haiiiiii----$item");
              vehicle_loading_masterlist.add(item);
            }
            vehicle_loading_detaillist.clear();
            for (var item in map["detail"]) {
              print("sd---$item");
              vehicle_loading_detaillist.add(item);
            }
          }

          print("stock_approve_detaillist--$vehicle_loading_detaillist---");
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

  ///////////////////////////////////////////////////////////////////
  saveVehicleLoadingList(BuildContext context, String osId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/save_stock_approve.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'os_id': osId
          };
          print("dmbody-----$body");
          // isDownloaded = true;
          isLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("stock approval save----------------$map");

          isLoading = false;
          notifyListeners();

          if (map["err_status"] == 0) {
            return showDialog(
                context: context,
                builder: (context) {
                  Size size = MediaQuery.of(context).size;

                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pop(true);
                    getvehicleLoadingList(context);
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => MainDashboard()
                          // OrderForm(widget.areaname,"return"),
                          ),
                    );
                  });
                  return AlertDialog(
                      content: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        map["msg"].toString(),
                        style: TextStyle(color: P_Settings.loginPagetheme),
                      ),
                      Icon(
                        Icons.done,
                        color: Colors.green,
                      )
                    ],
                  ));
                });
          }

          // stock_approve_list.clear();
          // if (map != null) {
          //   for (var item in map) {
          //     stock_approve_list.add(item);
          //   }
          // }

          // print("stock_approve_list---$stock_approve_list");
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
  ////////////////////////////////////////////

  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate----$todate");
    notifyListeners();
  }

  ////////////////////////////////////////////
  historyData(BuildContext context, String trans_id, String action,
      String fromDate, String tillDate) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("history---------------$branch_id----$user_id------$trans_id");
          Uri url = Uri.parse("$urlgolabl/transaction_list.php");
          Map body = {
            'staff_id': user_id,
            'branch_id': branch_id,
            'trans_id': trans_id,
            'from_date': fromDate,
            'till_date': tillDate
          };
          print("history body-----$body");
          if (action != "delete") {
            isLoading = true;
            notifyListeners();
          }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("history response-----------------${map}");

          if (action != "delete") {
            isLoading = false;
            notifyListeners();
          }

          historyList.clear();
          if (map != null) {
            for (var item in map) {
              historyList.add(item);
            }
          }

          print("history list data........${historyList}");
          // isLoading = false;
          notifyListeners();

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

  //////////////////////////////////////////////////////////////////////
  saveCartDetails(BuildContext context, String transid, String to_branch_id,
      String remark, String event, String os_id, String action,String form_type) async {
    List<Map<String, dynamic>> jsonResult = [];
    Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");

    print(
        "datas------$transid---$to_branch_id----$remark------$branch_id----$user_id");
    print("action........$action");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList-----$bagList");
        Uri url = Uri.parse("$urlgolabl/save_transaction.php");

        jsonResult.clear();
        itemmap.clear();

        bagList.map((e) {
          itemmap["item_id"] = e["item_id"];
          itemmap["qty"] = e["qty"];
          itemmap["s_rate"] = e["s_rate_1"];
          print("itemmap----$itemmap");
          jsonResult.add(e);
        }).toList();

        // for (var i = 0; i < bagList.length; i++) {
        //   print("bagList[i]-------------${bagList[i]}");
        //   itemmap["item_id"] = bagList[i]["item_id"];
        //   itemmap["qty"] = bagList[i]["qty"];
        //   itemmap["s_rate_1"] = bagList[i]["s_rate_1"];
        //   itemmap["s_rate_2"] = bagList[i]["s_rate_2"];
        //   print("itemmap----$itemmap");
        //   jsonResult.add(itemmap);
        // }

        print("jsonResult----$jsonResult");

        Map masterMap = {
          "to_branch_id": to_branch_id,
          "remark": remark,
          "staff_id": user_id,
          "branch_id": branch_id,
          "event": event,
          "os_id": os_id,
          "form_type":form_type,
          "details": jsonResult
        };

        // var jsonBody = jsonEncode(masterMap);
        print("resultmap----$masterMap");
        // var body = {'json_data': masterMap};
        // print("body-----$body");

        var jsonEnc = jsonEncode(masterMap);

        print("jsonEnc-----$jsonEnc");
        isLoading = true;
        notifyListeners();
        http.Response response = await http.post(
          url,
          body: {'json_data': jsonEnc},
        );

        var map = jsonDecode(response.body);
        isLoading = false;
        notifyListeners();
        print("json cart------$map");

        if (action == "delete" && map["err_status"] == 0) {
          // print("hist-----------$historyList");
          historyData(context, transid, "delete", "", "");
        }

        if (action == "save") {
          print("savedd");
          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(ct).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => SaleHome(formType: form_type,type: "",)
                        // OrderForm(widget.areaname,"return"),
                        ),
                  );
                });
                return AlertDialog(
                    content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '${map['msg']}',
                        style: TextStyle(color: P_Settings.loginPagetheme),
                      ),
                    ),
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  ],
                ));
              });
        } else if (action == "delete") {
          print("heloooooo");

          return showDialog(
              context: context,
              builder: (BuildContext mycontext) {
                Size size = MediaQuery.of(mycontext).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(mycontext).pop();

                  Navigator.pop(context);
                  // Navigator.of(mycontext).pop(false);
                  // Navigator.of(dialogContex).pop(true);

                  // Navigator.of(context).push(
                  //   PageRouteBuilder(
                  //       opaque: false, // set to false
                  //       pageBuilder: (_, __, ___) => MainDashboard()
                  //       // OrderForm(widget.areaname,"return"),
                  //       ),
                  // );
                });
                return AlertDialog(
                    content: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '${map['msg']}',
                        style: TextStyle(color: P_Settings.loginPagetheme),
                      ),
                    ),
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  ],
                ));
              });
        } else {}
      }
    });
  }
}
