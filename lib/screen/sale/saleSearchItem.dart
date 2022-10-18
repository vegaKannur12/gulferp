import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/sale/searchSheet.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SaleSearchItem extends StatefulWidget {
  String form_type;
  String? remark;
  String? gtype;
  SaleSearchItem(
      {required this.form_type, required this.remark, required this.gtype});

  @override
  State<SaleSearchItem> createState() => _SaleSearchItemState();
}

class _SaleSearchItemState extends State<SaleSearchItem> {
  ValueNotifier<bool> visible = ValueNotifier(false);
  String? oldText;
  SearchBottomSheet searchSheet = SearchBottomSheet();

  @override
  Widget build(BuildContext context) {
    String? selectedtransaction;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // shape: shape,
        color: P_Settings.loginPagetheme,
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext ctx) {
                  return new AlertDialog(
                    content: Text("Do you want to save ???"),
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
                                  widget.form_type == "1"
                                      ? Provider.of<Controller>(context,
                                              listen: false)
                                          .saveCartDetails(
                                              context,
                                              widget.remark!,
                                              "0",
                                              "0",
                                              "save",
                                              widget.form_type,
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
                                              value.total_qty.toString())
                                      : Provider.of<Controller>(context,
                                              listen: false)
                                          .saveSaleReturnCartDetails(
                                              context,
                                              widget.remark!,
                                              "0",
                                              "0",
                                              "save",
                                              widget.form_type,
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
                                  // Navigator.of(ctx).pop();
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
          },
          child: Container(
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Save",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: P_Settings.buttonColor,
                  ),
                )
                // if (centerLocations.contains(fabLocation)) const Spacer(),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: SingleChildScrollView(child: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Card(
                  elevation: 12,
                  child: ListTile(
                    tileColor: Colors.green[100],
                    onTap: () {
                      value.searchList.clear();
                      value.searchcontroller.clear();
                      searchSheet.showsearchSheet(
                          context, size, widget.form_type, widget.gtype!);
                    },
                    title: Text(
                      "Search item here",
                      style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: P_Settings.loginPagetheme),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 10,
                        child: Icon(
                          Icons.search,
                          color: P_Settings.loginPagetheme,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                height: size.height * 0.9,
                child: value.isLoading
                    ? SpinKitFadingCircle(
                        color: P_Settings.loginPagetheme,
                      )
                    : value.bagList.length == 0
                        ? Container(
                            // height: size.height * 0.2,
                            child: Lottie.asset(
                            'asset/emptycart.json',
                            height: size.height * 0.2,
                            width: size.height * 0.2,
                          ))
                        : ListView.builder(
                            itemExtent: 80,
                            itemCount: value.bagList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  color: Colors.grey[100],
                                  child: ListTile(
                                    title: Text(
                                      value.bagList[index]["item_name"],
                                      style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold,
                                          color: P_Settings.loginPagetheme),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "SRate :\u{20B9}${value.bagList[index]["s_rate_fix"]}",
                                                style: GoogleFonts.aBeeZee(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                  fontSize: 14,
                                                  color: P_Settings.bagText,
                                                ),
                                              ),
                                              // SizedBox(width: size.width * 0.032),
                                              Text(
                                                "Stock :\u{20B9}${value.bagList[index]["s_rate_fix"]}",
                                                style: GoogleFonts.aBeeZee(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                  fontSize: 14,
                                                  color: P_Settings.bagText,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        Container(
                                          width: size.width * 0.12,
                                          child: FocusScope(
                                            child: TextField(
                                              // controller: value
                                              //     .t2qtycontroller[index],
                                              // autofocus: true,
                                              onTap: () {
                                                // value.t2qtycontroller[index]
                                                //         .selection =
                                                //     TextSelection(
                                                //         baseOffset: 0,
                                                //         extentOffset: value
                                                //             .t2qtycontroller[
                                                //                 index]
                                                //             .value
                                                //             .text
                                                //             .length);
                                              },

                                              // autofocus: true,
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 17,
                                                // fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.loginPagetheme,
                                              ),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                //border: InputBorder.none
                                              ),

                                              // maxLines: 1,
                                              // minLines: 1,
                                              keyboardType:
                                                  TextInputType.number,
                                              onSubmitted: (values) {
                                                double valueqty = 0.0;
                                                // Provider.of<Controller>(
                                                //         context,
                                                //         listen: false)
                                                //     .addDeletebagItem(
                                                //         value.bagList[index]
                                                //             ["item_id"],
                                                //         value.bagList[index]
                                                //                 ["s_rate_1"]
                                                //             .toString(),
                                                //         value.bagList[index]
                                                //                 ["s_rate_2"]
                                                //             .toString(),
                                                //         value
                                                //             .t2qtycontroller[
                                                //                 index]
                                                //             .text,
                                                //         "0",
                                                //         "0",
                                                //         context,
                                                //         "save",
                                                //         "transaction2");
                                              },

                                              textAlign: TextAlign.right,
                                              // controller: value.qty[index],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 28.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  content: Text(
                                                      "Do you want to delete (${value.bagList[index]["item_name"]}) ???"),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      P_Settings
                                                                          .loginPagetheme),
                                                          onPressed: () async {
                                                            var response = Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                "",
                                                                value.bagList[index]
                                                                    ['item_id'],
                                                                value.bagList[index]
                                                                    ['rate'],
                                                                value.bagList[index]
                                                                    ['qty'],
                                                                context,
                                                                "delete",
                                                                widget
                                                                    .form_type,
                                                                value.gross,
                                                                value.bagList[
                                                                        index][
                                                                    'disc_per'],
                                                                value.bagList[
                                                                        index][
                                                                    'disc_amt'],
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                0.0,
                                                                value.bagList[
                                                                        index]
                                                                    ['net_total'],
                                                                0.0,
                                                                "2",
                                                                "cart");

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
                                                                  primary:
                                                                      P_Settings
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
                                            child: Icon(
                                              Icons.delete,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      )),
    );
  }
}
