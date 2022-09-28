import 'package:flutter/material.dart';
import 'package:gulferp/components/globalData.dart';
import 'package:gulferp/model/itemCategoryModel.dart';

import '../components/network_connectivity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  bool isLoading = false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> historyList = [];
  List<String> productbar = [];


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
  /////////////////////////////////////////////////////////////////////////////
}
