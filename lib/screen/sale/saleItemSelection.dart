// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:gulferp/components/commonColor.dart';
// import 'package:gulferp/controller/controller.dart';
// import 'package:gulferp/screen/bag/salesBag.dart';
// import 'package:gulferp/screen/history/history.dart';
// import 'package:gulferp/screen/vehicle%20Loading/unload_cart.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../itemSelectionCommon.dart';

// class SaleItemSelection extends StatefulWidget {
//   List<Map<String, dynamic>> list;
//   String? remark;
//   String type;
//   String formType;
//   String g_type;
//   SaleItemSelection(
//       {required this.list,
//       required this.type,
//       this.remark,
//       required this.formType,
//       required this.g_type});

//   @override
//   State<SaleItemSelection> createState() => _SaleItemSelectionState();
// }

// class _SaleItemSelectionState extends State<SaleItemSelection> {
//   List<Map<String, dynamic>> list = [];
//   DateTime now = DateTime.now();
//   String? branch_id;
//   String? todaydate;
//   @override
//   void initState() {
//     todaydate = DateFormat('dd-MM-yyyy').format(now);
//     // TODO: implement initState
//     super.initState();
//     itemList();
//   }

//   itemList() async {
//     list = await Provider.of<Controller>(context, listen: false)
//         .getProductDetails("0", "", widget.formType);
//     print("form type........${widget.formType}");
//     print("listttt----${list}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: Text(
//         //   // widget.transType.toString(),
//         //   style: GoogleFonts.aBeeZee(
//         //     textStyle: Theme.of(context).textTheme.bodyText2,
//         //     fontSize: 18,
//         //     fontWeight: FontWeight.bold,
//         //     color: P_Settings.buttonColor,
//         //   ),
//         // ),
//         backgroundColor: P_Settings.loginPagetheme,
//         actions: [
//           widget.formType == "3"
//               ? IconButton(
//                   onPressed: () {
//                     Provider.of<Controller>(context, listen: false)
//                         .unloadhistoryList
//                         .clear();
//                     Provider.of<Controller>(context, listen: false)
//                         .setDate(todaydate!, todaydate!);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => HistoryPage(
//                                 form_type: widget.formType,
//                               )),
//                     );
//                   },
//                   icon: Container(
//                     height: 20,
//                     child: Image.asset("asset/history.png"),
//                   ),
//                 )
//               : Text(""),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Badge(
//               animationType: BadgeAnimationType.scale,
//               toAnimate: true,
//               badgeColor: Colors.white,
//               badgeContent: Consumer<Controller>(
//                 builder: (context, value, child) {
//                   print("cart count.....${value.cartCount}");
//                   if (value.cartCount == null) {
//                     return SpinKitChasingDots(
//                         color: P_Settings.buttonColor, size: 9);
//                   } else {
//                     return Text(
//                       "${value.cartCount}",
//                       style:
//                           TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                     );
//                   }
//                 },
//               ),
//               position: const BadgePosition(start: 33, bottom: 25),
//               child: IconButton(
//                 onPressed: () async {
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   branch_id = prefs.getString("branch_id");
//                   // await Provider.of<Controller>(context, listen: false)
//                   //     .getbagData1(context, widget.formType);
//                   // // Provider.of<Controller>(context, listen: false).fromDb = true;
//                   // print("type item select..........${widget.formType}");
//                   if (widget.formType == '3') {
//                     print("type item select..........${widget.formType}");
//                     Navigator.push(
//                         context,
//                         PageRouteBuilder(
//                             opaque: false, // set to false
//                             pageBuilder: (_, __, ___) {
//                               return UnloadVehicleCart(
//                                 branchId: branch_id,
//                                 type: widget.type,
//                                 form_type: widget.formType,
//                                 gtype: widget.g_type,
//                                 remark: widget.remark,
//                               );
//                             }));
//                   } else {
//                     Navigator.push(
//                         context,
//                         PageRouteBuilder(
//                             opaque: false, // set to false
//                             pageBuilder: (_, __, ___) {
//                               return BagPage(
//                                 branchId: branch_id,
//                                 type: widget.type,
//                                 form_type: widget.formType,
//                                 gtype: widget.g_type,
//                                 remark: widget.remark,
//                               );
//                             }));
//                   }

//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //       builder: (context) => BagPage(
//                   //             transVal: widget.transVal,
//                   //             transType: widget.transType,
//                   //             transId: widget.transId,
//                   //             branchId: widget.branchId!,
//                   //             remark: widget.remark,
//                   //           )),
//                   // );
//                 },
//                 icon: const Icon(Icons.shopping_cart),
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.only(right: 18.0),
//           //   child: GestureDetector(
//           //     onTap: () {
//           //       Provider.of<Controller>(context, listen: false)
//           //           .getbagData(context);
//           //       Navigator.push(
//           //         context,
//           //         MaterialPageRoute(builder: (context) => BagPage()),
//           //       );
//           //     },
//           //     child: Image.asset(
//           //       "asset/shopping-cart.png",
//           //       height: size.height * 0.05,
//           //       width: size.width * 0.07,
//           //     ),
//           //   ),
//           // ),

//           // IconButton(
//           //   onPressed: () {
//           //     Navigator.push(
//           //       context,
//           //       MaterialPageRoute(builder: (context) => BagPage()),
//           //     );
//           //   },
//           //   icon: Icon(Icons.shopping_cart),
//           // )
//         ],
//       ),
//       body: Consumer<Controller>(
//         builder: (context, value, child) {
//           if (value.isProdLoading) {
//             return SpinKitFadingCircle(
//               color: P_Settings.loginPagetheme,
//             );
//           } else {
//             if (list.length > 0) {
//               return ItemSelection(
//                 list: list,
//                 formType: widget.formType,
//                 gtype: widget.g_type,
//                 // transVal: widget.transVal,
//                 // transType: widget.transType,
//               );
//             } else {
//               return Container();
//             }
//           }
//         },
//       ),
//     );
//   }
// }
