import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/screen/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: P_Settings.loginPagetheme,
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Refresh"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Logout"),
                ),
              ];
            }, onSelected: (value) async {
              if (value == 0) {
                // Provider.of<Controller>(context, listen: false).userDetails();
                // Provider.of<Controller>(context, listen: false)
                // .getStockApprovalList(context);
              } else if (value == 1) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('st_username');
                await prefs.remove('st_pwd');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                print('Pressed');
              }
            }),
          ],
        ),
        body: Container(
          height: double.infinity,
          child: Column(
            children: [
              Container(
                height: size.height * 0.1,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Image.asset("asset/login.png"),
                  ),
                  title: Text(
                    "anu",
                    // value.staff_name.toString(),
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: P_Settings.buttonColor,
                    ),
                  ),
                  subtitle: Text(
                    "KNR",
                    // value.branch_name.toString(),
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: P_Settings.buttonColor,
                    ),
                  ),
                  dense: false,
                ),
                color: P_Settings.loginPagetheme,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      // Provider.of<Controller>(context, listen: false)
                      //     .getTransactionList(context);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => TransactionPage()),
                      // );
                    },
                    leading: CircleAvatar(
                        radius: 20, child: Image.asset("asset/exchanging.png")),
                    trailing: Icon(Icons.arrow_forward),
                    title: Text(
                      "Transaction",
                      style: GoogleFonts.aBeeZee(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: P_Settings.loginPagetheme,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      // Provider.of<Controller>(context, listen: false)
                      //     .getTransactionList(context);
                      // Provider.of<Controller>(context, listen: false)
                      //     .setIssearch(false);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           SearchScreen(type: "start")),
                      // );
                    },
                    leading: CircleAvatar(
                        radius: 20, child: Image.asset("asset/search.png")),
                    trailing: Icon(Icons.arrow_forward),
                    title: Text(
                      "Search",
                      style: GoogleFonts.aBeeZee(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: P_Settings.loginPagetheme,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
