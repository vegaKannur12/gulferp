import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/components/customSnackbar.dart';
import 'package:gulferp/controller/controller.dart';

import 'package:provider/provider.dart';

class Bottomsheet {
  showSheet(
      BuildContext context,
      double taxable,
      double cgst_amt,
      double sgst_amt,
      double igst_amt,
      double cgst_per,
      double sgst_per,
      double igst_per,
      double net_tot,
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
      double cess_per,
      double cess_amt,
      double disc_per,
      double disc_amt,
      double gross) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    CustomSnackbar snackbar = CustomSnackbar();
    print(
        "bottom sheet value--$index--$itemName----------$srate1----$qtyf-----");
    // CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
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
                                autofocus: true,
                                onTap: () {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .addDeletebagItem(
                                          itemId,
                                          srate1.toString(),
                                          value.qty[index].text,
                                          context,
                                          "save",
                                          formType,
                                          gross,
                                          disc_per,
                                          disc_amt,
                                          taxable,
                                          cgst_amt,
                                          cgst_per,
                                          sgst_amt,
                                          sgst_per,
                                          igst_amt,
                                          igst_per,
                                          net_tot);

                                  print(
                                      "quantity......${value.qty[index].text}");
                                  value.qty[index].selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset:
                                          value.qty[index].value.text.length);
                                },

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
                                keyboardType: TextInputType.number,
                                onSubmitted: (values) {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .addDeletebagItem(
                                          itemId,
                                          srate1.toString(),
                                          value.qty[index].text,
                                          context,
                                          "save",
                                          formType,
                                          gross,
                                          disc_per,
                                          disc_amt,
                                          taxable,
                                          cgst_amt,
                                          cgst_per,
                                          sgst_amt,
                                          sgst_per,
                                          igst_amt,
                                          igst_per,
                                          net_tot);
                                  print("values----$values");
                                  double valueqty = 0.0;
                                  // value.discount_amount[index].text=;
                                  if (values.isNotEmpty) {
                                    print("emtyyyy");
                                    valueqty = double.parse(values);
                                  } else {
                                    valueqty = 0.00;
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
                                  // value.setApplyClicked(true, index);
                                  double qty =
                                      double.parse(value.qty[index].text);
                                  // Provider.of<Controller>(context, listen: false).rawCalculation(srate1, qty, 0, 0, tax_per, cess_per, method, state_status, index, onSub, disCalc)
                                  // if (transval == -1) {
                                  //   if (stock < qty) {
                                  //     print("error");
                                  //     value.qty[index].text = qtyf;
                                  //     value.seterrorClicked(true, index);
                                  //     value.setqtyErrormsg(true);
                                  //   } else {
                                  //     value.setqtyErrormsg(false);
                                  //   }
                                  // }
                                  // print("value.qtyerror ----${value.qtyerror}");

                                  // if (value.qtyerror == false) {

                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .addDeletebagItem(
                                          itemId,
                                          srate1.toString(),
                                          value.qty[index].text,
                                          context,
                                          "save",
                                          formType,
                                          gross,
                                          disc_per,
                                          disc_amt,
                                          taxable,
                                          cgst_amt,
                                          cgst_per,
                                          sgst_amt,
                                          sgst_per,
                                          igst_amt,
                                          igst_per,
                                          net_tot);
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getbagData1(context, formType);
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
