import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';

import 'package:provider/provider.dart';

class SalesBottomSheet {
  sheet(BuildContext context, String itemcount, String netAmt, String discount,
      String tax, String cess,String grosstot) {
    Size size = MediaQuery.of(context).size;
    // double total = roundoff + double.parse(netAmt);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          print("order total.........$grosstot..$netAmt");
          return SingleChildScrollView(
            child: Container(
              // height: size.height * 0.9,
              child: Column(
                children: [
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
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        ListTile(
                          // leading: Icon(
                          //   Icons.numbers,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Item count : ',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '$itemcount',
                                textAlign: TextAlign.end,
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
                        ListTile(
                          // leading: Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text(
                                'Gross total : ',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\u{20B9}${grosstot}',
                                textAlign: TextAlign.end,
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
                        ListTile(
                          // leading: Icon(
                          //   Icons.discount,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text(
                                'Discount : ',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\u{20B9} ${discount}',
                                textAlign: TextAlign.end,
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
                        ListTile(
                          // leading: Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text(
                                'Tax : ',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\u{20B9}$tax',
                                textAlign: TextAlign.end,
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
                         ListTile(
                          // leading: Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text(
                                'Cess : ',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\u{20B9}$cess',
                                textAlign: TextAlign.end,
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
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          // leading: new Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text(
                                'Net amount : ',
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                              Spacer(),
                              Text(
                                
                                '\u{20B9}${netAmt}',
                                style: TextStyle(
                                    color: P_Settings.redclr,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
