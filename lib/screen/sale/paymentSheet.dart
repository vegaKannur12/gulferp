import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';

import 'package:provider/provider.dart';

class PaymentBottomSheet {
  // TextEditingController searchcontroller = TextEditingController();
  TextEditingController payblecontroller = TextEditingController();
  String? oldText;
  String? selected;
  List paymentOptions = [
    {"id": "1", "value": "cash"},
    {"id": "2", "value": "credit"},
    {"id": "3", "value": "part payment"}
  ];
  showpaymentSheet(BuildContext context, Size size, String formType,String? remark) {
    // searchcontroller.text = "";
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // String imgGlobal = Globaldata.imageurl;
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();

            return Container(
              // height: size.height * 0.6,
              child: SingleChildScrollView(
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
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Payment Details",
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
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sale Total",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme),
                              ),
                              Text(
                                "\u{20B9}${value.net_tot}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Mode",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme),
                              ),
                              Flexible(
                                child: Container(
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: P_Settings.loginPagetheme,
                                        style: BorderStyle.solid,
                                        width: 0.3),
                                  ),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selected,
                                    // value: selected,
                                    // isDense: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(value.paymentMode == null
                                          ? "select"
                                          : value.paymentMode.toString()),
                                    ),
                                    // isExpanded: true,
                                    autofocus: false,
                                    underline: SizedBox(),
                                    elevation: 0,
                                    items: paymentOptions
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item["id"],
                                            child: Container(
                                              width: size.width * 0.9,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item["value"].toString(),
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            )))
                                        .toList(),
                                    onChanged: (item) {
                                      print("clicked--$item");
                                      if (item != null) {
                                        selected = item;
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .setPaymentMode(
                                                selected!, value.net_tot!);

                                        // splitted = selected!.split(',');

                                        // Provider.of<Controller>(context, listen: false)
                                        //     .filterProduct(selected!);
                                        print("se;ected---$item");
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payable",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme),
                              ),
                              value.partPaymentClicked
                                  ? Container(
                                      width: size.width * 0.2,
                                      child: TextField(
                                        onTap: () {
                                          payblecontroller.selection =
                                              TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: payblecontroller
                                                      .value.text.length);
                                        },
                                        style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 18,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                        controller: payblecontroller,
                                        textAlign: TextAlign.end,
                                        onSubmitted: (values) {
                                          value.balance = value.net_tot! -
                                              double.parse(
                                                  payblecontroller.text);
                                        },
                                      ),
                                    )
                                  : Text(
                                      value.payable == null
                                          ? "\u{20B9}${0}"
                                          : "\u{20B9}${value.payable}",
                                      style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 18,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Balance",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme),
                              ),
                              Text(
                                value.balance == null
                                    ? "\u{20B9}${0}"
                                    : "\u{20B9}${value.balance!.toStringAsFixed(2)}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 18.0,
                            right: 18.0,
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * 0.4,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: P_Settings.loginPagetheme),
                                    onPressed: () {
                                      Provider.of<Controller>(context,
                                                listen: false)
                                            .saveCartDetails(
                                                context,
                                                remark!,
                                                "0",
                                                "0",
                                                "save",
                                                formType,
                                                value.cus_id!,
                                                value.cusName1!,
                                                "0",
                                                value.dis_tot.toString(),
                                                value.cess_total.toString(),
                                                value.net_tot.toString(),
                                                "0",
                                                value.cgst_total.toString(),
                                                value.sgst_total.toString(),
                                                value.igst_total.toString(),
                                                value.taxable_total.toString(),
                                                value.total_qty.toString());
                                    },
                                    child: Text(
                                      "Apply",
                                      style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 18,
                                          // fontWeight: FontWeight.bold,
                                          color: P_Settings.buttonColor),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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
