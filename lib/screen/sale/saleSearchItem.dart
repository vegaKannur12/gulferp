import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/sale/searchSheet.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SaleSearchItem extends StatefulWidget {
  String? gtype;
  String? formType;

  SaleSearchItem({this.gtype, this.formType});

  @override
  State<SaleSearchItem> createState() => _SaleSearchItemState();
}

class _SaleSearchItemState extends State<SaleSearchItem> {
  String? oldText;
  SearchBottomSheet searchSheet = SearchBottomSheet();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: SingleChildScrollView(child: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Card(
                  elevation: 12,
                  child: ListTile(
                    tileColor: Colors.green[100],
                    onTap: () {
                      value.searchList.clear();
                      value.searchcontroller.clear();
                      searchSheet.showsearchSheet(
                          context, size, widget.formType!, widget.gtype!);
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
            ],
          );
        },
      )),
    );
  }
}
