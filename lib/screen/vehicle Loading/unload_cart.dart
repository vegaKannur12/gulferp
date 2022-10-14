import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/components/globalData.dart';
import 'package:gulferp/components/saleTotal_bottomsheet.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/sale/saleDetailsBottomSheet.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UnloadVehicleCart extends StatefulWidget {
  String? branchId;
  String type;
  String form_type;
  String gtype;
  String? remark;
  UnloadVehicleCart(
      {this.branchId,
      required this.type,
      required this.form_type,
      required this.gtype,
      this.remark});

  @override
  State<UnloadVehicleCart> createState() => _UnloadVehicleCartState();
}

class _UnloadVehicleCartState extends State<UnloadVehicleCart> {
  SalesBottomSheet totalSheet = SalesBottomSheet();
  String imgGlobal = Globaldata.imageurl;
  SaleDetailsBottomSheet saleDetais = SaleDetailsBottomSheet();
  String? selected;

  var branch = [
    'branch1',
    'branch2',
  ];
  // CommonPopup popup = CommonPopup();
  String? gender;
  String? stockio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Controller>(context, listen: false)
        .getbagData1(context, widget.form_type, "");
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        // _timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("app bar type...........${widget.form_type}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<Controller>(context, listen: false)
                .getProductDetails("0", "", widget.form_type);

            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        // title: Text(
        //   "${widget.type.toString()}",
        //   style: GoogleFonts.aBeeZee(
        //     textStyle: Theme.of(context).textTheme.bodyText2,
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //     color: P_Settings.buttonColor,
        //   ),
        // ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (value.bagList.length == 0) {
              //  return  Text("knkjzsnjkzdn");
              return Center(
                child: Container(
                    height: size.height * 0.2,
                    child: Lottie.asset(
                      'asset/emptycart.json',
                      // height: size.height*0.3,
                      // width: size.height*0.3,
                    )),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemExtent: 130,
                      itemCount: value.bagList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listItemFunction(
                          value.bagList[index]["item_id"],
                          value.bagList[index]["item_name"],
                          double.parse(value.bagList[index]["s_rate_fix"]),
                          double.parse(value.bagList[index]["qty"]),
                          size,
                          index,
                          value.bagList[index]["batch_code"],
                          double.parse(value.bagList[index]["stock"]),
                          value.bagList[index]["cart_id"],
                          value.bagList[index]["item_img"],
                        );
                      },
                    ),
                  ),
                  Container(
                      height: size.height * 0.07,
                      color: Colors.yellow,
                      child: GestureDetector(
                        onTap: (() async {
                          print("save unload data...");
                          Provider.of<Controller>(context, listen: false)
                              .saveUnloadVehicleDetails(
                                  context, "0", "save", widget.form_type, "0");
                        }),
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.07,
                          color: P_Settings.loginPagetheme,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save",
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.buttonColor,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.01,
                              ),
                              Icon(Icons.shopping_basket)
                            ],
                          ),
                        ),
                      ))
                ],
              );
            }
          }
        },
      ),
    );
  }

  Widget listItemFunction(
    String item_id,
    String itemName,
    double srate1,
    double qty,
    Size size,
    int index,
    String? batch_code,
    double stock,
    String cart_id,
    String img,
  ) {
    double tax_amt = 0;

    print("tax amount new.........$tax_amt");
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Container(
          height: size.height * 0.19,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
            child: Ink(
              // color: Colors.grey[100],
              decoration: BoxDecoration(
                color: Colors.grey[100],
                // borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () {
                  // tax_amt = cgst_amt + sgst_amt + igst_amt;

                  double gross = srate1 * qty;
                  print("srate1------$srate1---$qty");
                  print("gross calc===$gross");
                  value.qty[index].text = qty.toStringAsFixed(2);

                  Provider.of<Controller>(context, listen: false)
                      .rawCalculation(srate1, qty, 0.0, 0.0, 0.0, 0.0, "0",
                          int.parse(widget.gtype), index, false, "");
                  print("quantity in cart..........$qty");
                  Provider.of<Controller>(context, listen: false).setQty(qty);
                  saleDetais.showSheet(
                      context,
                      index,
                      item_id,
                      cart_id,
                      batch_code!,
                      itemName,
                      "",
                      srate1,
                      stock,
                      qty.toString(),
                      widget.form_type,
                      0.0,
                      tax_amt,
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                      gross,
                      0.0,
                      int.parse(widget.gtype),
                      cart_id,
                      "cart");
                },
                title: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: Container(
                              height: size.height * 0.3,
                              width: size.width * 0.2,
                              child: Image.network(
                                "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                fit: BoxFit.fill,
                              ),
                              //  Image.network(
                              //   imgGlobal + img,
                              //   fit: BoxFit.fill,
                              // ),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                            height: size.height * 0.001,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        "${itemName}",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,

                                          // fontWeight: FontWeight.bold,
                                          color: P_Settings.loginPagetheme,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Rate 1:",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 13,
                                              color:
                                                  P_Settings.loginPagetheme,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Text(
                                            "\u{20B9}${srate1.toStringAsFixed(2)}",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  P_Settings.loginPagetheme,
                                            ),
                                          ),
                                        ],
                                      ), // Row(
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Qty     :",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              "${qty.toString()}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
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
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: size.height * 0.022,
                            color: Colors.transparent,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    content: Text(
                                        "Do you want to delete ($itemName) ???"),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    P_Settings.loginPagetheme),
                                            onPressed: () async {
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .addDeletebagItem(
                                                      cart_id,
                                                      item_id,
                                                      srate1.toString(),
                                                      qty.toString(),
                                                      context,
                                                      "delete",
                                                      widget.form_type,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                      "2",
                                                      "cart");

                                              // Navigator.of(ctx).pop();
                                              Navigator.pop(context);
                                              await Provider.of<Controller>(
                                                      context,
                                                      listen: false)
                                                  .getbagData1(
                                                      context,
                                                      widget.form_type,
                                                      "delete");
                                            },
                                            child: Text("Ok"),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    P_Settings.loginPagetheme),
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("Cancel"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.close,
                                size: 15,
                                color: P_Settings.redclr,
                              ),
                              //icon data for elevated button
                              label: Text(
                                "Remove",
                                style:
                                    TextStyle(color: P_Settings.loginPagetheme),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.transparent, // Background color
                              ),
                              //label text
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Total price : ",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 13,
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Text(
                            "\u{20B9}${srate1 * qty.toInt()}",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: P_Settings.redclr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
