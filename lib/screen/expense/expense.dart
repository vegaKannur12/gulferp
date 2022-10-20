import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/dashboard/mainDashboard.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Expense extends StatefulWidget {
  String form_type;
  String type;
  Expense({required this.form_type, required this.type});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  DateTime now = DateTime.now();
  String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  ValueNotifier<bool> cusVisible = ValueNotifier(false);

  List splitted = [];
  TextEditingController amount = TextEditingController();
  TextEditingController naration = TextEditingController();

  // DateFind dateFind = DateFind();
  String? date;
  List<String> s = [];
  String? todaydate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("frmtype-----${widget.form_type}");
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Provider.of<Controller>(context, listen: false)
        //             .historyList
        //             .clear();
        //         Provider.of<Controller>(context, listen: false)
        //             .setDate(todaydate!, todaydate!);
        //         // Navigator.push(
        //         //   context,
        //         //   MaterialPageRoute(
        //         //       builder: (context) => HistoryPage(
        //         //             form_type: widget.formType,
        //         //           )),
        //         // );
        //       },
        //       icon: Container(
        //           height: size.height * 0.03,
        //           child: Image.asset("asset/history.png")))
        // ],
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 20.0),
                                  child: Container(
                                    width: size.height * 0.4,
                                    child: TextFormField(
                                      controller: naration,
                                      scrollPadding: EdgeInsets.only(
                                          bottom:
                                              topInsets + size.height * 0.34),
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.roller_shades,
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
                                          // hintText: "Naration",
                                          labelText: 'Naration',
                                          labelStyle: TextStyle(
                                              color: P_Settings.bagText)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 20.0),
                                  child: Container(
                                    width: size.height * 0.4,
                                    child: TextFormField(
                                      controller: amount,
                                      scrollPadding: EdgeInsets.only(
                                          bottom:
                                              topInsets + size.height * 0.34),
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.money_rounded,
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
                                          hintText: "Amount",
                                          labelText: 'Amount',
                                          labelStyle: TextStyle(
                                              color: P_Settings.bagText)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.3,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: P_Settings.loginPagetheme,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                2), // <-- Radius
                                          ),
                                        ),
                                        child: Text(
                                          "Save",
                                          style: GoogleFonts.aBeeZee(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: P_Settings.buttonColor),
                                        ),
                                        onPressed: () async {
                                    print("save expence");
                                        },
                                      ),
                                    ),
                                  ],
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
}
