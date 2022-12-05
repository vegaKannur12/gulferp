import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:provider/provider.dart';

import '../../components/modalBottomsheet.dart';

class CustomerSelection extends StatefulWidget {
  List<Map<String, dynamic>> list;
  String? selected;
  String? selectedRoute;
  CustomerSelection({required this.list, this.selected, this.selectedRoute});

  @override
  State<CustomerSelection> createState() => _CustomerSelectionState();
}

class _CustomerSelectionState extends State<CustomerSelection> {
  List<_AZItem> items = [];
  // Bottomsheet showsheet = Bottomsheet();
  // InfoBottomsheet infoshowsheet = InfoBottomsheet();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("dgjxfkjgkg-----${widget.list}");
    Provider.of<Controller>(context, listen: false)
        .getCustomerList(widget.selected!);
    initList(widget.list);
  }

/////////////////////////////////////
  void initList(List<Map<String, dynamic>> items) {
    print("cjncn----${items}");
    this.items = items
        .map(
          (item) => _AZItem(
              tag: item["Customer"][0].toUpperCase(),
              address: item["Address"],
              customer: item["Customer"],
              fLD3001: item["FLD3001"],
              email: item["Email"],
              outstanding: item["Outstanding"],
              phone: item["Phone"],
              route: item["Route"],
              gtype: item["g_type"]),
        )
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: P_Settings.loginPagetheme),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Customer List of ",
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.loginPagetheme,
                        ),
                      ),
                      Text(
                        "${widget.selectedRoute.toString()}",
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 50,
                  endIndent: 50,
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),

                Expanded(child: Consumer<Controller>(
                  builder: (context, value, child) {
                    // print("value------${value.filter}");
                    return AzListView(
                      data: items,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        print("itemmmm------$item");
                        return buildListitem(item, size, index);
                      },
                      indexHintBuilder: (context, tag) {
                        return Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: Text(
                            tag,
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                        );
                      },
                      indexBarMargin: EdgeInsets.all(10),
                      indexBarAlignment: Alignment.centerLeft,
                      indexBarItemHeight: 30,
                      indexBarData: value.uniquecustomerlist,
                      indexBarOptions: IndexBarOptions(
                        needRebuild: true,
                        selectTextStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        selectItemDecoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        indexHintAlignment: Alignment.centerRight,
                        indexHintOffset: Offset(-20, 0),
                      ),
                    );
                  },
                ))
                // Expanded(
                //   child: AlphabetScrollPage(
                //       onClickedItem: (item) {
                //         final snackbar = SnackBar(
                //             content: Text(
                //           "Clicked Item  $item",
                //           style: TextStyle(fontSize: 20),
                //         ));
                //         ScaffoldMessenger.of(context)
                //           ..removeCurrentSnackBar()
                //           ..showSnackBar(snackbar);
                //       },
                //       items: value.filter
                //           ? value.filteredproductList
                //           : widget.list),
                // ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildListitem(_AZItem item, Size size, int index) {
    // final tag = item.getSuspensionTag();
    final offStage = item.isShowSuspension;
    return Column(
      children: [
        // Offstage(offstage: offStage, child: buildHeader(tag)),
        Consumer<Controller>(
          builder: (context, value, child) {
            return Container(
              // decoration: BoxDecoration(
              //   border: Border(
              //     bottom: BorderSide(width: 1, color: Colors.grey),
              //   ),
              // ),
              // height: size.height * 0.05,
              margin: EdgeInsets.only(left: 40),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Provider.of<Controller>(context, listen: false)
                        .setCustomerName(
                            item.customer.toString(),
                            item.gtype.toString(),
                            item.fLD3001.toString(),
                            item.outstanding.toString());
                    Navigator.pop(context);
                  },
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item.customer.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.place,
                              size: 13,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Flexible(
                              child: Text(
                                item.address.toString(),
                                style: GoogleFonts.aBeeZee(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2,
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: P_Settings.loginPagetheme,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                           Text(
                              "Bal :",
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Text(
                              item.outstanding.toString(),
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildHeader(String tag) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(right: 18),
      padding: EdgeInsets.only(left: 18),
      color: Colors.grey,
      alignment: Alignment.centerLeft,
      child: Text(
        "$tag",
        // softWrap: false,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _AZItem extends ISuspensionBean {
  String? tag;
  String? fLD3001;
  String? customer;
  Null? phone;
  String? address;
  String? email;
  String? route;
  String? outstanding;
  String? gtype;

  _AZItem(
      {this.tag,
      this.fLD3001,
      this.customer,
      this.phone,
      this.address,
      this.email,
      this.route,
      this.outstanding,
      this.gtype});

  @override
  String getSuspensionTag() => tag!;
}
