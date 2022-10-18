import "package:flutter/material.dart";
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:provider/provider.dart';

class SaleSearchItem extends StatefulWidget {
  const SaleSearchItem({Key? key}) : super(key: key);

  @override
  State<SaleSearchItem> createState() => _SaleSearchItemState();
}

class _SaleSearchItemState extends State<SaleSearchItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.9,
                    height: size.height * 0.09,
                    child: TextField(
                      controller: value.searchcontroller,
                      onChanged: (values) {
                        Provider.of<Controller>(context, listen: false)
                            .setisVisible(true);
                        // values = value.searchcontroller.text;
                        if (values != null || values.isNotEmpty) {
                          // print("value-----$value");
                          Provider.of<Controller>(context, listen: false)
                              .setIssearch(true);
                          // value = searchcontroll.text;
                          print("valuess----$values");

                          Provider.of<Controller>(context, listen: false)
                              .searchItem(context, values);
                        } else {
                          Provider.of<Controller>(context, listen: false)
                              .setIssearch(false);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search Item here",
                        prefixIcon: Icon(
                          Icons.search,
                          color: P_Settings.loginPagetheme,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            value.searchcontroller.clear();
                          },
                          child: Icon(
                            Icons.close,
                            color: P_Settings.loginPagetheme,
                          ),
                        ),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: P_Settings.loginPagetheme),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 94, 95, 94)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      )),
    );
  }
}
