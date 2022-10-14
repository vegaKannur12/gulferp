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

class BagPage extends StatefulWidget {
  String? branchId;
  String type;
  String form_type;
  String gtype;
  String? remark;
  BagPage(
      {this.branchId,
      required this.type,
      required this.form_type,
      required this.gtype,
      this.remark});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
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
        title: Text(
          "${widget.type.toString()}",
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
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
                      itemExtent: 160,
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
                          double.parse(value.bagList[index]["tax"]),
                          double.parse(value.bagList[index]["cess_per"]),
                          double.parse(value.bagList[index]["cess_amt"]),
                          double.parse(value.bagList[index]["gross"]),
                          double.parse(value.bagList[index]["net_total"]),
                          double.parse(value.bagList[index]["disc_per"]),
                          double.parse(value.bagList[index]["disc_amt"]),
                          double.parse(value.bagList[index]["cgst_amt"]),
                          double.parse(value.bagList[index]["sgst_amt"]),
                          double.parse(value.bagList[index]["igst_amt"]),
                          double.parse(value.bagList[index]["taxable"]),
                          double.parse(value.bagList[index]["cgst_per"]),
                          double.parse(value.bagList[index]["sgst_per"]),
                          double.parse(value.bagList[index]["igst_per"]),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: size.height * 0.07,
                    color: Colors.yellow,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // print(
                            //     "............................${value.orderTotal2}");
                            totalSheet.sheet(
                                context,
                                "${value.item_count}",
                                "${value.net_tot}",
                                "${value.dis_tot}",
                                "${value.tax_total}",
                                "${value.cess_total}",
                                "${value.gro_tot}");
                          },
                          child: Container(
                            width: size.width * 0.5,
                            height: size.height * 0.07,
                            color: Colors.yellow,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  " Sales Total  : ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText2,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: P_Settings.loginPagetheme,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "\u{20B9}${Provider.of<Controller>(context, listen: false).net_tot}",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() async {
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
                          }),
                          child: Container(
                            width: size.width * 0.5,
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
                        )
                      ],
                    ),
                  )
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
      double tax_per,
      double cess_per,
      double cess_amt,
      double gross,
      double net_amt,
      double disc_per,
      double disc_amt,
      double cgst_amt,
      double sgst_amt,
      double igst_amt,
      double taxable,
      double cgst_per,
      double sgst_per,
      double igst_per) {
    print("qty number-----$itemName----------$srate1--------$qty");
    double tax_amt = cgst_amt + sgst_amt + igst_amt;

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
                  print(
                      "qty number-----$cgst_amt--$sgst_amt---$igst_amt--$tax_amt");

                  double gross = srate1 * qty;
                  print("srate1------$srate1---$qty");
                  print("gross calc===$gross");
                  value.qty[index].text = qty.toStringAsFixed(2);

                  value.discount_prercent[index].text =
                      disc_per.toStringAsFixed(4);
                  value.discount_amount[index].text =
                      disc_amt.toStringAsFixed(2);

                  value.qty[index].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: value.qty[index].value.text.length);

                  Provider.of<Controller>(context, listen: false)
                      .rawCalculation(
                          srate1,
                          qty,
                          disc_per,
                          disc_amt,
                          tax_per,
                          cess_per,
                          "0",
                          int.parse(widget.gtype),
                          index,
                          false,
                          "");
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
                      tax_per,
                      tax_amt,
                      cess_per,
                      cess_amt,
                      disc_per,
                      disc_amt,
                      gross,
                      taxable,
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
                          Container(
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
                          SizedBox(
                            width: size.width * 0.05,
                            height: size.height * 0.001,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
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
                                    ],
                                  ),
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

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Discount:",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.03,
                                          ),
                                          Container(
                                            child: Text(
                                              " \u{20B9}${disc_amt.toStringAsFixed(2)}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 0),
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
                                      Row(
                                        children: [
                                          Text(
                                            "Tax  :",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.03,
                                          ),
                                          Container(
                                            child: Text(
                                              " \u{20B9}${tax_amt.toStringAsFixed(2)}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Gross:",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              "\u{20B9}${gross.toStringAsFixed(2)}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Cess :",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              "\u{20B9}${cess_amt.toStringAsFixed(2)}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
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
                                                      value.gross,
                                                      disc_per,
                                                      disc_amt,
                                                      taxable,
                                                      cgst_amt,
                                                      sgst_amt,
                                                      igst_amt,
                                                      cgst_per,
                                                      sgst_per,
                                                      igst_per,
                                                      cess_per,
                                                      cess_amt,
                                                      net_amt,
                                                      tax_per,
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
                            "\u{20B9}${net_amt}",
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

  /////////////////////////////////////buildpoppup////////////////////////////////////
  Widget buildPopupDialog(String content, BuildContext context, Size size) {
    return AlertDialog(content: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text("StockIn"),
              value: "stockin",
              groupValue: stockio,
              onChanged: (value) {
                setState(() {
                  stockio = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("StockOut"),
              value: "stockout",
              groupValue: stockio,
              onChanged: (value) {
                setState(() {
                  stockio = value.toString();
                });
              },
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: P_Settings.loginPagetheme,
                    style: BorderStyle.solid,
                    width: 0.4),
              ),
              child: DropdownButton<String>(
                value: selected,
                // isDense: true,
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Select Branch"),
                ),
                // isExpanded: true,
                autofocus: false,
                underline: SizedBox(),
                elevation: 0,
                items: branch
                    .map((item) => DropdownMenuItem<String>(
                        value: item.toString(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        )))
                    .toList(),
                onChanged: (item) {
                  print("clicked");
                  if (item != null) {
                    setState(() {
                      selected = item;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: P_Settings.loginPagetheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    EasyLoading.show(status: 'Uploading...');

                    EasyLoading.showSuccess("success");
                  },
                  child: Text(
                    "Ok",
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: P_Settings.buttonColor,
                    ),
                  )),
            ),
          ],
        );
      },
    ));
  }
}
