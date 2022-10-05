import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/customer/customerSelection.dart';
import 'package:gulferp/screen/sale/saleItemSelection.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SaleHome extends StatefulWidget {
  const SaleHome({Key? key}) : super(key: key);

  @override
  State<SaleHome> createState() => _SaleHomeState();
}

class _SaleHomeState extends State<SaleHome> {
  DateTime now = DateTime.now();
  String? selected;
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topInsets = MediaQuery.of(context).viewInsets.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 55),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                prefixIcon: Icon(
                  Icons.date_range,
                  color: Colors.red,
                ),
                labelText: "Entry date  :  $todaydate",
                labelStyle:
                    TextStyle(color: Colors.red, fontSize: 15 //<-- SEE HERE
                        ),
              ),
            ),
            // Text(
            //   "Entry date  :  $todaydate",
            //   style: GoogleFonts.aBeeZee(
            //       textStyle: Theme.of(context).textTheme.bodyText2,
            //       fontSize: 16,
            //       // fontWeight: FontWeight.bold,
            //       color: Colors.red),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0),
            child: Row(
              children: [
                Text(
                  "Inv No : ",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "ERTYU",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          dropDownRoute(size),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: P_Settings.choosecus,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2), // <-- Radius
                      ),
                    ),
                    child: Text(
                      "Choose Customer",
                      style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.buttonColor),
                    ),
                    onPressed: () async {
                      List<Map<String, dynamic>> list =
                          await Provider.of<Controller>(context, listen: false)
                              .getCustomerList(selected!);
                      if (list.length > 0) {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => CustomerSelection(
                                    list: list,
                                    // remark: remrk.text,
                                  )
                              // OrderForm(widget.areaname,"return"),
                              ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "customer",
                  style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: P_Settings.loginPagetheme),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: size.height * 0.4,
              child: TextFormField(
                controller: remrk,
                scrollPadding:
                    EdgeInsets.only(bottom: topInsets + size.height * 0.34),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.note_add,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
                    hintText: "Enter remark"),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            width: size.width * 0.4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: P_Settings.loginPagetheme,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2), // <-- Radius
                ),
              ),
              child: Text(
                "Next",
                style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: P_Settings.buttonColor),
              ),
              onPressed: () async {
                List<Map<String, dynamic>> list =
                    await Provider.of<Controller>(context, listen: false)
                        .getProductDetails();
                if (list.length > 0) {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => SaleItemSelection(
                              list: list,
                              remark: remrk.text,
                            )
                        // OrderForm(widget.areaname,"return"),
                        ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////
  Widget dropDownRoute(Size size) {
    return Consumer<Controller>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                      value: item.rId.toString(),
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

                  print("route id-----$selected");
                }
              },
            ),
          ),
        );
      },
    );
  }
}
