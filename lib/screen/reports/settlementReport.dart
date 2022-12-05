import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/alertCommon.dart';
import 'package:gulferp/components/dateFind.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/commonColor.dart';
import '../../controller/controller.dart';

class SettlementReport extends StatefulWidget {
  @override
  State<SettlementReport> createState() => _SettlementReportState();
}

class _SettlementReportState extends State<SettlementReport> {
  DateTime now = DateTime.now();
  // TransaInfoBottomsheet infoshowsheet = TransaInfoBottomsheet();
  AlertCommon popup = AlertCommon();
  DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  List<String> splitted = [];
  String? todaydate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    s = date!.split(" ");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        title: Text(
          "Settlement Report",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isReportLoading!) {
            return SpinKitCircle(
              color: P_Settings.loginPagetheme,
            );
          } else if (value.vehicleSettlemntList.length == 0) {
            return Center(
              child: Container(
                  height: size.height * 0.7,
                  alignment: Alignment.center,
                  child: Lottie.asset('asset/reportlot.json', height: 300
                      // height: size.height*0.3,
                      // width: size.height*0.3,
                      )),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 11.0, left: 8, right: 8),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 180,
                        child: Text(
                          "Series",
                          style: GoogleFonts.aBeeZee(
                            // textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Collection",
                          style: GoogleFonts.aBeeZee(
                            // textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Expense",
                          style: GoogleFonts.aBeeZee(
                            // textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.vehicleSettlemntList.length + 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: Column(
                          children: [
                            index == value.vehicleSettlemntList.length
                                ? Container(
                                    // color: Colors.black,
                                    // height: 20,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 180,
                                          // color: Colors.green,
                                        ),
                                        Container(
                                          width: 100,
                                          alignment: Alignment.centerRight,

                                          // color: Colors.green,
                                          child: Text(
                                            value.collectionVal.toString(),
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          alignment: Alignment.centerRight,
                                          // color: Colors.red,
                                          child: Text(
                                            value.expnVal.toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        width: 180,
                                        child: Text(
                                            value.vehicleSettlemntList[index]
                                                ["series"]),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: 100,
                                        child: Text(value.vehicleSettlemntList[
                                                    index]["flag"] ==
                                                "2"
                                            ? value.vehicleSettlemntList[index]
                                                ["amt"]
                                            : "0.00"),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: 100,
                                        child: Text(value.vehicleSettlemntList[
                                                    index]["flag"] ==
                                                "1"
                                            ? value.vehicleSettlemntList[index]
                                                ["amt"]
                                            : "0.00"),
                                      ),
                                    ],
                                  ),
                            Divider()
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   height: size.height * 0.06,

                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 180,
                    //         color: Colors.green,
                    //       ),
                    //       Container(
                    //         width: 100,
                    //         color: Colors.green,
                    //       ),
                    //       Container(
                    //         width: 100,
                    //         color: Colors.red,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      width: double.infinity,
                      height: size.height * 0.06,
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Balance  : ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              " ${value.collExpBal.toString()}",
                              style: GoogleFonts.aBeeZee(
                                // textStyle: Theme.of(context).textTheme.bodyText2,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
