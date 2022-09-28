import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/components/customSnackbar.dart';
import 'package:mystock/controller/controller.dart';
import 'package:provider/provider.dart';

class TransaInfoBottomsheet {
  showtransInfoSheet(BuildContext context, int index, String transid,
      String transval, String osId) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    CustomSnackbar snackbar = CustomSnackbar();
    String? todaydate;
    DateTime now = DateTime.now();

    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        todaydate = DateFormat('dd-MM-yyyy').format(now);
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();
            if (value.isListLoading) {
              return Container(
                  height: 200,
                  child: SpinKitFadingCircle(
                    color: P_Settings.loginPagetheme,
                  ));
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Text("Product Name"),Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        ListTile(
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Text("Product Name"),Spacer(),
                                  Text(
                                    "Transaction info :",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Series",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${value.transinfoList[0]["series"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Type",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${value.transinfoList[0]["trans_type"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Date :",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${value.transinfoList[0]["entry_date"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
                          child: ListTile(
                            visualDensity:
                                VisualDensity(horizontal: 0, vertical: -4),
                            title: Row(
                              children: [
                                Text(
                                  "Branch :",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${value.transinfoList[0]["transfer_branch"]}',
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text("Product Name"),Spacer(),
                              Text(
                                "Item info :",
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          height: size.height * 0.2,
                          child: ListView.builder(
                            itemCount: value.transiteminfoList.length,
                            itemBuilder: (context, index) {
                              if (value.transinfohide[index]) {
                                return Container();
                              } else {
                                return ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          value.transiteminfoList[index]
                                              ["item_name"],
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 17,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.2,
                                        child: TextField(
                                          onChanged: (value) {},
                                          onTap: () {
                                            // Provider.of<Controller>(context,
                                            //         listen: false)
                                            //     .addDeletebagItem(
                                            //         itemId,
                                            //         srate1.toString(),
                                            //         srate2.toString(),
                                            //         value.qty[index].text,
                                            //         "0",
                                            //         "0",
                                            //         context);

                                            // print(
                                            //     "quantity......${value.qty[index].value.text}");
                                            value.historyqty[index].selection =
                                                TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: value
                                                        .historyqty[index]
                                                        .value
                                                        .text
                                                        .length);
                                          },

                                          // autofocus: true,
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 17,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(0),
                                            //border: InputBorder.none
                                          ),

                                          // maxLines: 1,
                                          // minLines: 1,
                                          keyboardType: TextInputType.number,
                                          onSubmitted: (values) {
                                            print(
                                                "don clicked----${value.oldhistoryqty[index].text}");
                                            String content = "";
                                            String msg = "";
                                            String event = "";

                                            if (value.historyqty[index].text ==
                                                    "0" &&
                                                value.transiteminfoList
                                                        .length ==
                                                    1) {
                                              event = "2";

                                              msg = "transaction delete";
                                              content =
                                                  " Delete Transaction???";
                                            } else if (value
                                                    .historyqty[index].text ==
                                                "0") {
                                              msg = "delete";
                                              event = "1";

                                              content = "Confirm Delete???";
                                            } else {
                                              msg = "update";
                                              event = "0";

                                              content = "Update Quantity???";
                                            }

                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                content: Text(content),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .loginPagetheme),
                                                        onPressed: () async {
                                                          String? df;
                                                          String? tf;
                                                          if (value.fromDate ==
                                                              null) {
                                                            df = todaydate
                                                                .toString();
                                                          } else {
                                                            df = value.fromDate
                                                                .toString();
                                                          }
                                                          if (value.todate ==
                                                              null) {
                                                            tf = todaydate
                                                                .toString();
                                                          } else {
                                                            tf = value.todate
                                                                .toString();
                                                          }

                                                          print("ontap------");
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .editDeleteTransaction(
                                                                  transid,
                                                                  transval,
                                                                  osId,
                                                                  value.transiteminfoList[
                                                                          index]
                                                                      [
                                                                      "item_id"],
                                                                  value
                                                                      .oldhistoryqty[
                                                                          index]
                                                                      .text,
                                                                  value
                                                                      .historyqty[
                                                                          index]
                                                                      .text,
                                                                  msg,
                                                                  event,
                                                                  context,
                                                                  df,
                                                                  tf,
                                                                  index);

                                                          // if (msg ==
                                                          //     "transaction delete") {

                                                          //   Provider.of<Controller>(
                                                          //           context,
                                                          //           listen: false)
                                                          //       .historyData(
                                                          //           context,
                                                          //           transval,
                                                          //           "delete",
                                                          //           df,
                                                          //           tf);
                                                          // }
                                                          if (event == "2") {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Ok"),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.01,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .loginPagetheme),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          textAlign: TextAlign.right,
                                          controller: value.historyqty[index],
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(children: [
                                    Text(
                                      "SRate1 :  ${value.transiteminfoList[index]["s_rate_1"]}",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 17,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Text(
                                      "SRate2 :  ${value.transiteminfoList[index]["s_rate_2"]}",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 17,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ]),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
