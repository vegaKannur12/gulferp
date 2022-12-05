import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/alertCommon.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/components/dateFind.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/sale/historyInfoSheet.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  String form_type;
  HistoryPage({required this.form_type});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime now = DateTime.now();
  // TransaInfoBottomsheet infoshowsheet = TransaInfoBottomsheet();
  AlertCommon popup = AlertCommon();
  DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  List<String> splitted = [];
  ValueNotifier<bool> visible = ValueNotifier(false);
  String? selectedtransaction;
  String? todaydate;
  HistoryInfoSheet historyInfo = HistoryInfoSheet();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now);
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    s = date!.split(" ");
    widget.form_type == "3"
        ? Provider.of<Controller>(context, listen: false)
            .historyunloadvehicleData(context, "", todaydate!, todaydate!)
        : widget.form_type == "1" || widget.form_type == "2"
            ? Provider.of<Controller>(context, listen: false).historyData(
                context, "", todaydate!, todaydate!, widget.form_type)
            : Provider.of<Controller>(context, listen: false)
                .historyExpenseAndCollectionData(
                    context, "", todaydate!, todaydate!, widget.form_type);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("form type..........${widget.form_type}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.form_type=="1"?"Sale History":widget.form_type=="2"?"Sale Return History":widget.form_type=="3"?"Vehicle Unloading History":widget.form_type=="5"?"Collection History":"Expense History",
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Container(
                height: double.infinity,
                // height: size.height*0.8,
                child: SpinKitFadingCircle(
                  color: P_Settings.loginPagetheme,
                ));
          } else {
            return Column(
              children: [
                Container(
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
                            widget.form_type == "3"
                                ? Provider.of<Controller>(context,
                                        listen: false)
                                    .historyunloadvehicleData(
                                        context, "", df, tf)
                                : Provider.of<Controller>(context,
                                        listen: false)
                                    .historyData(
                                        context, "", df, tf, widget.form_type);
                            // if (splitted != null && splitted.isNotEmpty) {
                            //   Provider.of<Controller>(context, listen: false)
                            //       .historyData(context, df, tf);
                            // }
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                Divider(),
                value.isLoading
                    ? SpinKitFadingCircle(
                        color: P_Settings.loginPagetheme,
                      )
                    : Expanded(
                        child: Container(
                            // height: size.height * 0.9,
                            child: widget.form_type == "3"
                                ? value.unloadhistoryList.length == 0
                                    ? Center(
                                        child: Container(
                                            height: size.height * 0.7,
                                            alignment: Alignment.center,
                                            child: Lottie.asset(
                                                'asset/historyjson.json',
                                                height: 200
                                                // height: size.height*0.3,
                                                // width: size.height*0.3,
                                                )),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            value.unloadhistoryList.length,
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
                                              trailing: Wrap(
                                                spacing: 10,
                                                children: [],
                                              ),
                                              title: Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "${value.unloadhistoryList[index]['s_invoice_id']} ",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText2,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: P_Settings
                                                            .loginPagetheme,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.03,
                                                  ),
                                                  Text(
                                                    "- ${value.unloadhistoryList[index]['Unload Date']}",
                                                    style: GoogleFonts.aBeeZee(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText2,
                                                      fontSize: 16,
                                                      // fontWeight: FontWeight.bold,
                                                      color: P_Settings
                                                          .historyPageText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.03,
                                                  ),
                                                ],
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Items: ${value.unloadhistoryList[index]['Items']}",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                            fontSize: 16,
                                                            // fontWeight: FontWeight.bold,
                                                            color: P_Settings
                                                                .historyPageText,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Total Qty : ${value.unloadhistoryList[index]['Total Qty']}",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                            fontSize: 16,
                                                            // fontWeight: FontWeight.bold,
                                                            color: P_Settings
                                                                .historyPageText,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.01,
                                                    ),
                                                    // Row(
                                                    //   children: [
                                                    //     Text(
                                                    //       "\u{20B9}${value.unloadhistoryList[index]['Total Qty']}",
                                                    //       style:
                                                    //           GoogleFonts.aBeeZee(
                                                    //         textStyle:
                                                    //             Theme.of(context)
                                                    //                 .textTheme
                                                    //                 .bodyText2,
                                                    //         fontSize: 16,
                                                    //         fontWeight:
                                                    //             FontWeight.bold,
                                                    //         color:
                                                    //             P_Settings.redclr,
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                : widget.form_type == "1" ||
                                        widget.form_type == "2"
                                    ? value.historyList.length == 0
                                        ? Center(
                                            child: Container(
                                                height: size.height * 0.7,
                                                alignment: Alignment.center,
                                                child: Lottie.asset(
                                                    'asset/historyjson.json',
                                                    height: 200
                                                    // height: size.height*0.3,
                                                    // width: size.height*0.3,
                                                    )),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: value.historyList.length,
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
                                                  title: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.center,

                                                    children: [
                                                      Text(
                                                        "${value.historyList[index]['Invoice No']} ",
                                                        style: GoogleFonts
                                                            .aBeeZee(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: P_Settings
                                                              .loginPagetheme,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   width:
                                                      //       size.width * 0.03,
                                                      // ),
                                                      Text(
                                                        widget.form_type == "1"
                                                            ? "-${value.historyList[index]['Invoice Date']}"
                                                            : "-${value.historyList[index]['Date']}",
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                          fontSize: 16,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: P_Settings
                                                              .historyPageText,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                    widget.form_type=="1"?  Text(
                                                        "(Pmode :",
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                                fontSize: 13,
                                                                // fontWeight: FontWeight
                                                                //     .bold,
                                                                color: Colors
                                                                    .grey[600]),
                                                      ):Container(),
                                                      widget.form_type=="1"? Text(
                                                        "${value.historyList[index]['payment_mode'].toString()})",
                                                        // widget.form_type ==
                                                        //         "1"
                                                        //     ? "\u{20B9}${value.historyList[index]['Total Amount']}"
                                                        //     : "\u{20B9}${value.historyList[index]['Grand Total']}",
                                                        style: GoogleFonts.aBeeZee(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: P_Settings
                                                                .loginPagetheme),
                                                      ):Container(),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.03,
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.start,
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            widget.form_type ==
                                                                    "1"
                                                                ? "${value.historyList[index]['Customer Name']}  (Items: ${value.historyList[index]['Items']})"
                                                                : "${value.historyList[index]['Customer']}  (Items: ${value.historyList[index]['Items']})",
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                              fontSize: 16,
                                                              // fontWeight: FontWeight.bold,
                                                              color: P_Settings
                                                                  .historyPageText,
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   " (Items: ${value.historyList[index]['Items']})",
                                                          //   style:
                                                          //       GoogleFonts.aBeeZee(
                                                          //     textStyle:
                                                          //         Theme.of(context)
                                                          //             .textTheme
                                                          //             .bodyText2,
                                                          //     fontSize: 16,
                                                          //     // fontWeight: FontWeight.bold,
                                                          //     color: P_Settings
                                                          //         .historyPageText,
                                                          //   ),
                                                          // ),
                                                          Text(
                                                              "Total Qty  : ${value.historyList[index]['Total Qty']}")
                                                        ],
                                                      ),
                                                      // SizedBox(
                                                      //   height: size.height * 0.01,
                                                      // ),
                                                      Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          widget.form_type ==
                                                                  "1"
                                                              ? Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              0.0),
                                                                      child:
                                                                          Text(
                                                                        "Paid:",
                                                                        style: GoogleFonts
                                                                            .aBeeZee(
                                                                          textStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2,
                                                                          fontSize:
                                                                              16,
                                                                          // fontWeight:
                                                                          //     FontWeight.bold,
                                                                          // color:
                                                                          //     P_Settings.redclr,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      // "12345678.11",
                                                                      value
                                                                          .historyList[
                                                                              index]
                                                                              [
                                                                              'Payable']
                                                                          .toString(),
                                                                      style: GoogleFonts
                                                                          .aBeeZee(
                                                                        textStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: P_Settings
                                                                            .redclr,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Total:",
                                                                style:
                                                                    GoogleFonts
                                                                        .aBeeZee(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2,
                                                                  fontSize: 16,
                                                                  // fontWeight:
                                                                  //     FontWeight.bold,
                                                                  // color:
                                                                  //     P_Settings.redclr,
                                                                ),
                                                              ),
                                                              Text(
                                                                // "12345678.22",
                                                                widget.form_type ==
                                                                        "1"
                                                                    ? "\u{20B9}${value.historyList[index]['Total Amount']}"
                                                                    : "\u{20B9}${value.historyList[index]['Grand Total']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .aBeeZee(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      P_Settings
                                                                          .redclr,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                    : value.expenseCollList.length == 0
                                        ? Center(
                                            child: Container(
                                                height: size.height * 0.7,
                                                alignment: Alignment.center,
                                                child: Lottie.asset(
                                                    'asset/historyjson.json',
                                                    height: 200
                                                    // height: size.height*0.3,
                                                    // width: size.height*0.3,
                                                    )),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                value.expenseCollList.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                    title: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                            child:
                                                                widget.form_type ==
                                                                        "4"
                                                                    ? Text(
                                                                        "${value.expenseCollList[index]['Series']} ",
                                                                        style: GoogleFonts
                                                                            .aBeeZee(
                                                                          textStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              P_Settings.loginPagetheme,
                                                                        ),
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Text(
                                                                              "${value.expenseCollList[index]['Series']} ",
                                                                              style: GoogleFonts.aBeeZee(
                                                                                textStyle: Theme.of(context).textTheme.bodyText2,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: P_Settings.loginPagetheme,
                                                                              )),
                                                                          Text(
                                                                              "-"),
                                                                          Text(
                                                                            "${value.expenseCollList[index]['Series']} ",
                                                                            style:
                                                                                GoogleFonts.aBeeZee(
                                                                              textStyle: Theme.of(context).textTheme.bodyText2,
                                                                              fontSize: 16,
                                                                              // fontWeight:
                                                                              //     FontWeight.bold,
                                                                              color: P_Settings.loginPagetheme,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                        Text(
                                                          "${value.expenseCollList[index]['Date']} ",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                            fontSize: 16,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            color: P_Settings
                                                                .loginPagetheme,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "Amount :",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                            fontSize: 16,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            color: P_Settings
                                                                .loginPagetheme,
                                                          ),
                                                        ),
                                                        Text(
                                                          "\u{20B9}${value.expenseCollList[index]['Amount']} ",
                                                          style: GoogleFonts
                                                              .aBeeZee(
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                              );
                                            },
                                          )),
                      )
              ],
            );
          }
        },
      ),
    );
  }

///////////////////////////////////////////////////////////////////

  // Widget dropDownCustom(Size size, String type) {
  //   return Consumer<Controller>(
  //     builder: (context, value, child) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           width: size.width * 0.7,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5.0),
  //             border: Border.all(
  //                 color: P_Settings.loginPagetheme,
  //                 style: BorderStyle.solid,
  //                 width: 0.4),
  //           ),
  //           child: DropdownButton<String>(
  //             itemHeight: null,
  //             isExpanded: true,
  //             value: selectedtransaction,

  //             // isDense: true,
  //             hint: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text("Select Transaction"),
  //             ),
  //             // isExpanded: true,
  //             autofocus: false,
  //             underline: SizedBox(),
  //             elevation: 0,
  //             items: value.transactionist
  //                 .map((item) => DropdownMenuItem<String>(
  //                     value:
  //                         "${item.transId},${item.transPrefix},${item.transType},${item.transVal},${item.branch_selection}",
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             item.transType.toString(),
  //                             style: TextStyle(fontSize: 14),
  //                           ),
  //                         ),
  //                       ],
  //                     )))
  //                 .toList(),
  //             onChanged: (item) {
  //               print("clicked");
  //               if (item != null) {
  //                 setState(() {
  //                   selectedtransaction = item;
  //                 });
  //                 print("selectedtransaction-----${selectedtransaction}");

  //                 splitted = selectedtransaction!.split(',');

  //                 print("splitted-----${splitted}");

  //                 // String tf;

  //                 // if (value.fromDate == null) {
  //                 //   df = todaydate.toString();
  //                 // } else {
  //                 //   df = value.fromDate.toString();
  //                 // }
  //                 // if (value.todate == null) {
  //                 //   tf = todaydate.toString();
  //                 // } else {
  //                 //   tf = value.todate.toString();
  //                 // }

  //                 // Provider.of<Controller>(context, listen: false)
  //                 //     .historyData(context, splitted[0], "", df, tf);
  //               }
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
