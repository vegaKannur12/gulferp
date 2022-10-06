import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/bag/salesBag.dart';
import 'package:provider/provider.dart';

import '../itemSelectionCommon.dart';

class SaleItemSelection extends StatefulWidget {
  List<Map<String, dynamic>> list;
  String? remark;
  String formType;
  SaleItemSelection({required this.list, this.remark, required this.formType});

  @override
  State<SaleItemSelection> createState() => _SaleItemSelectionState();
}

class _SaleItemSelectionState extends State<SaleItemSelection> {
  List<Map<String, dynamic>> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemList();
  }

  itemList() async {
    list = await Provider.of<Controller>(context, listen: false)
        .getProductDetails("0", "", widget.formType);

    print("listttt----${list}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   // widget.transType.toString(),
        //   style: GoogleFonts.aBeeZee(
        //     textStyle: Theme.of(context).textTheme.bodyText2,
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //     color: P_Settings.buttonColor,
        //   ),
        // ),
        backgroundColor: P_Settings.loginPagetheme,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              animationType: BadgeAnimationType.scale,
              toAnimate: true,
              badgeColor: Colors.white,
              badgeContent: Consumer<Controller>(
                builder: (context, value, child) {
                  if (value.cartCount == null) {
                    return SpinKitChasingDots(
                        color: P_Settings.buttonColor, size: 9);
                  } else {
                    return Text(
                      "${value.cartCount}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
              position: const BadgePosition(start: 33, bottom: 25),
              child: IconButton(
                onPressed: () async {
                  // await Provider.of<Controller>(context, listen: false)
                  //     .getbagData1(context);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) {
                            return BagPage(
                              branchId: "25",
                              type: "Sales Cart",
                              form_type: widget.formType,
                              count:2
                            );
                          }));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => BagPage(
                  //             transVal: widget.transVal,
                  //             transType: widget.transType,
                  //             transId: widget.transId,
                  //             branchId: widget.branchId!,
                  //             remark: widget.remark,
                  //           )),
                  // );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 18.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       Provider.of<Controller>(context, listen: false)
          //           .getbagData(context);
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => BagPage()),
          //       );
          //     },
          //     child: Image.asset(
          //       "asset/shopping-cart.png",
          //       height: size.height * 0.05,
          //       width: size.width * 0.07,
          //     ),
          //   ),
          // ),

          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => BagPage()),
          //     );
          //   },
          //   icon: Icon(Icons.shopping_cart),
          // )
        ],
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isProdLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (list.length > 0) {
              return ItemSelection(
                list: list,
                formType: widget.formType,
                // transVal: widget.transVal,
                // transType: widget.transType,
              );
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
