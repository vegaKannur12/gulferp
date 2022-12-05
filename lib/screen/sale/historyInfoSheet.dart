import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';

import 'package:provider/provider.dart';

class HistoryInfoSheet {
  final List<Map<String, String>> listOfColumns = [
    {"Name": "AAAAAA", "Number": "1", "State": "Yes"},
    {"Name": "BBBBBB", "Number": "2", "State": "no"},
    {"Name": "CCCCCC", "Number": "3", "State": "Yes"}
  ];
  ValueNotifier<bool> visible = ValueNotifier(false);

  // TextEditingController searchcontroller = TextEditingController();
  TextEditingController payblecontroller = TextEditingController();
  String? oldText;
  // String? selected;

  showinfoSheet(
    BuildContext context,
    Size size,
    String formType,
  ) {
    // searchcontroller.text = "";
    payblecontroller.clear();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // String imgGlobal = Globaldata.imageurl;
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();

            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                // await Provider.of<Controller>(context,
                                //         listen: false)
                                //     .getbagData1(context, formType, "");
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                          top: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "History Info",
                              style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 22,
                                  // fontWeight: FontWeight.bold,
                                  color: P_Settings.loginPagetheme),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        thickness: 2,
                      ),
                      DataTable(
                        columns: [
                          DataColumn(label: Text('Item')),
                          DataColumn(label: Text('Qty')),
                          DataColumn(label: Text('Rate')),
                        ],
                        rows:
                            listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                                .map(
                                  ((element) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(element[
                                              "Name"]!)), //Extracting from Map element the value
                                          DataCell(Text(element["Number"]!)),
                                          DataCell(Text(element["State"]!)),
                                        ],
                                      )),
                                )
                                .toList(),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     left: 18.0,
                      //     right: 18.0,
                      //     top: 10,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Container(
                      //         alignment: Alignment.centerLeft,
                      //         width: size.width * 0.4,
                      //         child: Text(
                      //           "Item",
                      //           style: GoogleFonts.aBeeZee(
                      //               textStyle:
                      //                   Theme.of(context).textTheme.bodyText2,
                      //               fontSize: 18,
                      //               // fontWeight: FontWeight.bold,
                      //               color: P_Settings.loginPagetheme),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: size.width * 0.08,
                      //         child: Text(
                      //           "Qty",
                      //           style: GoogleFonts.aBeeZee(
                      //               textStyle:
                      //                   Theme.of(context).textTheme.bodyText2,
                      //               fontSize: 18,
                      //               // fontWeight: FontWeight.bold,
                      //               color: P_Settings.loginPagetheme),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: size.width * 0.2,
                      //         alignment: Alignment.centerRight,
                      //         child: Text(
                      //           "Rate",
                      //           style: GoogleFonts.aBeeZee(
                      //               textStyle:
                      //                   Theme.of(context).textTheme.bodyText2,
                      //               fontSize: 18,
                      //               // fontWeight: FontWeight.bold,
                      //               color: P_Settings.loginPagetheme),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: 5,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(
                      //           left: 18.0,
                      //           right: 18.0,
                      //           top: 10,
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Flexible(
                      //               // alignment: Alignment.centerLeft,
                      //               // width: size.width*0.4,
                      //               child: Text(
                      //                 "hgjdsddszdfgfg",
                      //                 style: GoogleFonts.aBeeZee(
                      //                     textStyle: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyText2,
                      //                     fontSize: 18,
                      //                     // fontWeight: FontWeight.bold,
                      //                     color: P_Settings.loginPagetheme),
                      //               ),
                      //             ),
                      //             Container(
                      //               width: size.width * 0.1,
                      //               child: Text(
                      //                 "1066",
                      //                 style: GoogleFonts.aBeeZee(
                      //                     textStyle: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyText2,
                      //                     fontSize: 18,
                      //                     // fontWeight: FontWeight.bold,
                      //                     color: P_Settings.loginPagetheme),
                      //               ),
                      //             ),
                      //             Container(
                      //               alignment: Alignment.centerRight,
                      //               width: size.width * 0.3,
                      //               child: Text(
                      //                 "200888888.66",
                      //                 style: GoogleFonts.aBeeZee(
                      //                     textStyle: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyText2,
                      //                     fontSize: 18,
                      //                     // fontWeight: FontWeight.bold,
                      //                     color: P_Settings.loginPagetheme),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
