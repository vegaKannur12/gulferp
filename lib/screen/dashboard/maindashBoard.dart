import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/screen/loginPage.dart';
import 'package:gulferp/screen/sale/saleHome.dart';
import 'package:gulferp/screen/sale/saleItemSelection.dart';
import 'package:gulferp/screen/sale/saleSearchItem.dart';
import 'package:gulferp/screen/searchPage/searchPage.dart';
import 'package:gulferp/screen/vehicle%20Loading/vehicleLoading.dart';
import 'package:gulferp/screen/vehicle%20Loading/vehicle_unloading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/controller.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).userDetails();
    Provider.of<Controller>(context, listen: false)
        .getvehicleLoadingList(context);
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    Provider.of<Controller>(context, listen: false).userDetails();
    Provider.of<Controller>(context, listen: false)
        .getvehicleLoadingList(context);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: P_Settings.loginPagetheme,
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
              Provider.of<Controller>(context, listen: false).userDetails();
              Provider.of<Controller>(context, listen: false)
                  .getvehicleLoadingList(context);
            } else if (value == 1) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('st_uname');
              await prefs.remove('st_pwd');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              print('Pressed');
            }
          }),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: Container(
          height: size.height * 0.9,
          // color: P_Settings.loginPagetheme,
          child: Consumer<Controller>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Container(
                    height: size.height * 0.1,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Image.asset("asset/login.png"),
                      ),
                      title: Text(
                        value.staff_name.toString(),
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.buttonColor,
                        ),
                      ),
                      subtitle: Text(
                        value.branch_name.toString(),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 30, top: 50),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          value.cusName1 = null;
                          value.cus_id = null;
                          value.gtype1 = null;
                          Provider.of<Controller>(context, listen: false)
                              .getRouteList(context);
                          Provider.of<Controller>(context, listen: false)
                              .getInvoice("1");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaleHome(
                                      formType: "1",
                                      type: "Sale",
                                    )),
                          );
                        },
                        leading: Image.asset("asset/sale.png",
                            // color: Colors.red,
                            height: 30),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Sale",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 30, top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          Provider.of<Controller>(context, listen: false)
                              .getRouteList(context);
                          Provider.of<Controller>(context, listen: false)
                              .getInvoice("2");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaleHome(
                                    formType: "2", type: "Sale Return")),
                          );
                        },
                        leading: Image.asset("asset/package.png",
                            // color: Colors.red,
                            height: 30),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Sale Return",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 30, top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () async {
                          await Provider.of<Controller>(context, listen: false)
                              .getbagData1(context, "3", "");
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => SaleSearchItem(
                                      form_type: "3",
                                      remark: "",
                                      gtype: "",
                                    )
                                // OrderForm(widget.areaname,"return"),
                                ),
                          );
                          // Provider.of<Controller>(context, listen: false)
                          //     .getItemCategory(context);
                          // List<Map<String, dynamic>> list =
                          //     await Provider.of<Controller>(context,
                          //             listen: false)
                          //         .getProductDetails("0", "", "");
                          // Navigator.of(context).push(
                          //   PageRouteBuilder(
                          //       opaque: false, // set to false
                          //       pageBuilder: (_, __, ___) => SaleItemSelection(
                          //             list: list,
                          //             type: "",
                          //             remark: "",
                          //             formType: "3",
                          //             g_type: "1",
                          //           )
                          //       // OrderForm(widget.areaname,"return"),
                          //       ),
                          // );
                        },
                        leading: Image.asset("asset/unloading.png",
                            // color: Colors.red,
                            height: 30),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Vehicle Unloading",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 30, top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          // Provider.of<Controller>(context, listen: false)
                          //     .getTransactionList(context);
                          Provider.of<Controller>(context, listen: false)
                              .setIssearch(false);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchScreen(type: "start")),
                          );
                        },
                        leading: Image.asset(
                          "asset/searchwhite.png",
                          height: 30,
                          color: Colors.green,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Search",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///////////////////////////////////////////////
                  value.loadingList.length == 0
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 30, top: 10),
                          child: ListTile(
                            // leading: Image.asset(
                            //   "asset/loading.png",
                            //   height: 30,
                            //   // color: Colors.green,
                            // ),
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Vehicle Loading",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: P_Settings.loginPagetheme,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        ),
                  value.isLoading
                      ? Flexible(
                          child: Container(
                            height: double.infinity,
                            child: SpinKitFadingCircle(
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: value.loadingList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 30, top: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.grey[200],
                                  child: ListTile(
                                    onTap: () {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getvehicleLoadingInfo(
                                        context,
                                        value.loadingList[index]["os_id"],
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VehicleLoading(
                                                  os_id:
                                                      value.loadingList[index]
                                                          ["os_id"],
                                                )),
                                      );
                                    },
                                    trailing: Icon(
                                      Icons.arrow_forward,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                    title: Row(
                                      children: [
                                        Text(
                                          value.loadingList[index]["series"]
                                              .toString(),
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 14.0),
                                          child: Text(
                                            value.loadingList[index]
                                                    ["entry_date"]
                                                .toString(),
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                              color: P_Settings.loginPagetheme,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          "Branch : ",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          value.loadingList[index]
                                                  ["from_branch"]
                                              .toString(),
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                ],
              );
            },
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     height: double.infinity,
      //     child: Column(
      //       children: [

      //         // Container(

      //         //   child: Stack(
      //         //     children: [
      //         //       Container(
      //         //         height: size.height * 0.1,
      //         //         alignment: Alignment.center,
      //         //         child: ListTile(
      //         //           leading: CircleAvatar(
      //         //             radius: 40,
      //         //             child: Image.asset("asset/login.png"),
      //         //           ),
      //         //           title: Text(
      //         //             "ANU",
      //         //             // value.staff_name.toString(),
      //         //             style: GoogleFonts.aBeeZee(
      //         //               textStyle: Theme.of(context).textTheme.bodyText2,
      //         //               fontSize: 23,
      //         //               fontWeight: FontWeight.bold,
      //         //               color: P_Settings.buttonColor,
      //         //             ),
      //         //           ),
      //         //           subtitle: Text(
      //         //             "KNR",
      //         //             // value.branch_name.toString(),
      //         //             style: GoogleFonts.aBeeZee(
      //         //               textStyle: Theme.of(context).textTheme.bodyText2,
      //         //               fontSize: 14,
      //         //               // fontWeight: FontWeight.bold,
      //         //               color: P_Settings.buttonColor,
      //         //             ),
      //         //           ),
      //         //           dense: false,
      //         //         ),
      //         //         decoration: BoxDecoration(
      //         //           color: Color.fromARGB(255, 61, 61, 61),
      //         //           image: DecorationImage(
      //         //             image: AssetImage("asset/liq2.jpg"),
      //         //             fit: BoxFit.cover,
      //         //           ),
      //         //           borderRadius: BorderRadius.only(
      //         //               bottomLeft: Radius.circular(30.0),
      //         //               bottomRight: Radius.circular(30.0)),
      //         //           border: Border.all(
      //         //             color: Color.fromARGB(255, 0, 0, 0),
      //         //           ),
      //         //         ),
      //         //         // color:Color.fromARGB(255, 61, 61, 61),
      //         //       ),
      //         //     ],
      //         //   ),
      //         // ),
      //         SizedBox(
      //           height: size.height * 0.03,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20, right: 30, top: 50),
      //           child: Card(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15.0),
      //             ),
      //             color: Colors.grey[200],
      //             child: ListTile(
      //               onTap: () {
      //                 // Provider.of<Controller>(context, listen: false)
      //                 //     .getTransactionList(context);

      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => SaleHome()),
      //                 );
      //               },
      //               leading: Image.asset("asset/sale.png",
      //                   // color: Colors.red,
      //                   height: 30),
      //               trailing: Icon(
      //                 Icons.arrow_forward,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Sale",
      //                 style: GoogleFonts.aBeeZee(
      //                   textStyle: Theme.of(context).textTheme.bodyText2,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
      //           child: Card(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15.0),
      //             ),
      //             color: Colors.grey[200],
      //             child: ListTile(
      //               onTap: () {
      //                 // Provider.of<Controller>(context, listen: false)
      //                 //     .getTransactionList(context);

      //                 // Navigator.push(
      //                 //   context,
      //                 //   MaterialPageRoute(
      //                 //       builder: (context) => TransactionPage()),
      //                 // );
      //               },
      //               leading: Image.asset("asset/package.png",
      //                   // color: Colors.red,
      //                   height: 30),
      //               trailing: Icon(
      //                 Icons.arrow_forward,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Sale Return",
      //                 style: GoogleFonts.aBeeZee(
      //                   textStyle: Theme.of(context).textTheme.bodyText2,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
      //           child: Card(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15.0),
      //             ),
      //             color: Colors.grey[200],
      //             child: ListTile(
      //               onTap: () {
      //                 // Provider.of<Controller>(context, listen: false)
      //                 //     .getTransactionList(context);

      //                 // Navigator.push(
      //                 //   context,
      //                 //   MaterialPageRoute(
      //                 //       builder: (context) => TransactionPage()),
      //                 // );
      //               },
      //               leading: Image.asset("asset/unloading.png",
      //                   // color: Colors.red,
      //                   height: 30),
      //               trailing: Icon(
      //                 Icons.arrow_forward,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Vehicle Unloading",
      //                 style: GoogleFonts.aBeeZee(
      //                   textStyle: Theme.of(context).textTheme.bodyText2,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
      //           child: Card(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15.0),
      //             ),
      //             color: Colors.grey[200],
      //             child: ListTile(
      //               onTap: () {
      //                 // Provider.of<Controller>(context, listen: false)
      //                 //     .getTransactionList(context);
      //                 // Provider.of<Controller>(context, listen: false)
      //                 //     .setIssearch(false);
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => SearchScreen(type: "start")),
      //                 );
      //               },
      //               leading: Image.asset(
      //                 "asset/searchwhite.png",
      //                 height: 30,
      //                 color: Colors.green,
      //               ),
      //               trailing: Icon(
      //                 Icons.arrow_forward,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Search",
      //                 style: GoogleFonts.aBeeZee(
      //                   textStyle: Theme.of(context).textTheme.bodyText2,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //             child: ListView.builder(
      //           itemCount: 5,
      //           itemBuilder: (context, index) {
      //             return Padding(
      //               padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
      //               child: Card(
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(15.0),
      //                 ),
      //                 color: Colors.grey[200],
      //                 child: ListTile(
      //                   onTap: () {
      //                     // Provider.of<Controller>(context, listen: false)
      //                     //     .getTransactionList(context);
      //                     // Provider.of<Controller>(context, listen: false)
      //                     //     .setIssearch(false);
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) =>
      //                               SearchScreen(type: "start")),
      //                     );
      //                   },
      //                   leading: Image.asset(
      //                     "asset/searchwhite.png",
      //                     height: 30,
      //                     color: Colors.green,
      //                   ),
      //                   trailing: Icon(
      //                     Icons.arrow_forward,
      //                     color: Colors.black,
      //                   ),
      //                   title: Text(
      //                     "Search",
      //                     style: GoogleFonts.aBeeZee(
      //                       textStyle: Theme.of(context).textTheme.bodyText2,
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                       color: Colors.black,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         )),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

// Widget _buildParallaxBackground(BuildContext context) {
//   return Image.network(
//       "https://st.depositphotos.com/1177973/4630/i/600/depositphotos_46301661-stock-photo-glasses-of-champagne-with-splash.jpg",
//       fit: BoxFit.contain,
//       colorBlendMode: BlendMode.darken);
// }

// Widget _buildGradient() {
//   return Positioned.fill(
//     child: DecoratedBox(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           stops: const [0.6, 0.95],
//         ),
//       ),
//     ),
//   );
// }
