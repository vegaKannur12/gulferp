import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class VehicleLoading extends StatefulWidget {
  String os_id;
  VehicleLoading({required this.os_id});

  @override
  State<VehicleLoading> createState() => _VehicleLoadingState();
}

class _VehicleLoadingState extends State<VehicleLoading> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Container(
        height: double.infinity,
        // color: Color.fromARGB(255, 51, 48, 48),
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Column(
              children: [
                value.isLoading
                    ? Expanded(
                        child: SpinKitFadingCircle(
                          color: P_Settings.loginPagetheme,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: value.vehicle_loading_detaillist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 1, bottom: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg'),
                                    backgroundColor: Colors.transparent,
                                    // child: Image.network(

                                    //   'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  title: Text(
                                    value.vehicle_loading_detaillist[index]
                                        ["item_name"],
                                    style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 18,
                                      // fontWeight: FontWeight.bold,
                                      color: P_Settings.loginPagetheme,
                                    ),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Qty :    ${value.vehicle_loading_detaillist[index]["qty"]} ,"),
                                      // Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Text(
                                            "Srate :    ${value.vehicle_loading_detaillist[index]["s_rate"]} "),
                                      ),
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(left: 8.0),
                                      //   child: Text(
                                      //       "Srate2 :    ${value.vehicle_loading_detaillist[index]["s_rate_2"]}"),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                value.isLoading
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // height: size.height * 0.05,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: P_Settings.loginPagetheme,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(2), // <-- Radius
                                ),
                              ),
                              child: Text(
                                "Approve",
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.buttonColor,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext ctx) {
                                      return new AlertDialog(
                                        content:
                                            Text("Do you want to Approve ???"),
                                        actions: <Widget>[
                                          Consumer<Controller>(
                                            builder: (context, value, child) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: P_Settings
                                                                .loginPagetheme),
                                                    onPressed: () async {
                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .saveVehicleLoadingList(
                                                              context,
                                                              widget.os_id);

                                                      // Navigator.of(ctx).pop();
                                                    },
                                                    child: Text("Ok"),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.01,
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: P_Settings
                                                                .loginPagetheme),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                              },
                            ),
                          ),
                        ],
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
