import 'package:flutter/material.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertCommon {
  Future buildPopupDialog(BuildContext context, Size size, List splitted,
      int index, String todaydate, String form_type) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            content: Text("Do you want to delete???"),
            actions: <Widget>[
              Consumer<Controller>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: P_Settings.loginPagetheme),
                        onPressed: () async {
                          print("heloooooooooooooooo");
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          String? user_id = prefs.getString("user_id");

                          Provider.of<Controller>(context, listen: false)
                              .saveCartDetails(
                                  ctx,
                                  "",
                                  "2",
                                  value.historyList[index]['s_invoice_id'],
                                  "delete",
                                  form_type,
                                  "",
                                  value.historyList[index]['Customer Name'],
                                  "0",
                                  "0",
                                  "0",
                                  "0",
                                  "0",
                                  "0",
                                  "0",
                                  "0",
                                  "0",
                                  "0","","","");
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

                          //////////////////////////////////////////////////

                          await Provider.of<Controller>(context, listen: false)
                              .historyData(context, "delete", df, tf,form_type);

                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: P_Settings.loginPagetheme),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}
