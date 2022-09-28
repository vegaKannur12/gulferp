import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mystock/components/commonColor.dart';
import 'package:mystock/controller/controller.dart';

import 'package:provider/provider.dart';

class DateFind {
  DateTime currentDate = DateTime.now();
  DateTime defaultDate = DateTime.now();

  // String? formattedDate;
  String? fromDate;
  String? toDate;
  String? crntDateFormat;
  String? specialField;
  String? gen_condition;

  Future selectDateFind(BuildContext context, String dateType) async {
    crntDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(currentDate.year + 1),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light()
                    .copyWith(primary: P_Settings.loginPagetheme),
              ),
              child: child!);
        });
    if (pickedDate != null) {
      // setState(() {
      currentDate = pickedDate;
      // });
    } else {
      print("please select date");
    }

    if (dateType == "from date") {
      print("curnt date----$currentDate");
      fromDate = DateFormat('dd-MM-yyyy').format(currentDate);
      if (toDate == null) {
        toDate = DateFormat('dd-MM-yyyy').format(defaultDate);
      }
    }
    if (dateType == "to date") {
      toDate = DateFormat('dd-MM-yyyy').format(currentDate);
      if (fromDate == null) {
        fromDate = DateFormat('dd-MM-yyyy').format(defaultDate);
      }
    }

    print("fromdate-----$fromDate---$toDate");
    // Provider.of<Controller>(context, listen: false).fromDate=fromDate;
    if (fromDate != null && toDate != null) {
      Provider.of<Controller>(context, listen: false)
          .setDate(fromDate!, toDate!);
    }
    toDate = toDate == null
        ? Provider.of<Controller>(context, listen: false).todate.toString()
        : toDate.toString();
  }
}
