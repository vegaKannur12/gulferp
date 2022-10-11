import 'package:flutter/material.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/screen/RegistrationScreen.dart';
import 'package:gulferp/screen/loginPage.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard/mainDashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? cid;
  String? st_uname;
  String? st_pwd;

  navigate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      cid = prefs.getString("cid");
      st_uname = prefs.getString("st_uname");
      st_pwd = prefs.getString("st_pwd");

      // print("st-----$st_uname---$st_pwd");
      // print("continueClicked $continueClicked");

      // if (com_cid != null) {
      //   Provider.of<Controller>(context, listen: false).cid = com_cid;
      // }
      // if (firstMenu != null) {
      //   Provider.of<Controller>(context, listen: false).menu_index = firstMenu;
      //   print(Provider.of<Controller>(context, listen: false).menu_index);
      // }
      // print("versof----$versof");

      Navigator.push(
          context,
          PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) {
                if (cid != null) {
                  // return DashboardPage();
                  if (st_uname != null && st_pwd != null) {
                    return MainDashboard();
                  } else {
                    return LoginPage();
                  }
                } else {
                  return RegistrationScreen();
                }
              }));
    });
  }

  shared() async {
    var status = await Permission.storage.status;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // fp = prefs.getString("fp");
    // print("fingerPrint......$fp");

    // if (com_cid != null) {
    //   Provider.of<AdminController>(context, listen: false)
    //       .getCategoryReport(com_cid!);
    //   Provider.of<Controller>(context, listen: false).adminDashboard(com_cid!);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();
    // Provider.of<Controller>(context, listen: false)
    //     .verifyRegistration(context, "splash");
    shared();
    navigate();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: P_Settings.loginPagetheme,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "asset/logo_black_bg.png",
                )),
          ],
        )),
      ),
    );
  }
}
