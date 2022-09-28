import 'package:flutter/material.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class CommonPopup {
  String? stockio;
  int sales_id = 0;
  String? cid;
  String? gen_condition;
  String? sid;
  // Widget buildPopupDialog(String content, BuildContext context) {
  //   return AlertDialog(
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text("${content}"),
  //       ],
  //     ),
  //     actions: [
  //       Column(
  //         children: [
  //           RadioListTile(
  //             title: Text("StockIn"),
  //             value: "male",
  //             groupValue: stockio,
  //             onChanged: (value) {
  //               // setState(() {
  //               //   gender = value.toString();
  //               // });
  //             },
  //           ),
  //           RadioListTile(
  //             title: Text("StockOut"),
  //             value: "female",
  //             groupValue: stockio,
  //             onChanged: (value) {
  //               setState(() {
  //                 stockio = value.toString();
  //               });
  //             },
  //           ),
  //           ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Cancel")),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
