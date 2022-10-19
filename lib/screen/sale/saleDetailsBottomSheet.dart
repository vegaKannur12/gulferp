import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/components/customSnackbar.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class SaleDetailsBottomSheet {
  showSheet(
      BuildContext context,
      int index,
      String itemId,
      String catId,
      String batchocde,
      String itemName,
      String itemImg,
      double srate1,
      double stock,
      String qtyf,
      String formType,
      double tax_per,
      double tax_amt,
      double cess_per,
      double cess_amt,
      double disc_per,
      double disc_amt,
      double gross,
      double taxable,
      int gtype,
      String cart_id,
      String page) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    bool unlodVisible = false;
    CustomSnackbar snackbar = CustomSnackbar();
    print(
        "bottom sheet value-----$tax_amt-$index--$itemName----------$srate1----$qtyf-----");
    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Consumer<Controller>(
          builder: (context, value, child) {
            // value.qty[index].text=qty.toString();
            //  print("valusghjh-----${value.fromDb}");
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
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                              backgroundColor: Colors.transparent,

                              // child: Image.network(
                              //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                              //   fit: BoxFit.cover,
                              // ),
                              // child: Image.asset("asset/"),
                            ),
                            //  SizedBox(
                            //   width: size.width * 0.5,
                            // ),

                            // Spacer(),
                            // Text(
                            //       prodName.toString(),
                            //       style: GoogleFonts.aBeeZee(
                            //         textStyle:
                            //             Theme.of(context).textTheme.bodyText2,
                            //         fontSize: 17,
                            //         // fontWeight: FontWeight.bold,
                            //         color: P_Settings.loginPagetheme,
                            //       ),
                            //     ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text("Product Name"),Spacer(),
                                Flexible(
                                  child: Text(
                                    itemName.toString(),
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     IconButton(
                            //         onPressed: () {
                            //           Navigator.pop(context);
                            //         },
                            //         icon: Icon(Icons.close))
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      // Divider(indent: 50, endIndent: 50, thickness: 1.4),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              "Qty ",
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 17,
                                // fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: size.width * 0.2,
                              child: TextField(
                                onTap: () {
                                  value.qty[index].selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset:
                                          value.qty[index].value.text.length);
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                // autofocus: true,
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
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
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                onSubmitted: (values) async {
                                  double valueqty = 0.0;
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .fromDb = false;
                                  if (values.isNotEmpty) {
                                    print("emtyyyy");
                                    valueqty = double.parse(values);
                                  } else {
                                    valueqty = 0.0;
                                  }
                                  // Provider.of<Controller>(context,
                                  //         listen: false)
                                  //     .fromDb = false;

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .rawCalculation(
                                          srate1,
                                          valueqty,
                                          disc_per,
                                          disc_amt,
                                          tax_per,
                                          cess_per,
                                          "0",
                                          gtype,
                                          index,
                                          true,
                                          "qty");
                                  // Provider.of<Controller>(context,
                                  //         listen: false)
                                  //     .(
                                  //         itemId,
                                  //         srate1.toString(),
                                  //         value.qty[index].text,
                                  //         "0",
                                  //         "1",
                                  //         context,
                                  //         "save",
                                  //         formType);
                                  print("values----$values");
                                  // double valueqty = 0.0;
                                  // value.discount_amount[index].text=;
                                  if (values.isNotEmpty) {
                                    print("emtyyyy");
                                    valueqty = double.parse(values);
                                  } else {
                                    valueqty = 0.0;
                                  }
                                },
                                textAlign: TextAlign.right,
                                controller: value.qty[index],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              "SRate",
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
                              '\u{20B9}${srate1.toString()}',
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

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              "Stock",
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
                              '${stock.toString()}',
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
                      // value.qtyerror
                      //     ? Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Container(
                      //           child: Text(
                      //             "Quantity should be less than stock",
                      //             style: TextStyle(color: Colors.red),
                      //           ),
                      //         ),
                      //       )
                      //     : Container(),
                      formType == "3"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Gross value",
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
                                    value.fromDb
                                        ? "\u{20B9}${gross.toStringAsFixed(2)}"
                                        : "\u{20B9}${value.gross.toStringAsFixed(2)}",
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
                      formType == "3"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Discount %",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: size.width * 0.2,
                                    child: TextField(
                                      onTap: () {
                                        value.discount_prercent[index]
                                                .selection =
                                            TextSelection(
                                                baseOffset: 0,
                                                extentOffset: value
                                                    .discount_prercent[index]
                                                    .value
                                                    .text
                                                    .length);
                                      },
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 17,
                                        // fontWeight: FontWeight.bold,
                                        color: P_Settings.loginPagetheme,
                                      ),
                                      decoration: InputDecoration(
                                        //labelText: "Phone number",
                                        // hintText: "Phone number",
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(
                                            0), //  <- you can it to 0.0 for no space

                                        //border: InputBorder.none
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSubmitted: (values) {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .disPerClicked = true;
                                        double valuediscper = 0.0;
                                        print("values---$values");
                                        if (values.isNotEmpty) {
                                          print("emtyyyy");
                                          valuediscper = double.parse(values);
                                        } else {
                                          valuediscper = 0.00;
                                        }
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .fromDb = false;

                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .rawCalculation(
                                                srate1,
                                                double.parse(
                                                    value.qty[index].text),
                                                valuediscper,
                                                double.parse(value
                                                    .discount_amount[index]
                                                    .text),
                                                tax_per,
                                                cess_per,
                                                "0",
                                                gtype,
                                                index,
                                                true,
                                                "disc_per");
                                      },
                                      controller:
                                          value.discount_prercent[index],
                                      textAlign: TextAlign.right,
                                      // decoration: InputDecoration(
                                      //   border: InputBorder.none,
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      formType == "3"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Discount Amount",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: size.width * 0.2,
                                    child: TextField(
                                      onTap: () {
                                        value.discount_amount[index].selection =
                                            TextSelection(
                                                baseOffset: 0,
                                                extentOffset: value
                                                    .discount_amount[index]
                                                    .value
                                                    .text
                                                    .length);
                                      },
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        fontSize: 17,
                                        // fontWeight: FontWeight.bold,
                                        color: P_Settings.loginPagetheme,
                                      ),
                                      decoration: InputDecoration(
                                        //labelText: "Phone number",
                                        // hintText: "Phone number",
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(
                                            0), //  <- you can it to 0.0 for no space

                                        //border: InputBorder.none
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSubmitted: (values) {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .disamtClicked = true;
                                        double valuediscamt = 0.0;
                                        // value.discount_amount[index].text=;
                                        if (values.isNotEmpty) {
                                          print("emtyyyy");
                                          valuediscamt = double.parse(values);
                                        } else {
                                          valuediscamt = 0.0000;
                                        }
                                        // Provider.of<Controller>(context,
                                        //         listen: false)
                                        //     .fromDb = false;

                                        print(
                                            "discount amount..........$valuediscamt");
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .rawCalculation(
                                                srate1,
                                                double.parse(
                                                    value.qty[index].text),
                                                double.parse(value
                                                    .discount_prercent[index]
                                                    .text),
                                                valuediscamt,
                                                tax_per,
                                                cess_per,
                                                "0",
                                                gtype,
                                                index,
                                                true,
                                                "disc_amt");
                                      },
                                      controller: value.discount_amount[index],
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      formType == "3"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Tax %",
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
                                    tax_per.toStringAsFixed(2),
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
                      formType == "3"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Tax amount",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  Spacer(),
                                  value.tax < 0.00
                                      ? Text(
                                          "\u{20B9}0.00",
                                        )
                                      : Text(
                                          "\u{20B9}${value.tax.toStringAsFixed(2)}",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 17,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        )
                                ],
                              ),
                            ),
                      formType == "3"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Cess %",
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
                                    cess_per.toStringAsFixed(2),
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
                      formType == "3"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Cess amount",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  Spacer(),
                                  cess_amt < 0.00
                                      ? Text(
                                          "\u{20B9}0.00",
                                        )
                                      : Text(
                                          "\u{20B9}${value.cess.toStringAsFixed(2)}",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 17,
                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        )
                                ],
                              ),
                            ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(children: [
                          Text(
                            "Net Amount",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                          Spacer(),
                          // net_amt < 0.00
                          //     ? Text("\u{20B9}0.00",
                          //         style: TextStyle(
                          //             color: Colors.red,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 15))
                          //     :
                          Text(
                            // value.fromDb!
                            // ? "\u{20B9}${net_amt.toStringAsFixed(2)}"
                            // :
                            "\u{20B9}${value.net_amt.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ]),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.5,
                            child: ElevatedButton(
                                child: Text(
                                  'Apply',
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: P_Settings.loginPagetheme,
                                    textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  // value.qty[index].text=
                                  if (value.qty[index].text == "1") {
                                    value.qty[index].text = "1.0";
                                  }
                                  value.applyClicked[index] = true;
                                  print(
                                      "quantity after updates..${value.net_amt}...$formType...${value.qty[index].text}");
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .addDeletebagItem(
                                          cart_id,
                                          itemId,
                                          srate1.toString(),
                                          value.qty[index].text,
                                          context,
                                          "save",
                                          formType,
                                          value.gross,
                                          double.parse(value
                                              .discount_prercent[index].text),
                                          double.parse(value
                                              .discount_amount[index].text),
                                          taxable,
                                          value.cgst_amt,
                                          value.sgst_amt,
                                          value.igst_amt,
                                          value.cgst_per,
                                          value.sgst_per,
                                          value.igst_per,
                                          cess_per,
                                          cess_amt,
                                          value.net_amt,
                                          tax_per,
                                          "0",
                                          page);

                                  // Provider.of<Controller>(context,
                                  //         listen: false)
                                  //     .getbagData1(context, formType,);

                                  print(
                                      "quantityyyyyy.....${value.qty[index].text}........");
                                  Navigator.pop(context);
                                }

                                // }

                                ),
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                        ],
                      ),
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
