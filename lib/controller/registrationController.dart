import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gulferp/components/customSnackbar.dart';
import 'package:gulferp/components/externalDir.dart';
import 'package:gulferp/components/globalData.dart';
import 'package:gulferp/components/network_connectivity.dart';
import 'package:gulferp/model/loginModel.dart';
import 'package:gulferp/model/registrationModel.dart';
import 'package:gulferp/model/staffDetails.dart';
import 'package:gulferp/screen/loginPage.dart';
import 'package:gulferp/services/dbHelper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/globalData.dart';

class RegistrationController extends ChangeNotifier {
  bool isLoading = false;
  StaffDetails staffModel = StaffDetails();
  String urlgolabl = Globaldata.apiglobal;

  ExternalDir externalDir = ExternalDir();
  String? fp;
  String? cid;
  String? cname;
  String? sof;
  int? qtyinc;
  List<CD> c_d = [];
  String? firstMenu;
///////////////////////////////////////////////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code,
      String? fingerprints,
      String phoneno,
      String deviceinfo,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      print("Text fp...$fingerprints---$company_code---$phoneno---$deviceinfo");
      print("company_code.........$company_code");
      // String dsd="helloo";
      String appType = company_code.substring(10, 12);
      print("apptytpe----$appType");
      if (value == true) {
        try {
          Uri url =
              Uri.parse("http://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
            'fcode': fingerprints,
            'deviceinfo': deviceinfo,
            'phoneno': phoneno
          };
          print("body----${body}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map register ${map}");
          print("response ${response}");
          RegistrationData regModel = RegistrationData.fromJson(map);

          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;
          print("fp----- $fp");
          print("sof----${sof}");

          if (sof == "1") {
            print("apptype----$appType");
            if (appType == 'SM') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              /////////////// insert into local db /////////////////////
              late CD dataDetails;
              String? fp1 = regModel.fp;
              print("fingerprint......$fp1");
              prefs.setString("fp", fp!);
              String? os = regModel.os;
              regModel.c_d![0].cid;
              cid = regModel.cid;
              prefs.setString("cid", cid!);

              cname = regModel.c_d![0].cnme;
              notifyListeners();

              await externalDir.fileWrite(fp1!);

              for (var item in regModel.c_d!) {
                print("ciddddddddd......$item");
                c_d.add(item);
              }
              // verifyRegistration(context, "");

              isLoading = false;
              notifyListeners();

              prefs.setString("os", os!);

              // prefs.setString("cname", cname!);

              String? user = prefs.getString("userType");

              print("fnjdxf----$user");

              await GulfErpDB.instance
                  .deleteFromTableCommonQuery("companyRegistrationTable", "");
              var res =
                  await GulfErpDB.instance.insertRegistrationDetails(regModel);
              // getMaxSerialNumber(os);
              // getMenuAPi(cid!, fp1, company_code, context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              CustomSnackbar snackbar = CustomSnackbar();
              snackbar.showSnackbar(context, "Invalid Apk Key", "");
            }
          }
          /////////////////////////////////////////////////////
          if (sof == "0") {
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(context, msg.toString(), "");
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////////////////////////////////////////////////
  Future<StaffDetails?> getLogin(
      String userName, String password, BuildContext context) async {
    var restaff;
    try {
      Uri url = Uri.parse("$urlgolabl/login.php");
      Map body = {'user': userName, 'pass': password};

      isLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = jsonDecode(response.body);
      print("login map ${map}");
      LoginModel loginModel;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (map != null) {
        prefs.setString("st_uname", userName);
        prefs.setString("st_pwd", password);

        for (var item in map) {
          loginModel = LoginModel.fromJson(item);
          prefs.setString("user_id", loginModel.userId!);
          prefs.setString("branch_id", loginModel.branchId!);
          prefs.setString("staff_name", loginModel.staffName!);
          prefs.setString("branch_name", loginModel.branchName!);
          prefs.setString("branch_prefix", loginModel.branchPrefix!);
        }

        isLoading = false;
        notifyListeners();

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => MainDashboard()),
        // );
      } else {
        CustomSnackbar snackbar = CustomSnackbar();
        snackbar.showSnackbar(context, "Incorrect Username or Password", "");
      }

      // print("stafff-------${loginModel.staffName}");
      notifyListeners();
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////////////////////////////////////////////////////
//   Future<StaffDetails?> getStaffDetails(String cid, int index) async {
//     print("getStaffDetails...............${cid}");
//     var restaff;
//     try {
//       Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_staff.php");
//       Map body = {
//         'cid': cid,
//       };
//       // isDownloaded = true;
//       // isCompleted = true;
//       isLoading = true;
//       notifyListeners();
//       http.Response response = await http.post(
//         url,
//         body: body,
//       );
//       List map = jsonDecode(response.body);
//       await MystockDB.instance
//           .deleteFromTableCommonQuery("staffDetailsTable", "");
//       print("map ${map}");
//       for (var staff in map) {
//         staffModel = StaffDetails.fromJson(staff);
//         restaff = await MystockDB.instance.insertStaffDetails(staffModel);
//       }
//       print("inserted staff ${restaff}");
//       // isDownloaded = false;
//       // isDown[index] = true;
//       isLoading = false;
//       notifyListeners();
//       return staffModel;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

// //////////////////////////////////////////////////////////////////////////////
//   getMenuAPi(String company_code, String fp, String apk_key,
//       BuildContext context) async {
//     var res;
//     NetConnection.networkConnection(context).then((value) async {
//       if (value == true) {
//         print("company_code---fp-${company_code}---${fp}..${apk_key}");

//         try {
//           Uri url = Uri.parse("http://trafiqerp.in/order/fj/get_menu.php");
//           Map body = {
//             'apk_key': apk_key,
//             'company_code': company_code,
//             'fingerprint': fp,
//           };
//           print("body.........$body");
//           http.Response response = await http.post(
//             url,
//             body: body,
//           );

//           print("bodymenuuuuuu ${body}");
//           var map = jsonDecode(response.body);
//           print("map menu ${map}");
//           SideMenu sidemenuModel = SideMenu.fromJson(map);
//           firstMenu = sidemenuModel.first;
//           print("menuitem----${sidemenuModel.menu![0].menu_name}");
//           print("firstMenu----$firstMenu");
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           prefs.setString("firstMenu", firstMenu!);
//           for (var menuItem in sidemenuModel.menu!) {
//             print("menuitem----${menuItem.menu_name}");
//             // res = await MystockDB.instance
//             //     .insertMenuTable(menuItem.menu_index!, menuItem.menu_name!);
//             // menuList.add(menuItem);
//           }
//           print("insertion----$res");
//           notifyListeners();
//         } catch (e) {
//           print(e);
//           return null;
//         }
//       }
//     });
//   }
}
