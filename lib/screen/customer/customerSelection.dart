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
  CustomerSelection({required this.list});

  @override
  State<CustomerSelection> createState() => _CustomerSelectionState();
}

class _CustomerSelectionState extends State<CustomerSelection> {
  List<_AZItem> items = [];
  Bottomsheet showsheet = Bottomsheet();
  // InfoBottomsheet infoshowsheet = InfoBottomsheet();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("dgjxfkjgkg-----${widget.list}");

    initList(widget.list);
  }

/////////////////////////////////////
  void initList(List<Map<String, dynamic>> items) {
    print("cjncn----${items}");
    this.items = items
        .map(
          (item) => _AZItem(
            tag: item["item_name"][0].toUpperCase(),
            itemId: item["item_id"],
            catId: item["cat_id"],
            itemName: item["item_name"].toUpperCase(),
            batchCode: item["batch_code"],
            itemImg: item["item_img"],
            sRate1: item["s_rate_1"],
            sRate2: item["s_rate_2"],
            stock: item["stock"],
          ),
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "Select Item Category",
                //     style: TextStyle(fontSize: 20),
                //   ),
                // ),
                // Divider(),
                SizedBox(
                  height: size.height * 0.02,
                ),

                Expanded(child: Consumer<Controller>(
                  builder: (context, value, child) {
                    print("value------${value.filter}");
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
                      indexBarData: value.filter
                          ? value.filtereduniquelist
                          : value.uniquelist,
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              height: size.height * 0.08,
              margin: EdgeInsets.only(left: 40),
              child: ListTile(
                trailing: value.qty[index].text == "0"
                    ? IconButton(
                        onPressed: () {
                          // int qty;
                          // value.setqtyErrormsg(false);
                          value.qty[index].selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: value.qty[index].value.text.length);
                          showsheet.showSheet(
                            context,
                            index,
                            item.itemId!,
                            item.catId!,
                            item.batchCode!,
                            item.itemName!,
                            item.itemImg!,
                            double.parse(item.sRate1!),
                            double.parse(item.sRate2!),
                            double.parse(item.stock!),
                            value.qty[index].text,
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          size: 20,
                        ))
                    : GestureDetector(
                        onTap: () {
                          // value.setqtyErrormsg(false);
                          value.qty[index].selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: value.qty[index].value.text.length);
                          showsheet.showSheet(
                            context,
                            index,
                            item.itemId!,
                            item.catId!,
                            item.batchCode!,
                            item.itemName!,
                            item.itemImg!,
                            double.parse(item.sRate1!),
                            double.parse(item.sRate2!),
                            double.parse(item.stock!),
                            // widget.transVal,
                            value.qty[index].text,
                            // item.itemImg!
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Text(
                            value.qty[index].text,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ),
                title: Text(item.itemName!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: P_Settings.loginPagetheme,
                    )),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Container(
                          // width: size.width * 0.,
                          child: Text("MOP:${item.sRate1},")),
                    ),
                    Flexible(
                      child: Container(
                          // width: size.width * 0.3,
                          child: Text(" MRP:${item.sRate1},")),
                    ),
                    Flexible(
                      child: Container(
                          // width: size.width * 0.3,
                          child: Text(" Stock:${item.stock}")),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Provider.of<Controller>(context, listen: false)
                        //     .getinfoList(context, item.itemId!);
                        // infoshowsheet.showInfoSheet(
                        //   context,
                        // );
                      },
                      child: Icon(
                        Icons.info,
                        size: 19,
                      ),
                    )
                  ],
                ),
                // onTap: () {
                //   value.setqtyErrormsg(false);

                //   showsheet.showSheet(
                //       context,
                //       index,
                //       item.itemId!,
                //       item.catId!,
                //       item.batchCode!,
                //       item.itemName!,
                //       item.itemImg!,
                //       double.parse(item.sRate1!),
                //       double.parse(item.sRate2!),
                //       double.parse(item.stock!),
                //       widget.transVal,
                //       value.qty[index].text);
                // }
                // widget.onClickedItem(item.title!),
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
  String? itemId;
  String? catId;
  String? itemName;
  String? batchCode;
  String? itemImg;
  String? sRate1;
  String? sRate2;
  String? stock;

  _AZItem({
    this.tag,
    this.itemId,
    this.catId,
    this.itemName,
    this.batchCode,
    this.itemImg,
    this.sRate1,
    this.sRate2,
    this.stock,
  });

  @override
  String getSuspensionTag() => tag!;
}
