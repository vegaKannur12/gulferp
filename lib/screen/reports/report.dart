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

class Reports extends StatefulWidget {
  String reportType;
  Reports({required this.reportType});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
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
          widget.reportType == "1"
              ? "Itemwise Reports"
              : widget.reportType == "2"
                  ? "Stock Report"
                  : "Settlement Report",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
             widget.reportType=="1"? Container(
                height: size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          // String df;
                          // String tf;
                          dateFind.selectDateFind(context, "from date");
                          // if (value.fromDate == null) {
                          //   df = todaydate.toString();
                          // } else {
                          //   df = value.fromDate.toString();
                          // }
                          // if (value.todate == null) {
                          //   tf = todaydate.toString();
                          // } else {
                          //   tf = value.todate.toString();
                          // }
                          // Provider.of<Controller>(context, listen: false)
                          //     .historyData(context, splitted[0], "",
                          //         df, tf);
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: P_Settings.loginPagetheme,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        value.fromDate == null
                            ? todaydate.toString()
                            : value.fromDate.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          dateFind.selectDateFind(context, "to date");
                        },
                        icon: Icon(Icons.calendar_month)),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        value.todate == null
                            ? todaydate.toString()
                            : value.todate.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Container(
                      // height: size.height * 0.03,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: P_Settings.loginPagetheme,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(2), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          String df;
                          String tf;

                          if (value.fromDate == null) {
                            df = todaydate.toString();
                          } else {
                            df = value.fromDate.toString();
                          }
                          if (value.todate == null) {
                            tf = todaydate.toString();
                          } else {
                            tf = value.todate.toString();
                          }

                          print(
                              "splited----$df----------$tf---------$splitted");
                          widget.reportType == "1"
                              ? Provider.of<Controller>(context, listen: false)
                                  .itemwisereports(context, df, tf)
                              : Provider.of<Controller>(context, listen: false)
                                  .stockreports(
                                  context,
                                );
                        },
                        child: Text(
                          "Apply",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.buttonColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // dropDownCustom(size,""),
              ):Container(),
              value.isReportLoading!
                  ? Container(
                    height: size.height * 0.7,
                    child: SpinKitCircle(
                        color: P_Settings.loginPagetheme,
                      ),
                  )
                  : value.reportsList.length == 0
                      ? Center(
                          child: Container(
                              height: size.height * 0.7,
                              alignment: Alignment.center,
                              child: Lottie.asset('asset/reportlot.json',
                                  height: 250
                                  // height: size.height*0.3,
                                  // width: size.height*0.3,
                                  )),
                        )
                      : Expanded(
                          child: ListView.builder(
                          itemCount: value.reportsList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  // historyInfo.showinfoSheet(
                                  //   context,
                                  //   size,
                                  //   widget.form_type,
                                  // );
                                },
                                // trailing: Wrap(
                                //   spacing: 10,
                                //   children: [],
                                // ),
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${value.reportsList[index]['item_name']} ",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                       
                                      ],
                                    ),
                                  widget.reportType=="2"?  Row(
                                      children: [
                                        Text(
                                          "Stock : ",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                            color:Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          "${value.reportsList[index]['stock']} ",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                       
                                      ],
                                    ):Container()
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
            ],
          );
        },
      ),
    );
  }
}
