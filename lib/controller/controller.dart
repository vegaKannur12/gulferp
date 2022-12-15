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
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController customerControllerSale = TextEditingController();
  TextEditingController customerControllerColl = TextEditingController();
  bool brLoading = false;
  String? paymentMode;
  bool fromDb = true;
  double? payable;
  double? balance;
  bool? isReportLoading;
  bool isvehLoading = false;
  String? selectedpaymntMode;
  double collExpBal = 0.0;
  bool partPaymentClicked = false;
  String? rate_type;
  List<bool> addtoCart = [];
  List<TextEditingController> qtycontroller = [];
  List<TextEditingController> t2qtycontroller = [];
  bool isVisible = false;
  // bool? qtyPrd;
  bool disPerClicked = false;
  bool disamtClicked = false;
  String? qttyProd;
  bool isSearchLoading = false;

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
  String? selecttext;
  bool isSearch = false;
  String? outstanding;
  var invoice;
  bool invoiceLoad = false;
  bool isListLoading = false;
  List<bool> errorClicked = [];
  List<bool> applyClicked = [];

  List<String> uniquelist = [];
  List<String> uniquecustomerlist = [];
  // bool applyClicked
  List<String> filtereduniquelist = [];
  List<TextEditingController> discount_prercent = [];
  List<TextEditingController> discount_amount = [];
  List<TextEditingController> rateList = [];

  List<Map<String, dynamic>> filteredproductList = [];
  List<Map<String, dynamic>> reportsList = [];
  List<Map<String, dynamic>> vehicleSettlemntList = [];

  List<Map<String, dynamic>> loadingList = [];
  List<Map<String, dynamic>> unloadingList = [];
  List<Map<String, dynamic>> searchList = [];
  List<RouteModel> routeList = [];
  List<Map<String, dynamic>> stockList = [];
  List<Map<String, dynamic>> stock_approve_list = [];
  List<Map<String, dynamic>> stock_approve_masterlist = [];
  List<Map<String, dynamic>> stock_approve_detaillist = [];

  List<String> productbar = [];
  List<String> customerbar = [];
  String? fromDate;
  String? todate;
  List<String> filteredproductbar = [];
  String? cus_id;
  bool isProdLoading = false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> vehicle_loading_masterlist = [];
  List<Map<String, dynamic>> vehicle_loading_detaillist = [];
  List<Map<String, dynamic>> vehicle_unloading_masterlist = [];
  List<Map<String, dynamic>> vehicle_unloading_detaillist = [];
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> historyList = [];
  List<Map<String, dynamic>> unloadhistoryList = [];
  List<Map<String, dynamic>> expenseCollList = [];

  List<Map<String, dynamic>> infoList = [];
  List<Map<String, dynamic>> vehicle_list = [];

  List<TextEditingController> qty = [];
  List<TextEditingController> qty1 = [];

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
  double? collectionVal;
  double? expnVal;

  int item_count = 0;
  double? net_tot;
  double? gro_tot;
  double? disc_tot;
  double? tax_total;
  double? cess_total;
  double? cgst_total;
  double? sgst_total;
  double? igst_total;
  double? taxable_total;
  double? total_qty;

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

  ////////////////////////////////////////////////////////////
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
      applyClicked = List.generate(productList.length, (index) => false);

      discount_prercent =
          List.generate(productList.length, (index) => TextEditingController());
      discount_amount =
          List.generate(productList.length, (index) => TextEditingController());
      print("qty------$qty");

      for (int i = 0; i < productList.length; i++) {
        applyClicked[i] = false;
        // qty1[i].text = "0";
        print("product list dataa loop....");
        discount_prercent[i].text = productList[i]["disc_per"].toString();
        discount_amount[i].text = productList[i]["disc_amt"].toString();
        print("qty------${productList[i]["qty"]}");
        if (productList[i]["qty"] == "0") {
          // qttyProd="1";
          applyClicked[i] = false;
          // qty1[i].text = "0";
          qty[i].text = "0";
        } else {
          applyClicked[i] = true;

          qty[i].text = productList[i]["qty"].toString();
        }
      }

      // notifyListeners();
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
      print("print error.....$e");
      // return null;
      return [];
    }
  }
  /////////////////////////get invoice number/////////////////////////////

  getInvoice(String form_type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    try {
      Uri url = Uri.parse("$urlgolabl/get_invoice_no.php");
      Map body = {'branch_id': branch_id, 'form_type': form_type};
      invoiceLoad = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = jsonDecode(response.body);
      print("invoice number.......${map}");
      invoice = map['invoice_no'];
      invoiceLoad = false;
      notifyListeners();
    } catch (e) {
      print(e);
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
      String cart_id,
      String itemId,
      String actualRate,
      String srate1,
      String qty,
      BuildContext context,
      String action,
      String form_type,
      double gross,
      double disc_per,
      double disc_amt,
      double taxable,
      double cgst_amt,
      double sgst_amt,
      double igst_amt,
      double cgst_per,
      double sgst_per,
      double igst_per,
      double cess_per,
      double cess_amt,
      double net_tot,
      double tax_per,
      String event,
      String page) async {
    print("Quantity.......$action.....$qty");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("kjn---------------$branch_id----$user_id-");
          Uri url = Uri.parse("$urlgolabl/save_cart.php");
          Map body = {
            'cart_id': cart_id,
            'staff_id': user_id,
            'branch_id': branch_id,
            'item_id': itemId,
            'event': event,
            'qty': qty,
            'actual_rate': actualRate,
            'rate': srate1,
            'gross': gross.toString(),
            'disc_per': disc_per.toString(),
            'disc_amt': disc_amt.toString(),
            'taxable': taxable.toString(),
            'cgst_per': cgst_per.toString(),
            'cgst_amt': cgst_amt.toString(),
            'sgst_per': sgst_per.toString(),
            'sgst_amt': sgst_amt.toString(),
            'igst_per': igst_per.toString(),
            'igst_amt': igst_amt.toString(),
            'cess_per': cess_per.toString(),
            'cess_amt': cess_amt.toString(),
            'net_total': net_tot.toString(),
            'form_type': form_type,
            'tax': tax_per.toString()
          };
          print("addvdeltebody-----$body---$action");
          if (action != "delete") {
            if (action != "save" && page != "cart") {
              isLoading = true;
              notifyListeners();
            }
          }
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          var res = map["msg"];
          var err_status = map["err_status"];
          print("save_cart---------------$map");
          if (action != "delete") {
            if (action != "save" && page != "cart") {
              isLoading = false;
              notifyListeners();
            }
          }
          // print("add delete response-----------------${map}");
          cartCount = map["cart_count"];

          if (err_status == 0 && res == "Bag deleted Successfully") {
            getbagData1(context, form_type, "delete");
          }
          print("pagee-----$page---$res---$err_status");

          if (err_status == 0 &&
              res == "Bag Edit Successfully" &&
              page == "cart") {
            // print("pagee-----$page");
            getbagData1(context, form_type, "edit");
          }
          // if (err_status == 0 && res == "Bag Remove Successfully") {
          //   getbagData1(context, form_type, "edit");
          // }
          notifyListeners();
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
  Future getbagData1(
      BuildContext context, String form_type, String type) async {
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
          if (type != "delete") {
            if (type == "edit") {
              isLoading = true;
              notifyListeners();
            } else {
              isLoading = true;
              notifyListeners();
            }
          }

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
              // print("map....");
              productListModel = ProductListModel.fromJson(item);
              bagList.add(item);
            }
          }
          if (form_type == "1" || form_type == "2") {
            rateList = List.generate(
                bagList.length, (index) => TextEditingController());
            discount_prercent = List.generate(
                bagList.length, (index) => TextEditingController());
            discount_amount = List.generate(
                bagList.length, (index) => TextEditingController());
          } else if (form_type == "3") {
            qty = List.generate(
                bagList.length, (index) => TextEditingController());
          }

          for (int i = 0; i < bagList.length; i++) {
            // print("qty------${productList[i]["qty"]}");
            qty[i].text = bagList[i]["qty"].toString();
            if (form_type == "1" || form_type == "2") {
              rateList[i].text = bagList[i]["s_rate_fix"].toString();
              discount_prercent[i].text = bagList[i]["disc_per"].toString();
              discount_amount[i].text = bagList[i]["disc_amt"].toString();
            }
          }
          print("baglist------$bagList");
          item_count = bagList.length;
          net_tot = 0.00;
          gro_tot = 0.00;
          disc_tot = 0.00;
          tax_total = 0.00;
          cess_total = 0.00;
          cgst_total = 0.0;
          sgst_total = 0.0;
          igst_total = 0.0;
          taxable_total = 0.0;
          total_qty = 0.0;
          for (int i = 0; i < bagList.length; i++) {
            net_tot = net_tot! + double.parse(bagList[i]["net_total"]);
            gro_tot = gro_tot! + double.parse(bagList[i]["gross"]);
            disc_tot = disc_tot! + double.parse(bagList[i]["disc_amt"]);
            cess_total = cess_total! + double.parse(bagList[i]["cess_amt"]);
            tax_total = tax_total! +
                double.parse(bagList[i]["igst_amt"]) +
                double.parse(bagList[i]["cgst_amt"]) +
                double.parse(bagList[i]["sgst_amt"]);
            cgst_total = cgst_total! + double.parse(bagList[i]["cgst_amt"]);
            sgst_total = sgst_total! + double.parse(bagList[i]["sgst_amt"]);
            igst_total = igst_total! + double.parse(bagList[i]["igst_amt"]);
            taxable_total =
                taxable_total! + double.parse(bagList[i]["taxable"]);
            total_qty = total_qty! + double.parse(bagList[i]["qty"]);
          }
          notifyListeners();
          print(
              "net amount....$item_count..$gro_tot....$dis_tot......$cess_total...$net_tot");
          if (type != "delete") {
            if (type == "edit") {
              isLoading = false;
              notifyListeners();
            } else {
              isLoading = false;
              notifyListeners();
            }
          }

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

  setCustomerName(
      String cusName, String? gtype, String cusId, String outstanding2,String rateType) {
    cusName1 = cusName;
    gtype1 = gtype;
    cus_id = cusId;
    outstanding = outstanding2;
    rate_type=rateType;
    print("cysujkjj------$cusName1----$gtype----$cus_id----$outstanding----$rate_type");
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
          isvehLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("stock approval list-----------------$map");

          isvehLoading = false;
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

  ////////////////////////////////////////////
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

          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(context).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);
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

//////////////////////////////////////////////////////
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
        "attribute--$rate---$qtyw---$disc_per--$disc_amount--$tax_per---$cess_per---$method---$state_status--$disCalc----");
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
    print(" $gross");

    if (disCalc == "disc_amt") {
      disc_per = (disc_amount / gross) * 100;
      disc_amt = disc_amount;
      // print("discount_prercent---$disc_amount---${discount_prercent.length}");
      if (onSub) {
        discount_prercent[index].text = disc_per.toStringAsFixed(4);
      }
    }
    print("disc_amt----$disc_amt----$disc_amount---$disCalc");

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
      disc_amt = disc_amount;

      print("ces-per----$cess_per");
      // disc_amt = double.parse(discount_amount[index].text);
      // disc_per = double.parse(discount_prercent[index].text);
      print("disc-amt qty----$disc_amt...$disc_per----$disCalc");
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

    print("cgst-per , sgst-per------------$cgst_per---$sgst_per--$igst_per");

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
        "disc_per calcu mod=0.....$gross...$disc_amt.....$cess. ...$tax_per--$tax..---$net_amt");
    notifyListeners();
    return "success";
  }

  ////////////////////////////////////////////
  historyData(BuildContext context, String action, String fromDate,
      String tillDate, String formType) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          // user_id = prefs.getString("user_id");
          print("history-----------$action----$branch_id----$user_id---");
          Uri urlSale = Uri.parse("$urlgolabl/sale_list.php");
          Uri urlSaleRet = Uri.parse("$urlgolabl/sale_return_list.php");

          Map body = {
            'branch_id': branch_id,
            'from_date': fromDate,
            'till_date': tillDate
          };
          print("history body-----$body");
          if (action != "delete") {
            isLoading = true;
            notifyListeners();
          }
          if (formType == "1") {
            http.Response response = await http.post(
              urlSale,
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
          } else if (formType == "2") {
            http.Response response = await http.post(
              urlSaleRet,
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
          }

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

/////////////////////////unload vehicle history//////////////////
  historyunloadvehicleData(BuildContext context, String action, String fromDate,
      String tillDate) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          // user_id = prefs.getString("user_id");
          print(
              "history unload-----------$action----$branch_id----$user_id---");
          Uri url = Uri.parse("$urlgolabl/stock_transfer_list.php");
          Map body = {
            'branch_id': branch_id,
            'from_date': fromDate,
            'till_date': tillDate
          };
          print("history unload body-----$body");
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

          unloadhistoryList.clear();
          if (map != null) {
            for (var item in map) {
              unloadhistoryList.add(item);
            }
          }

          print("history list data........${unloadhistoryList}");
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
      String remark,
      String event,
      String os_id,
      String action,
      String form_type,
      String customer_id,
      String cusName,
      String disc_percentage,
      String total_discount,
      String total_cess,
      String net_total,
      String rounding,
      String cgst_total,
      String sgst_total,
      String igst_total,
      String taxable_total,
      String total_qty,
      String paymentMode,
      String payable,
      String balance) async {
    List<Map<String, dynamic>> jsonResult = [];
    // List<Map<String, dynamic>> itemmap = [];

    // Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");

    print("datas--------$paymentMode------$payable----$balance");
    print("action........$action");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList-----$bagList");
        Uri url = Uri.parse("$urlgolabl/save_sale.php");

        jsonResult.clear();
        // itemmap.clear();

        jsonResult.clear();
        print("bagList-save------$bagList-----");

        for (var i = 0; i < bagList.length; i++) {
          var itemmap = {
            "item_id": bagList[i]["item_id"],
            "actual_rate": bagList[i]["actual_rate"],
            "rate": bagList[i]["s_rate_fix"],
            "qty": bagList[i]["qty"],
            "tax": bagList[i]["tax"],
            "gross": bagList[i]["gross"],
            "disc_per": bagList[i]["disc_per"],
            "disc_amt": bagList[i]["disc_amt"],
            "taxable": bagList[i]["taxable"],
            "cgst_per": bagList[i]["cgst_per"],
            "cgst_amt": bagList[i]["cgst_amt"],
            "sgst_per": bagList[i]["sgst_per"],
            "sgst_amt": bagList[i]["sgst_amt"],
            "igst_per": bagList[i]["igst_per"],
            "igst_amt": bagList[i]["igst_amt"],
            "cess_per": bagList[i]["cess_per"],
            "cess_amt": bagList[i]["cess_amt"],
            "net_total": bagList[i]["net_total"]
          };
          jsonResult.add(itemmap);
          print("jsonResult----$jsonResult");
        }
        print("jsonResult----$jsonResult");

        Map masterMap = {
          "s_customer_id": customer_id,
          "s_customer_name": cusName,
          "s_reference": remark,
          "tot_qty": total_qty,
          "disc_percentage": disc_percentage,
          "s_total_discount": total_discount,
          "s_total_taxable": taxable_total,
          "s_total_cgst": cgst_total,
          "s_total_sgst": sgst_total,
          "s_total_igst": igst_total,
          "s_total_cess": total_cess,
          "net_total": net_total,
          "payment_mode": paymentMode,
          "payable": payable,
          "balance": balance,
          "rounding": rounding,
          "s_grand_total": net_total,
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
        print("json cart--save----$map");

        // if (action == "delete" && map["err_status"] == 0) {
        //   // print("hist-----------$historyList");
        //   historyData(context, "delete", "", "");
        // }

        if (action == "save") {
          print("savedd");
          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(ct).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);
                  Navigator.of(context).pop(true);

                  if (map["err_status"] == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaleHome(
                          formType: form_type,
                          type: "",
                        ),
                      ),
                    );
                  }

                  // Navigator.pop(context);
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

  /////////////////////unload vehicle save/////////////////////////////
  saveUnloadVehicleDetails(BuildContext context, String event, String action,
      String form_type, String os_id, String remarks, String brId) async {
    List<Map<String, dynamic>> jsonResult = [];
    // List<Map<String, dynamic>> itemmap = [];

    // Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");

    print("datas----------$branch_id----$user_id");
    print("action........$action");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList sale return-----$bagList");
        Uri url = Uri.parse("$urlgolabl/save_stock_transfer.php");

        jsonResult.clear();

        jsonResult.clear();

        for (var i = 0; i < bagList.length; i++) {
          var itemmap = {
            "item_id": bagList[i]["item_id"],
            "qty": bagList[i]["qty"],
            "s_rate_fix": bagList[i]["s_rate_fix"],
          };
          jsonResult.add(itemmap);
          print("jsonResult----$jsonResult");
        }
        print("jsonResult unload ----$jsonResult");

        Map masterMap = {
          "tot_qty": total_qty,
          "staff_id": user_id,
          "branch_id": branch_id,
          "to_branch_id": brId,
          "event": event,
          "remarks": remarks,
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
        print("json cart--save----$map");

        // if (action == "delete" && map["err_status"] == 0) {
        //   // print("hist-----------$historyList");
        //   historyData(context, "delete", "", "");
        // }

        if (action == "save") {
          print("savedd");
          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(ct).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainDashboard(),
                    ),
                  );

                  // Navigator.pop(context);
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

  //////////////////////////////////////////////////////////////////////
  saveSaleReturnCartDetails(
      BuildContext context,
      String remark,
      String event,
      String os_id,
      String action,
      String form_type,
      String customer_id,
      String cusName,
      String disc_percentage,
      String total_discount,
      String total_cess,
      String net_total,
      String rounding,
      String cgst_total,
      String sgst_total,
      String igst_total,
      String taxable_total,
      String total_qty) async {
    List<Map<String, dynamic>> jsonResult = [];
    // List<Map<String, dynamic>> itemmap = [];

    // Map<String, dynamic> itemmap = {};
    Map<String, dynamic> resultmmap = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch_id = prefs.getString("branch_id");
    user_id = prefs.getString("user_id");

    print("datas--------$remark------$branch_id----$user_id");
    print("action........$action");
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("bagList sale return-----$bagList");
        Uri url = Uri.parse("$urlgolabl/save_sale_return.php");

        jsonResult.clear();
        // itemmap.clear();

        // bagList.map((e) {
        //   itemmap["item_id"] = e["item_id"];
        //   itemmap["qty"] = e["qty"];
        //   itemmap["rate"] = e["rate"];
        //   itemmap["tax"] = e["tax"];
        //   itemmap["gross"] = e["gross"];
        //   itemmap["disc_per"] = e["disc_per"];
        //   itemmap["disc_amt"] = e["disc_amt"];
        //   itemmap["taxable"] = e["taxable"];
        //   itemmap["cgst_per"] = e["cgst_per"];
        //   itemmap["cgst_amt"] = e["cgst_amt"];
        //   itemmap["sgst_per"] = e["sgst_per"];
        //   itemmap["sgst_amt"] = e["sgst_amt"];
        //   itemmap["igst_per"] = e["igst_per"];
        //   itemmap["igst_amt"] = e["igst_amt"];
        //   itemmap["cess_per"] = e["cess_per"];
        //   itemmap["cess_amt"] = e["cess_amt"];
        //   itemmap["net_total"] = e["net_total"];
        //   print("itemmap----$itemmap");
        //   jsonResult.add(e);
        // }).toList();
        jsonResult.clear();
        for (var i = 0; i < bagList.length; i++) {
          var itemmap = {
            "item_id": bagList[i]["item_id"],
            "rate": bagList[i]["s_rate_fix"],
            "qty": bagList[i]["qty"],
            "tax": bagList[i]["tax"],
            "gross": bagList[i]["gross"],
            "disc_per": bagList[i]["disc_per"],
            "disc_amt": bagList[i]["disc_amt"],
            "taxable": bagList[i]["taxable"],
            "cgst_per": bagList[i]["cgst_per"],
            "cgst_amt": bagList[i]["cgst_amt"],
            "sgst_per": bagList[i]["sgst_per"],
            "sgst_amt": bagList[i]["sgst_amt"],
            "igst_per": bagList[i]["igst_per"],
            "igst_amt": bagList[i]["igst_amt"],
            "cess_per": bagList[i]["cess_per"],
            "cess_amt": bagList[i]["cess_amt"],
            "net_total": bagList[i]["net_total"]
          };
          jsonResult.add(itemmap);
          print("jsonResult----$jsonResult");
        }
        print("jsonResult return ----$jsonResult");

        Map masterMap = {
          "s_customer_id": customer_id,
          "s_customer_name": cusName,
          "s_reference": remark,
          "tot_qty": total_qty,
          "disc_percentage": disc_percentage,
          "s_total_discount": total_discount,
          "s_total_taxable": taxable_total,
          "s_total_cgst": cgst_total,
          "s_total_sgst": sgst_total,
          "s_total_igst": igst_total,
          "s_total_cess": total_cess,
          "net_total": net_total,
          "rounding": rounding,
          "s_grand_total": net_total,
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
        print("json cart--save----$map");

        // if (action == "delete" && map["err_status"] == 0) {
        //   // print("hist-----------$historyList");
        //   historyData(context, "delete", "", "");
        // }
        print("haiiiiiiiiiiiiiiiiiiiiiiiiiiii");
        if (action == "save") {
          print("savedd");
          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(ct).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaleHome(
                        formType: form_type,
                        type: "",
                      ),
                    ),
                  );

                  // Navigator.pop(context);
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

  setIssearch(bool isSrach) {
    isSearch = isSrach;
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////
  searchItem(BuildContext context, String itemName,String rateType)async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("value-----$itemName---$rateType");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          print("branch_id--search-$branch_id");

          Uri url = Uri.parse("$urlgolabl/search_products_list.php");
          Map body = {'item_name': itemName, 'branch_id': branch_id,'rate_type':rateType};
          print("body-----$body");
          // isDownloaded = true;
          // isLoading = true;
          isSearchLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);

          searchList.clear();
          for (var item in map) {
            searchList.add(item);
          }
          print("searchList------$searchList");
          qtycontroller = List.generate(
            searchList.length,
            (index) => TextEditingController(),
          );
          rateList = List.generate(
              searchList.length, (index) => TextEditingController());
          discount_prercent = List.generate(
              searchList.length, (index) => TextEditingController());
          discount_amount = List.generate(
              searchList.length, (index) => TextEditingController());
          addtoCart = List.generate(searchList.length, (index) => false);

          for (int i = 0; i < searchList.length; i++) {
            discount_prercent[i].text = "0";
            discount_amount[i].text = "0";
            rateList[i].text = searchList[i]["s_rate_fix"];
          }
          isSearchLoading = false;
          // isLoading = false;
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

///////////////////////////////////////////////////////////////////////////////
  unLoadsearchItem(BuildContext context, String itemName) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("value-----$itemName");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          print("branch_id--search-$branch_id");

          Uri url = Uri.parse("$urlgolabl/search_products_list_1.php");
          Map body = {'item_name': itemName, 'branch_id': branch_id};
          print("body-----$body");
          // isDownloaded = true;
          // isLoading = true;
          isSearchLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);

          searchList.clear();
          for (var item in map) {
            searchList.add(item);
          }
          print("unload  searchList------$searchList");
          qtycontroller = List.generate(
            searchList.length,
            (index) => TextEditingController(),
          );
          rateList = List.generate(
              searchList.length, (index) => TextEditingController());
          discount_prercent = List.generate(
              searchList.length, (index) => TextEditingController());
          discount_amount = List.generate(
              searchList.length, (index) => TextEditingController());
          addtoCart = List.generate(searchList.length, (index) => false);

          for (int i = 0; i < searchList.length; i++) {
            discount_prercent[i].text = "0";
            discount_amount[i].text = "0";
            rateList[i].text = searchList[i]["s_rate_fix"];
          }
          isSearchLoading = false;
          // isLoading = false;
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

  //////////////////// get info list ///////////////////
  getinfoList(BuildContext context, String itemId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/item_search_stock.php");
          Map body = {
            'item_id': itemId,
            'branch_id': branch_id,
          };
          print("cart search info-----$body");
          // isDownloaded = true;
          isListLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          print("item_search_stock bag response-----------------$map");

          isListLoading = false;
          notifyListeners();
          // ProductListModel productListModel;
          if (map != null) {
            infoList.clear();
            for (var item in map["item_info"]) {
              infoList.add(item);
            }
            stockList.clear();
            for (var item in map["Stock_info"]) {
              stockList.add(item);
            }
          }

          print("infoList---$infoList----$stockList");
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

  //////////////////////////////////////////////////////////////////
  getStockApprovalList(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");

          Uri url = Uri.parse("$urlgolabl/save_stock_transfer.php");
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
          stock_approve_list.clear();
          if (map != null) {
            for (var item in map) {
              stock_approve_list.add(item);
            }
          }

          print("stock_approve_list---$stock_approve_list");
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

  /////////////////////////////////////////////////////////
  saveStockApprovalList(BuildContext context, String osId) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");

          Uri url = Uri.parse("$urlgolabl/save_stock_transfer.php");
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

          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(context).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);
                  getStockApprovalList(context);
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

  setisVisible(bool isvis) {
    isVisible = isvis;
    notifyListeners();
  }

  addToCartClicked(bool clicked, int index) {
    addtoCart[index] = clicked;
    notifyListeners();
  }

  setPaymentMode(String mode, double payable1) {
    print("mode----$mode");
    paymentMode = mode;

    if (mode == "1") {
      partPaymentClicked = false;

      payable = payable1;
      balance = 0.0;

      print("paybklkd----$payable");
    } else if (mode == "2") {
      partPaymentClicked = false;

      payable = 0.0;
      balance = payable1;
    } else if (mode == "3") {
      partPaymentClicked = true;
      balance = payable1;
    }
    notifyListeners();
  }

  ////////////////////////////////////////////
  calculateBal(double val, double net) {
    balance = net - val;
    notifyListeners();
  }

  setInitialValFrPaymentSheet() {
    selectedpaymntMode = null;
    partPaymentClicked = false;
    paymentMode = null;
    balance = null;
    payable = null;
    notifyListeners();
  }

  ///////////////////////////////////////////
  saveexpenseandCollection(BuildContext context, String? cusId, String event,
      String? amt, String? narration, String? os_id, String formType) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          user_id = prefs.getString("user_id");
          print("szfcdzfdxf----------$cusId----$amt----$narration---$formType");
          Uri url = Uri.parse("$urlgolabl/save_expense_collection.php");
          Map body = {
            "s_customer_id": cusId,
            "event": event,
            "amt": amt,
            "narration": narration,
            "staff_id": user_id,
            "branch_id": branch_id,
            "os_id": os_id,
            "form_type": formType,
          };
          // var jsonBody = jsonEncode(body);

          print("save_expense_collection body-----$body");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("save_expense_collection response-----------------${map}");

          isLoading = false;
          notifyListeners();

          return showDialog(
              context: context,
              builder: (ct) {
                Size size = MediaQuery.of(context).size;

                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(ct).pop(true);

                  // getStockApprovalList(context);
                  if (map["err_status"] == 0) {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => MainDashboard()
                          // OrderForm(widget.areaname,"return"),
                          ),
                    );
                  }
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

          /////////////// insert into local db /////////////////////
        } catch (e) {
          print("error...$e");
          // return null;
          return [];
        }
      }
    });
  }

  ////////////////////////////////////////////////////////////////////////////////
  historyExpenseAndCollectionData(BuildContext context, String action,
      String fromDate, String tillDate, String formType) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          // user_id = prefs.getString("user_id");
          print(
              "history unload-----------$fromDate----$branch_id----$formType---");
          Uri url = Uri.parse("$urlgolabl/expense_collection_list.php");
          Map body = {
            'branch_id': branch_id,
            'from_date': fromDate,
            'till_date': tillDate,
            'form_type': formType
          };
          print("expense_collection_list body-----$body");
          if (action != "delete") {
            isLoading = true;
            notifyListeners();
          }

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("expense_collection_list response-----------------${map}");

          if (action != "delete") {
            isLoading = false;
            notifyListeners();
          }

          expenseCollList.clear();
          if (map != null) {
            for (var item in map) {
              expenseCollList.add(item);
            }
          }

          print("expenseCollList data........${expenseCollList}");
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

  ///////////////report/////////////////////////////////////////////
  itemwisereports(
      BuildContext context, String fromDate, String tillDate) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          // user_id = prefs.getString("user_id");
          print("history unload---------$branch_id----$user_id---");
          Uri url = Uri.parse("$urlgolabl/itemwise_sale_report.php");
          Map body = {
            'vehicle_id': branch_id,
            'from_date': fromDate,
            'till_date': tillDate
          };
          print("itemwise body-----$body");

          isReportLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("itemwise report--------------${map}");

          // if (action != "delete") {
          //   isLoading = false;
          //   notifyListeners();
          // }

          reportsList.clear();
          if (map != null) {
            for (var item in map) {
              reportsList.add(item);
            }
          }

          print("reportsList list data........${reportsList}");
          isReportLoading = false;
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

////////////////////////////////////////////////////////////////////////////////////
  stockreports(
    BuildContext context,
  ) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          // user_id = prefs.getString("user_id");
          print("history unload---------$branch_id----$user_id---");
          Uri url = Uri.parse("$urlgolabl/stock_report.php");
          Map body = {
            'vehicle_id': branch_id,
          };
          print("stock unload body-----$body");

          isReportLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("stock report-------------${map}");

          // if (action != "delete") {
          //   isLoading = false;
          //   notifyListeners();
          // }

          reportsList.clear();
          if (map != null) {
            for (var item in map) {
              reportsList.add(item);
            }
          }

          print("reportsList list data........${reportsList}");
          isReportLoading = false;
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

  ///////////////////////////////////////////////
  vehicleSettlement(
    BuildContext context,
  ) async {
    double coll = 0.0;
    double exp = 0.0;

    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          // user_id = prefs.getString("user_id");
          print("history unload---------$branch_id----$user_id---");
          Uri url = Uri.parse("$urlgolabl/vehicle_settlement_list.php");
          Map body = {
            'vehicle_id': branch_id,
            // 'from_date': fromDate,
            // 'till_date': tillDate
          };
          print("vehicle settlemnt body-----$body");

          isReportLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("vehicle settlemnt-----------------${map}");

          // if (action != "delete") {
          //   isLoading = false;
          //   notifyListeners();
          // }

          vehicleSettlemntList.clear();
          if (map != null) {
            for (var item in map) {
              vehicleSettlemntList.add(item);
            }
          }

          print("vehicle settlemnt....${vehicleSettlemntList}");

          for (int i = 0; i < vehicleSettlemntList.length; i++) {
            if (vehicleSettlemntList[i]["flag"] == "2") {
              coll = coll + double.parse(vehicleSettlemntList[i]["amt"]);
            } else {
              exp = exp + double.parse(vehicleSettlemntList[i]["amt"]);
            }
          }
          collectionVal = coll;
          expnVal = exp;
          collExpBal = coll - exp;

          print("colll-----$coll----$exp $collExpBal");
          isReportLoading = false;
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

  /////////////////////////////////////////////////////////////////
  getVehicleList(
    BuildContext context,
  ) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          branch_id = prefs.getString("branch_id");
          // user_id = prefs.getString("user_id");
          print("vehicle list unload---------$branch_id----$user_id---");
          Uri url = Uri.parse("$urlgolabl/vehicle_list.php");
          Map body = {
            'branch_id': branch_id,
          };
          print("vehicle list body----$body");

          brLoading = true;
          notifyListeners();

          http.Response response = await http.post(
            url,
            body: body,
          );

          var map = jsonDecode(response.body);
          print("vehicle list------------${map}");

          // if (action != "delete") {
          //   isLoading = false;
          //   notifyListeners();
          // }

          vehicle_list.clear();
          if (map != null) {
            for (var item in map) {
              vehicle_list.add(item);
            }
          }

          print("vehicle_list list data........${vehicle_list}");
          brLoading = false;
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
}
