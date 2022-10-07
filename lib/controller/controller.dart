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
  bool? fromDb;
  bool disPerClicked = false;
  bool disamtClicked = false;

  bool isLoading = false;
  bool filter = false;
  String? gtype1;
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
  List<TextEditingController> discount_prercent = [];
  List<TextEditingController> discount_amount = [];
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
  double? qtyinc;
  bool flag = false;
  double taxable_rate = 0.0;
  bool boolCustomerSet = false;
  double salesTotal = 0.0;

  String? packName;
  double tax = 0.0;
  double gross = 0.0;
  double gross_tot = 0.0;
  double roundoff = 0.0;
  double dis_tot = 0.0;
  double cess_tot = 0.0;
  double tax_tot = 0.0;
  double cgst_amt = 0.0;
  double cgst_per = 0.0;
  double sgst_amt = 0.0;
  double sgst_per = 0.0;
  double igst_amt = 0.0;
  double igst_per = 0.0;
  double disc_per = 0.0;
  double cess = 0.0;
  double disc_amt = 0.0;
  double net_amt = 0.0;

  int item_count = 0;
  double net_tot = 0.0;
  double gro_tot = 0.0;
  double disc_tot = 0.0;
  double tax_total = 0.0;
  double cess_total = 0.0;

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
      discount_prercent =
          List.generate(productList.length, (index) => TextEditingController());
      discount_amount =
          List.generate(productList.length, (index) => TextEditingController());
      print("qty------$qty");

      for (int i = 0; i < productList.length; i++) {
        print("qty------${productList[i]["qty"]}");
        qty[i].text = productList[i]["qty"].toString();
        discount_prercent[i].text = productList[i]["disc_per"].toString();
        discount_amount[i].text = productList[i]["disc_amt"].toString();
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
    print("Quantity............$qty");
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

          discount_prercent =
              List.generate(bagList.length, (index) => TextEditingController());
          discount_amount =
              List.generate(bagList.length, (index) => TextEditingController());
          for (int i = 0; i < bagList.length; i++) {
            print("qty------${productList[i]["qty"]}");
            qty[i].text = bagList[i]["net_total"].toString();
          }

          print("bag list data........${bagList}");
          item_count = bagList.length;
          bagList.forEach((item) {
            print("items in baglist.length..........${item.length}");

            net_tot += double.parse(item["net_total"]);
            gro_tot += double.parse(item["gross"]);
            dis_tot += double.parse(item["disc_amt"]);
            cess_total += double.parse(item["cess_amt"]);
            tax_total += double.parse(item["taxable"]);
            print(
                "net amount....$item_count..$gro_tot....$dis_tot......$cess_total...$net_tot");
          });

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

  setCustomerName(String cusName, String gtype) {
    cusName1 = cusName;
    gtype1 = gtype;
    print("cysujkjj------$cusName1----$gtype");
    notifyListeners();
  }

  ////////////////
  setQty(double qty) {
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

  String rawCalculation(
      double rate,
      double qtyw,
      double disc_per,
      double disc_amount,
      double tax_per,
      double cess_per,
      String method,
      int state_status,
      int index,
      bool onSub,
      String? disCalc) {
    flag = false;

    print(
        "attribute----$rate----$qtyw-$state_status---$disCalc --$disc_per--$disc_amount--$tax_per--$cess_per--$method");
    if (method == "0") {
      /////////////////////////////////method=="0" - excluisive , method=1 - inclusive
      taxable_rate = rate;
    } else if (method == "1") {
      double percnt = tax_per + cess_per;
      taxable_rate = rate * (1 - (percnt / (100 + percnt)));
      print("exclusive tax....$percnt...$taxable_rate");
    }
    print("exclusive tax......$taxable_rate");
    // qty=qty+1;
    gross = taxable_rate * qtyw;
    print("gros----$gross");

    if (disCalc == "disc_amt") {
      disc_per = (disc_amount / gross) * 100;
      disc_amt = disc_amount;
      // print("discount_prercent---$disc_amount---${discount_prercent.length}");
      if (onSub) {
        discount_prercent[index].text = disc_per.toStringAsFixed(4);
      }
      print("disc_per----$disc_per");
    }

    if (disCalc == "disc_per") {
      print("yes hay---$disc_per");
      disc_amt = (gross * disc_per) / 100;
      if (onSub) {
        discount_amount[index].text = disc_amt.toStringAsFixed(2);
      }
      print("disc-amt----$disc_amt");
    }

    if (disCalc == "qty") {
      qty[index].text = qtyw.toString();

      print("ces-per----$cess_per");
      // disc_amt = double.parse(discount_amount[index].text);
      // disc_per = double.parse(discount_prercent[index].text);
      print("disc-amt qty----$disc_amt...$disc_per");
    }

    // if (disCalc == "rate") {
    //   rateController[index].text = taxable_rate.toStringAsFixed(2);
    //   // disc_amt = double.parse(discount_amount[index].text);
    //   // disc_per = double.parse(discount_prercent[index].text);
    //   print("disc-amt qty----$disc_amt...$disc_per");
    // }

    if (state_status == 0) {
      ///////state_status=0--loacal///////////state_status=1----inter-state
      cgst_per = tax_per / 2;
      sgst_per = tax_per / 2;
      igst_per = 0;
    } else {
      cgst_per = 0;
      sgst_per = 0;
      igst_per = tax_per;
    }

    if (disCalc == "") {
      print("inside nothingg.....");
      disc_per = (disc_amount / taxable_rate) * 100;
      disc_amt = disc_amount;
      print("rsr....$disc_per....$disc_amt..");
    }

    tax = (gross - disc_amt) * (tax_per / 100);
    print("tax....$tax....$gross... $disc_amt...$tax_per");
    if (tax < 0) {
      tax = 0.00;
    }
    cgst_amt = (gross - disc_amt) * (cgst_per / 100);
    sgst_amt = (gross - disc_amt) * (sgst_per / 100);
    igst_amt = (gross - disc_amt) * (igst_per / 100);

    print(
        "gross---Discamt---cessper---${gross}----${discount_amount[index].text}----$cess_per");
    cess = (gross - disc_amt) * (cess_per / 100);
    net_amt = ((gross - disc_amt) + tax + cess);
    if (net_amt < 0) {
      net_amt = 0.00;
    }
    print("netamount.cal...$net_amt");

    print(
        "disc_per calcu mod=0..$tax..$gross..$cess. $disc_amt...$tax_per-----$net_amt");
    notifyListeners();
    return "success";
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
  saveCartDetails(
      BuildContext context,
      String transid,
      String to_branch_id,
      String remark,
      String event,
      String os_id,
      String action,
      String form_type) async {
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
          "form_type": form_type,
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
                        pageBuilder: (_, __, ___) => SaleHome(
                              formType: form_type,
                              type: "",
                            )
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
