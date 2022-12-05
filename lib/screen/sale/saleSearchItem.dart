import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/history/history.dart';
import 'package:gulferp/screen/sale/paymentSheet.dart';
import 'package:gulferp/screen/sale/searchSheet.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController naration = TextEditingController();
  ValueNotifier<bool> visible = ValueNotifier(false);
  String? todaydate;
  PaymentBottomSheet paymentBottomSheet = PaymentBottomSheet();
  DateTime now = DateTime.now();

  String? oldText;
  SearchBottomSheet searchSheet = SearchBottomSheet();
  String? branch_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;

    String? selectedtransaction;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // shape: shape,
        color: P_Settings.loginPagetheme,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: P_Settings.loginPagetheme, // background
          ),
          onPressed: () {
            if (widget.form_type == "1") {
              Provider.of<Controller>(context, listen: false)
                  .setInitialValFrPaymentSheet();
              Provider.of<Controller>(context, listen: false)
                  .partPaymentClicked = false;
              if (Provider.of<Controller>(context, listen: false)
                      .bagList
                      .length >
                  0) {
                paymentBottomSheet.showpaymentSheet(
                    context, size, widget.form_type, widget.remark);
              }
            } else {
              Provider.of<Controller>(context, listen: false).bagList.length ==
                      0
                  ? null
                  : showDialog(
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
                                        print(
                                            "widget.form_type ----${widget.form_type}");

                                        // widget.form_type == "1"
                                        //     ? Provider.of<Controller>(context,
                                        //             listen: false)
                                        //         .saveCartDetails(
                                        //             context,
                                        //             widget.remark!,
                                        //             "0",
                                        //             "0",
                                        //             "save",
                                        //             widget.form_type,
                                        //             value.cus_id!,
                                        //             value.cusName1!,
                                        //             "0",
                                        //             value.dis_tot.toString(),
                                        //             value.cess_total.toString(),
                                        //             value.net_tot.toString(),
                                        //             "0",
                                        //             value.cgst_total.toString(),
                                        //             value.sgst_total.toString(),
                                        //             value.igst_total.toString(),
                                        //             value.taxable_total
                                        //                 .toString(),
                                        //             value.total_qty.toString(),
                                        //             value.paymentMode.toString(),
                                        //             value.payable.toString(),
                                        //             value.balance.toString())
                                        //     :
                                        widget.form_type == "2"
                                            ? Provider.of<Controller>(context,
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
                                                    value.taxable_total
                                                        .toString(),
                                                    value.total_qty.toString())
                                            : Provider.of<Controller>(context,
                                                    listen: false)
                                                .saveUnloadVehicleDetails(
                                                    context,
                                                    "0",
                                                    "save",
                                                    widget.form_type,
                                                    "0",naration.text);

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
            }
          },
          child: Text(
            'Save',
            style: GoogleFonts.aBeeZee(
              textStyle: Theme.of(context).textTheme.bodyText2,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: P_Settings.buttonColor,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        actions: [
          widget.form_type == "3"
              ? IconButton(
                  onPressed: () {
                    Provider.of<Controller>(context, listen: false)
                        .unloadhistoryList
                        .clear();
                    Provider.of<Controller>(context, listen: false)
                        .setDate(todaydate!, todaydate!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryPage(
                                form_type: widget.form_type,
                              )),
                    );
                  },
                  icon: Container(
                    height: 20,
                    child: Image.asset("asset/history.png"),
                  ),
                )
              : Text(""),
        ],
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              widget.form_type == "3"
                  ? Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Container(
                      width: size.height * 0.46,
                      child: TextFormField(
                        controller: naration,
                        scrollPadding: EdgeInsets.only(
                            bottom: topInsets + size.height * 0.34),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.note,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                            // hintText: "Naration",
                            labelText: 'Remarks',
                            labelStyle: TextStyle(color: P_Settings.bagText)),
                      ),
                    ),
                  )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Card(
                  elevation: 12,
                  child: ListTile(
                    tileColor: Colors.grey[200],
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
              Expanded(
                // height: size.height * 0.7,
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
                            // itemExtent: 100,
                            itemCount: value.bagList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Card(
                                  color: Colors.grey[100],
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "${value.bagList[index]["item_name"]}",
                                            style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    P_Settings.loginPagetheme),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "SRate :\u{20B9}${value.bagList[index]["actual_rate"]}",
                                                    style: GoogleFonts.aBeeZee(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText2,
                                                      fontSize: 14,
                                                      color: P_Settings.bagText,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Stock :${value.bagList[index]["stock"]}",
                                                    style: GoogleFonts.aBeeZee(
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText2,
                                                      fontSize: 14,
                                                      color: P_Settings.bagText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Spacer(),
                                              Column(
                                                // crossAxisAlignment: CrossAxisAlignment.end,
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Qty   :",
                                                        style:
                                                            GoogleFonts.aBeeZee(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                          fontSize: 14,
                                                          color: P_Settings
                                                              .bagText,
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            size.width * 0.15,
                                                        child: FocusScope(
                                                          child: TextField(
                                                            controller: value
                                                                .qty[index],
                                                            // autofocus: true,
                                                            onTap: () {
                                                              value.qty[index]
                                                                      .selection =
                                                                  TextSelection(
                                                                      baseOffset:
                                                                          0,
                                                                      extentOffset: value
                                                                          .qty[
                                                                              index]
                                                                          .value
                                                                          .text
                                                                          .length);
                                                            },

                                                            // autofocus: true,
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                              fontSize: 17,
                                                              // fontWeight: FontWeight.bold,
                                                              color: P_Settings
                                                                  .loginPagetheme,
                                                            ),
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              //border: InputBorder.none
                                                            ),

                                                            // maxLines: 1,
                                                            // minLines: 1,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            onSubmitted:
                                                                (values) {
                                                              double valueqty =
                                                                  0.0;
                                                              Provider.of<Controller>(context, listen: false).rawCalculation(
                                                                  double.parse(value
                                                                      .rateList[
                                                                          index]
                                                                      .text),
                                                                  double.parse(value
                                                                      .qty[
                                                                          index]
                                                                      .text),
                                                                  double.parse(value
                                                                      .discount_prercent[
                                                                          index]
                                                                      .text),
                                                                  double.parse(value
                                                                      .discount_amount[
                                                                          index]
                                                                      .text),
                                                                  double.parse(value
                                                                          .bagList[index]
                                                                      ["tax"]),
                                                                  double.parse(value
                                                                          .bagList[index]
                                                                      ["cess_per"]),
                                                                  "0",
                                                                  int.parse(widget.gtype!),
                                                                  index,
                                                                  false,
                                                                  "qty");

                                                              Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                  "0",
                                                                  value.bagList[index][
                                                                      "item_id"],
                                                                  value.bagList[index][
                                                                      "actual_rate"],
                                                                  value.rateList[index].text
                                                                      .toString(),
                                                                  value
                                                                      .qty[
                                                                          index]
                                                                      .text,
                                                                  context,
                                                                  "save",
                                                                  widget
                                                                      .form_type,
                                                                  value.gross,
                                                                  double.parse(value
                                                                      .discount_prercent[
                                                                          index]
                                                                      .text),
                                                                  double.parse(value
                                                                      .discount_amount[
                                                                          index]
                                                                      .text),
                                                                  double.parse(value
                                                                          .bagList[index]
                                                                      ["taxable"]),
                                                                  value.cgst_amt,
                                                                  value.sgst_amt,
                                                                  value.igst_amt,
                                                                  value.cgst_per,
                                                                  value.sgst_per,
                                                                  value.igst_per,
                                                                  double.parse(value.bagList[index]["cess_per"]),
                                                                  double.parse(value.bagList[index]["cess_amt"]),
                                                                  value.net_amt,
                                                                  double.parse(value.bagList[index]["tax"]),
                                                                  "0",
                                                                  "cart");
                                                            },

                                                            textAlign:
                                                                TextAlign.right,
                                                            // controller: value.qty[index],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  widget.form_type == "1"
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              "Rate :",
                                                              style: GoogleFonts
                                                                  .aBeeZee(
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                                fontSize: 14,
                                                                color: P_Settings
                                                                    .bagText,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.15,
                                                              child: FocusScope(
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      value.rateList[
                                                                          index],
                                                                  // autofocus: true,
                                                                  onTap: () {
                                                                    value.rateList[index].selection = TextSelection(
                                                                        baseOffset:
                                                                            0,
                                                                        extentOffset: value
                                                                            .rateList[index]
                                                                            .value
                                                                            .text
                                                                            .length);
                                                                  },

                                                                  // autofocus: true,
                                                                  style: GoogleFonts
                                                                      .aBeeZee(
                                                                    textStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2,
                                                                    fontSize:
                                                                        17,
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: P_Settings
                                                                        .loginPagetheme,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .all(0),
                                                                    //border: InputBorder.none
                                                                  ),

                                                                  // maxLines: 1,
                                                                  // minLines: 1,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  onSubmitted:
                                                                      (values) {
                                                                    double
                                                                        valueqty =
                                                                        0.0;
                                                                    Provider.of<Controller>(context, listen: false).rawCalculation(
                                                                        double.parse(value
                                                                            .rateList[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .qty[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .discount_prercent[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .discount_amount[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value.bagList[index][
                                                                            "tax"]),
                                                                        double.parse(value.bagList[index][
                                                                            "cess_per"]),
                                                                        "0",
                                                                        int.parse(
                                                                            widget.gtype!),
                                                                        index,
                                                                        false,
                                                                        "rate");

                                                                    Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                        "0",
                                                                        value.bagList[index][
                                                                            "item_id"],
                                                                        value.bagList[index]
                                                                            [
                                                                            "actual_rate"],
                                                                        value
                                                                            .rateList[
                                                                                index]
                                                                            .text
                                                                            .toString(),
                                                                        value
                                                                            .qty[
                                                                                index]
                                                                            .text,
                                                                        context,
                                                                        "save",
                                                                        widget
                                                                            .form_type,
                                                                        value
                                                                            .gross,
                                                                        double.parse(value
                                                                            .discount_prercent[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .discount_amount[
                                                                                index]
                                                                            .text),
                                                                        double.parse(
                                                                            value.bagList[index]["taxable"]),
                                                                        value.cgst_amt,
                                                                        value.sgst_amt,
                                                                        value.igst_amt,
                                                                        value.cgst_per,
                                                                        value.sgst_per,
                                                                        value.igst_per,
                                                                        double.parse(value.bagList[index]["cess_per"]),
                                                                        double.parse(value.bagList[index]["cess_amt"]),
                                                                        value.net_amt,
                                                                        double.parse(value.bagList[index]["tax"]),
                                                                        "0",
                                                                        "cart");
                                                                  },

                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  // controller: value.qty[index],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  widget.form_type == "3"
                                                      ? Container()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "Disc  :",
                                                              style: GoogleFonts
                                                                  .aBeeZee(
                                                                textStyle: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                                fontSize: 14,
                                                                color: P_Settings
                                                                    .bagText,
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.15,
                                                              child: FocusScope(
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      value.discount_amount[
                                                                          index],
                                                                  // autofocus: true,
                                                                  onTap: () {
                                                                    value.discount_amount[index].selection = TextSelection(
                                                                        baseOffset:
                                                                            0,
                                                                        extentOffset: value
                                                                            .discount_amount[index]
                                                                            .value
                                                                            .text
                                                                            .length);
                                                                  },

                                                                  // autofocus: true,
                                                                  style: GoogleFonts
                                                                      .aBeeZee(
                                                                    textStyle: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2,
                                                                    fontSize:
                                                                        17,
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: P_Settings
                                                                        .loginPagetheme,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .all(0),
                                                                    //border: InputBorder.none
                                                                  ),

                                                                  // maxLines: 1,
                                                                  // minLines: 1,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  onSubmitted:
                                                                      (values) {
                                                                    Provider.of<Controller>(context, listen: false).rawCalculation(
                                                                        double.parse(value
                                                                            .rateList[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .qty[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .discount_prercent[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .discount_amount[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value.bagList[index][
                                                                            "tax"]),
                                                                        double.parse(value.bagList[index][
                                                                            "cess_per"]),
                                                                        "0",
                                                                        int.parse(
                                                                            widget.gtype!),
                                                                        index,
                                                                        false,
                                                                        "disc_amt");

                                                                    Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                        "0",
                                                                        value.bagList[index][
                                                                            "item_id"],
                                                                        value.bagList[index]
                                                                            [
                                                                            "actual_rate"],
                                                                        value
                                                                            .rateList[
                                                                                index]
                                                                            .text
                                                                            .toString(),
                                                                        value
                                                                            .qty[
                                                                                index]
                                                                            .text,
                                                                        context,
                                                                        "save",
                                                                        widget
                                                                            .form_type,
                                                                        value
                                                                            .gross,
                                                                        double.parse(value
                                                                            .discount_prercent[
                                                                                index]
                                                                            .text),
                                                                        double.parse(value
                                                                            .discount_amount[
                                                                                index]
                                                                            .text),
                                                                        double.parse(
                                                                            value.bagList[index]["taxable"]),
                                                                        value.cgst_amt,
                                                                        value.sgst_amt,
                                                                        value.igst_amt,
                                                                        value.cgst_per,
                                                                        value.sgst_per,
                                                                        value.igst_per,
                                                                        double.parse(value.bagList[index]["cess_per"]),
                                                                        double.parse(value.bagList[index]["cess_amt"]),
                                                                        value.net_amt,
                                                                        double.parse(value.bagList[index]["tax"]),
                                                                        "0",
                                                                        "cart");
                                                                  },

                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  // controller: value.qty[index],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  // SizedBox(
                                                  //   height: size.height * 0.01,
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.end,
                                                  //   children: [
                                                  //     Text(
                                                  //       "Disc per : ",
                                                  //       style:
                                                  //           GoogleFonts.aBeeZee(
                                                  //         textStyle:
                                                  //             Theme.of(context)
                                                  //                 .textTheme
                                                  //                 .bodyText2,
                                                  //         fontSize: 14,
                                                  //         color: P_Settings
                                                  //             .bagText,
                                                  //       ),
                                                  //     ),
                                                  //     Container(
                                                  //       width:
                                                  //           size.width * 0.12,
                                                  //       child: FocusScope(
                                                  //         child: TextField(
                                                  //           controller: value
                                                  //                   .discount_prercent[
                                                  //               index],
                                                  //           // autofocus: true,
                                                  //           onTap: () {
                                                  //             value
                                                  //                     .discount_prercent[
                                                  //                         index]
                                                  //                     .selection =
                                                  //                 TextSelection(
                                                  //                     baseOffset:
                                                  //                         0,
                                                  //                     extentOffset: value
                                                  //                         .discount_prercent[
                                                  //                             index]
                                                  //                         .value
                                                  //                         .text
                                                  //                         .length);
                                                  //           },

                                                  //           // autofocus: true,
                                                  //           style: GoogleFonts
                                                  //               .aBeeZee(
                                                  //             textStyle: Theme.of(
                                                  //                     context)
                                                  //                 .textTheme
                                                  //                 .bodyText2,
                                                  //             fontSize: 17,
                                                  //             // fontWeight: FontWeight.bold,
                                                  //             color: P_Settings
                                                  //                 .loginPagetheme,
                                                  //           ),
                                                  //           decoration:
                                                  //               InputDecoration(
                                                  //             isDense: true,
                                                  //             contentPadding:
                                                  //                 EdgeInsets
                                                  //                     .all(0),
                                                  //             //border: InputBorder.none
                                                  //           ),

                                                  //           // maxLines: 1,
                                                  //           // minLines: 1,
                                                  //           keyboardType:
                                                  //               TextInputType
                                                  //                   .number,
                                                  //           onSubmitted:
                                                  //               (values) {
                                                  //             Provider.of<Controller>(
                                                  //                     context,
                                                  //                     listen:
                                                  //                         false)
                                                  //                 .rawCalculation(
                                                  //                     double
                                                  //                         .parse(
                                                  //                       value.bagList[index]
                                                  //                           [
                                                  //                           "s_rate_fix"],
                                                  //                     ),
                                                  //                     double.parse(value
                                                  //                         .qty[
                                                  //                             index]
                                                  //                         .text),
                                                  //                     double.parse(value
                                                  //                         .discount_prercent[
                                                  //                             index]
                                                  //                         .text),
                                                  //                     double.parse(value
                                                  //                         .discount_amount[
                                                  //                             index]
                                                  //                         .text),
                                                  //                     double.parse(
                                                  //                         value.bagList[index]
                                                  //                             [
                                                  //                             "tax"]),
                                                  //                     double.parse(
                                                  //                         value.bagList[index]
                                                  //                             ["cess_per"]),
                                                  //                     "0",
                                                  //                     int.parse(widget.gtype!),
                                                  //                     index,
                                                  //                     false,
                                                  //                     "disc_per");

                                                  //             Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                  //                 "0",
                                                  //                 value.bagList[index][
                                                  //                     "item_id"],
                                                  //                 value.bagList[index][
                                                  //                         "s_rate_fix"]
                                                  //                     .toString(),
                                                  //                 value
                                                  //                     .qty[
                                                  //                         index]
                                                  //                     .text,
                                                  //                 context,
                                                  //                 "save",
                                                  //                 widget
                                                  //                     .form_type,
                                                  //                 value.gross,
                                                  //                 double.parse(value
                                                  //                     .discount_prercent[
                                                  //                         index]
                                                  //                     .text),
                                                  //                 double.parse(value
                                                  //                     .discount_amount[
                                                  //                         index]
                                                  //                     .text),
                                                  //                 double.parse(
                                                  //                     value.bagList[index]
                                                  //                         ["taxable"]),
                                                  //                 value.cgst_amt,
                                                  //                 value.sgst_amt,
                                                  //                 value.igst_amt,
                                                  //                 value.cgst_per,
                                                  //                 value.sgst_per,
                                                  //                 value.igst_per,
                                                  //                 double.parse(value.bagList[index]["cess_per"]),
                                                  //                 double.parse(value.bagList[index]["cess_amt"]),
                                                  //                 value.net_amt,
                                                  //                 double.parse(value.bagList[index]["tax"]),
                                                  //                 "0",
                                                  //                 "cart");
                                                  //           },

                                                  //           textAlign:
                                                  //               TextAlign.right,
                                                  //           // controller: value.qty[index],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        // Row(children: [Text("dzkshfjkzdjk")],),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    content: Text(
                                                        "Do you want to delete (${value.bagList[index]["item_name"]}) ???"),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        P_Settings
                                                                            .loginPagetheme),
                                                            onPressed:
                                                                () async {
                                                              var response = Provider.of<Controller>(context, listen: false).addDeletebagItem(
                                                                  value.bagList[index][
                                                                      "cart_id"],
                                                                  value.bagList[index][
                                                                      'item_id'],
                                                                  value.bagList[
                                                                          index]
                                                                      [
                                                                      'actual_rate'],
                                                                  value
                                                                      .rateList[
                                                                          index]
                                                                      .text,
                                                                  value.bagList[
                                                                          index]
                                                                      ['qty'],
                                                                  context,
                                                                  "delete",
                                                                  widget
                                                                      .form_type,
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
                                                                  "");

                                                              Navigator.of(ctx)
                                                                  .pop();
                                                            },
                                                            child: Text("Ok"),
                                                          ),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.01,
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
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Remove",
                                                    style: GoogleFonts.aBeeZee(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText2,
                                                        fontSize: 15,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        // fontWeight: FontWeight.bold,
                                                        color: P_Settings
                                                            .loginPagetheme),
                                                  ),
                                                  Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                    size: 17,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Amount : ",
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyText2,
                                                        fontSize: 14,
                                                        color:
                                                            P_Settings.bagText,
                                                      ),
                                                    ),
                                                    widget.form_type == "3"
                                                        ? Text(
                                                            "\u{20B9}${double.parse(value.bagList[index]["gross"]).toStringAsFixed(2)}",
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: P_Settings
                                                                  .redclr,
                                                            ),
                                                          )
                                                        : Text(
                                                            "\u{20B9}${double.parse(value.bagList[index]["net_total"]).toStringAsFixed(2)}",
                                                            style: GoogleFonts
                                                                .aBeeZee(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: P_Settings
                                                                  .redclr,
                                                            ),
                                                          ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
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
      ),
    );
  }
}
