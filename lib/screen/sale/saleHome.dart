import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/customer/customerSelection.dart';
import 'package:gulferp/screen/dashboard/maindashBoard.dart';
import 'package:gulferp/screen/history/history.dart';
import 'package:gulferp/screen/sale/saleItemSelection.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SaleHome extends StatefulWidget {
  String formType;
  String type;
  SaleHome({required this.formType, required this.type});

  @override
  State<SaleHome> createState() => _SaleHomeState();
}

class _SaleHomeState extends State<SaleHome> {
  DateTime now = DateTime.now();
  String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  ValueNotifier<bool> cusVisible = ValueNotifier(false);

  List splitted = [];
  TextEditingController remrk = TextEditingController();

  // DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  String? todaydate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todaydate = DateFormat('dd-MM-yyyy').format(now);
    Provider.of<Controller>(context, listen: false).cusName1 = null;
    Provider.of<Controller>(context, listen: false).cus_id = null;
    Provider.of<Controller>(context, listen: false).gtype1 = null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        title: Text(widget.type),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainDashboard()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<Controller>(context, listen: false)
                    .historyList
                    .clear();
                Provider.of<Controller>(context, listen: false)
                    .setDate(todaydate!, todaydate!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryPage(
                            form_type: widget.formType,
                          )),
                );
              },
              icon: Container(
                  height: size.height * 0.03,
                  child: Image.asset("asset/history.png")))
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<Controller>(
          builder: (context, value, child) {
            print("hdjshdjshd-----${value.cusName1}");
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: size.height * 0.2,
                      color: P_Settings.loginPagetheme,
                      // child: Text("data"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 100.0, left: 25, right: 25),
                      child: Card(
                        elevation: 4.0,
                        child: Center(
                          child: Container(
                            height: size.height * 0.55,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                TextField(
                                  enabled: false,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.red,
                                    ),
                                    labelText: "Entry date  :  $todaydate",
                                    labelStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15 //<-- SEE HERE
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, top: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Inv No : ",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      value.invoiceLoad
                                          ? SizedBox(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                        Color>(Colors.black),
                                              ),
                                              height: 10.0,
                                              width: 10.0,
                                            )
                                          : Text(
                                              "${value.invoice}",
                                              style: GoogleFonts.aBeeZee(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                dropDownRoute(size),
                                ValueListenableBuilder(
                                    valueListenable: visible,
                                    builder: (BuildContext context, bool v,
                                        Widget? child) {
                                      print("value===${visible.value}");
                                      return Visibility(
                                        visible: v,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6, bottom: 2.0, left: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Please choose  Route",
                                                style: GoogleFonts.aBeeZee(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    fontSize: 15,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40.0, top: 10),
                                      child: Container(
                                          child: OutlinedButton(
                                        child: Text(
                                          'Choose Customer',
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: P_Settings.loginPagetheme),
                                        ),
                                        onPressed: () async {
                                          List<Map<String, dynamic>> list = [];
                                          if (selected == null) {
                                            visible.value = true;
                                          } else {
                                            visible.value = false;

                                            list =
                                                await Provider.of<Controller>(
                                                        context,
                                                        listen: false)
                                                    .getCustomerList(selected!);
                                          }

                                          print("list-----$list");
                                          if (list.length > 0) {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  opaque: false, // set to false
                                                  pageBuilder: (_, __, ___) =>
                                                      CustomerSelection(
                                                        list: list,
                                                        selected: splitted[0],
                                                        selectedRoute:
                                                            splitted[1],
                                                        // remark: remrk.text,
                                                      )
                                                  // OrderForm(widget.areaname,"return"),
                                                  ),
                                            );
                                          }
                                        },
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 10),
                                      child: Text(
                                        value.cusName1 == null
                                            ? "customer"
                                            : value.cusName1.toString(),
                                        // "customer",
                                        style: GoogleFonts.aBeeZee(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                            color: P_Settings.loginPagetheme),
                                      ),
                                    )
                                  ],
                                ),
                                ValueListenableBuilder(
                                    valueListenable: cusVisible,
                                    builder: (BuildContext context, bool v,
                                        Widget? child) {
                                      print("value===${visible.value}");
                                      return Visibility(
                                        visible: v,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6, bottom: 2.0, left: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Please choose  Customer",
                                                style: GoogleFonts.aBeeZee(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    fontSize: 15,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 10.0),
                                  child: Container(
                                    width: size.height * 0.4,
                                    child: TextFormField(
                                      controller: remrk,
                                      scrollPadding: EdgeInsets.only(
                                          bottom:
                                              topInsets + size.height * 0.34),
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.note_add,
                                            color: Colors.grey,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700],
                                          ),
                                          hintText: "Enter remark"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                Container(
                                  width: size.width * 0.35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: P_Settings.loginPagetheme,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            2), // <-- Radius
                                      ),
                                    ),
                                    child: Text(
                                      "Next",
                                      style: GoogleFonts.aBeeZee(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.buttonColor),
                                    ),
                                    onPressed: () async {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getItemCategory(context);

                                      List<Map<String, dynamic>> list =
                                          await Provider.of<Controller>(context,
                                                  listen: false)
                                              .getProductDetails(
                                                  "0", "", widget.formType);
                                      print("value.gtype------${value.gtype1}");
                                      if (value.gtype1 == null) {
                                        cusVisible.value = true;
                                      } else {
                                        cusVisible.value = false;
                                        if (list.length > 0) {
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                                opaque: false, // set to false
                                                pageBuilder: (_, __, ___) =>
                                                    SaleItemSelection(
                                                      list: list,
                                                      remark: remrk.text,
                                                      formType: widget.formType,
                                                      g_type: value.gtype1!,
                                                    )
                                                // OrderForm(widget.areaname,"return"),
                                                ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Padding(
              ],
            );
          },
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////
  Widget dropDownRoute(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Container(
            width: size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                  color: P_Settings.loginPagetheme,
                  style: BorderStyle.solid,
                  width: 0.4),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selected,
              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select Route"),
              ),
              autofocus: true,
              underline: SizedBox(),
              elevation: 0,

              items: value.routeList
                  .map((item) => DropdownMenuItem<String>(
                      value: "${item.rId},${item.route}",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.route.toString(),
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

                  splitted = selected!.split(",");
                  if (selected != null) {
                    visible.value = false;
                  } else {
                    visible.value = true;
                  }
                  print("route id-----${splitted[0]}");
                }
              },
            ),
          ),
        );
      },
    );
  }
}
