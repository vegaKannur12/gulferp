import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/components/globalData.dart';
import 'package:gulferp/components/modalBottomsheet.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BagPage extends StatefulWidget {
  int transVal;
  String transType;
  String transId;
  String? branchId;
  String? remark;
  String? type;

  BagPage({
    required this.transVal,
    required this.transType,
    required this.transId,
    this.branchId,
    this.remark,
    required this.type,
  });

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  String imgGlobal = Globaldata.imageurl;
  Bottomsheet showsheet = Bottomsheet();
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
    // Provider.of<Controller>(context, listen: false).getbagData1(
    //   context,
    // );
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Provider.of<Controller>(context, listen: false)
            //     .getProductDetails("0", "");

            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.type.toString(),
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(builder: (context, value, child) {
        if (value.isLoading) {
          return SpinKitFadingCircle(
            color: P_Settings.loginPagetheme,
          );
        } else {
          // if (value.bagList.length == 0) {
          //   //  return  Text("knkjzsnjkzdn");
          //   return Center(
          //     child: Container(
          //         height: size.height * 0.2,
          //         child: Lottie.asset(
          //           'asset/emptycart.json',
          //           // height: size.height*0.3,
          //           // width: size.height*0.3,
          //         )),
          //   );
          // } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemExtent: 135,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return listItemFunction("1", "Vega Soft", 100, 200, 2, size,
                        index, "c001", 0.0, "", "");
                    // value.bagList[index]["item_id"],
                    // value.bagList[index]["item_name"],
                    // double.parse(value.bagList[index]["s_rate_1"]),
                    // double.parse(value.bagList[index]["s_rate_2"]),
                    // int.parse(value.bagList[index]["qty"]),
                    // size,
                    // index,
                    // value.bagList[index]["batch_code"],
                    // double.parse(value.bagList[index]["stock"]),
                    // value.bagList[index]["cart_id"],
                    // value.bagList[index]["item_img"]);
                  },
                ),
              ),
              Container(
                  height: size.height * 0.05,
                  width: size.width * 0.5,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: P_Settings.loginPagetheme,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2), // <-- Radius
                        ),
                      ),
                      onPressed: () async {
                        // Provider.of<Controller>(context, listen: false)
                        //     .saveCartDetails(
                        //         context,
                        //         widget.transId,
                        //         widget.branchId!,
                        //         widget.remark!,
                        //         "0",
                        //         "0",
                        //         "save");
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.buttonColor,
                        ),
                      ))),
            ],
          );
        }
      }
          // },
          ),
    );
  }

  Widget listItemFunction(
      String item_id,
      String itemName,
      double srate1,
      double srate2,
      int qty,
      Size size,
      int index,
      String? batch_code,
      double stock,
      String cart_id,
      String img) {
    print("qty number-----$itemName----------$srate1----$srate2-----$qty");
    // _controller.text = qty.toString();

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
                  value.qty[index].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: value.qty[index].value.text.length);
                  print("quantity in cart..........$qty");
                  // Provider.of<Controller>(context, listen: false).setQty(qty);
                  // showsheet.showSheet(
                  //     context,
                  //     index,
                  //     item_id,
                  //     cart_id,
                  //     batch_code!,
                  //     itemName,
                  //     "",
                  //     srate1,
                  //     srate2,
                  //     stock,
                  //     0,
                  //     qty.toString(),
                  //     img);
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
                              // child: Image.network(
                              //       imgGlobal +
                              //           value.productList![index]["pi_files"],
                              //     ),
                              // child: Image.network(
                              //   imgGlobal + img,
                              //   fit: BoxFit.fill,
                              // ),
                              color: Colors.grey,
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        child: Text(
                                          "${itemName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,

                                            // fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Rate 1:",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 13,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Text(
                                          "\u{20B9}${srate1.toStringAsFixed(2)}",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        Text(
                                          "Rate 2 :",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 13,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.025,
                                        ),
                                        Container(
                                          child: Text(
                                            "\u{20B9}${srate2.toStringAsFixed(2)}",
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: P_Settings.loginPagetheme,
                                            ),
                                          ),
                                        ),

                                        // Flexible(
                                        //   child:
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Qty :",
                                          style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 13,
                                            color: P_Settings.loginPagetheme,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Container(
                                          child: Text(
                                            qty.toString(),
                                            style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: P_Settings.loginPagetheme,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.045,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.08,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider(
                    //   thickness: 1,
                    //   color: Color.fromARGB(255, 182, 179, 179),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 5),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //         "Total price : ",
                    //         style: TextStyle(fontSize: 13),
                    //       ),
                    //       Flexible(
                    //         child: Text("900",
                    //           // "\u{20B9}${double.parse(totalamount).toStringAsFixed(2)}",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 14,
                    //               color: Color.fromARGB(255, 184, 36, 25)),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                                              // var response = await Provider.of<
                                              //             Controller>(
                                              //         context,
                                              //         listen: false)
                                              //     .addDeletebagItem(
                                              //         item_id,
                                              //         srate1
                                              //             .toString(),
                                              //         srate2
                                              //             .toString(),
                                              //         qty.toString(),
                                              //         "2",
                                              //         cart_id,
                                              //         context,
                                              //         "delete");

                                              // Provider.of<Controller>(
                                              //         context,
                                              //         listen: false)
                                              //     .getbagData1(context);

                                              // Provider.of<Controller>(
                                              //         context,
                                              //         listen: false)
                                              //     .getProductList(
                                              //         widget
                                              //             .custmerId);
                                              // Provider.of<Controller>(
                                              //         context,
                                              //         listen: false)
                                              //     .calculateorderTotal(
                                              //         widget.os,
                                              //         widget
                                              //             .custmerId);
                                              // Provider.of<Controller>(
                                              //         context,
                                              //         listen: false)
                                              //     .countFromTable(
                                              //   "orderBagTable",
                                              //   widget.os,
                                              //   widget.custmerId,
                                              // );
                                              Navigator.of(ctx).pop();
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
                          Flexible(
                              child: Text(
                            "\u{20B9}${srate1.toStringAsFixed(2)}",
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: P_Settings.redclr,
                            ),
                          )),
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
