import 'package:azlistview/azlistview.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/components/modalBottomsheet.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/screen/sale/saleDetailsBottomSheet.dart';

import 'package:provider/provider.dart';

class ItemSelection extends StatefulWidget {
  List<Map<String, dynamic>> list;
  String formType;
  String? gtype;

  ItemSelection({required this.list, required this.formType, this.gtype
      //  required this.transVal, required this.transType
      });

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  String? selected;
  List<_AZItem> items = [];
  List<String> uniqueList = [];
  List splitted = [];
  SaleDetailsBottomSheet saleDetais = SaleDetailsBottomSheet();
  bool gstvisible = false;
  // Bottomsheet showsheet = Bottomsheet();
  // InfoBottomsheet infoshowsheet = InfoBottomsheet();
  String? staff_id;
  var itemstest = [
    'kg',
    'pcs',
  ];
  // List<String> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("dgjxfkjgkg-----${widget.gtype}");

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
              sRate1: item["s_rate_fix"],
              stock: item["stock"],
              gst: item["gst"],
              cess_per: item["cess"],
              taxable: item["taxable"]),
        )
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
    setState(() {});
  }

  // void setBarData(List<Map<String, dynamic>> items) {
  //   print("cjncn----${items}");
  //   this.items = items
  //       .map(
  //         (item) => _AZItem(
  //           title: item["item"].toUpperCase(),
  //           tag: item["item"][0].toUpperCase(),
  //         ),
  //       )
  //       .toList();
  //   SuspensionUtil.sortListBySuspensionTag(this.items);
  //   SuspensionUtil.setShowSuspensionStatus(this.items);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Provider.of<Controller>(context, listen: false)
      //             .setfilter(false);
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(Icons.arrow_back)),
      //   backgroundColor: P_Settings.loginPagetheme,
      // ),
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
                Container(
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: P_Settings.loginPagetheme,
                        style: BorderStyle.solid,
                        width: 0.3),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selected,
                    // value: selected,
                    // isDense: true,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(value.dropdwnString == null ||
                              value.dropdwnString!.isEmpty
                          ? value.dropdwnVal.toString()
                          : value.dropdwnString.toString()),
                    ),
                    // isExpanded: true,
                    autofocus: false,
                    underline: SizedBox(),
                    elevation: 0,
                    items: value.itemCategoryList
                        .map((item) => DropdownMenuItem<String>(
                            value: "${item.catId},${item.catName}",
                            child: Container(
                              width: size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.catName.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            )))
                        .toList(),
                    onChanged: (item) {
                      print("clicked");
                      if (item != null) {
                        setState(() {
                          selected = item;
                        });
                        splitted = selected!.split(',');
                        print("splitted---$splitted");
                        // Provider.of<Controller>(context, listen: false)
                        //     .filterProduct(selected!);
                        print("se;ected---$item");
                      }
                      Provider.of<Controller>(context, listen: false)
                          .getProductDetails(
                              splitted[0], splitted[1], widget.formType);
                    },
                  ),
                ),
                Divider(),
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
                          print(
                              "new quantity text.......${value.qty[index].text}");
                          value.qty[index].selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: value.qty[index].value.text.length);
                          double gross = double.parse(item.sRate1!) *
                              double.parse(value.qty[index].text);
                          // print("srate1------$srate1---$qty");
                          print("gross calc===$gross");
                          // value.qty[index].text = qty.toStringAsFixed(2);

                          Provider.of<Controller>(context, listen: false)
                              .fromDb = true;
                          value.qty[index].selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: value.qty[index].value.text.length);
                          Provider.of<Controller>(context, listen: false)
                              .rawCalculation(
                                  double.parse(item.sRate1!),
                                  double.parse(value.qty[index].text),
                                  double.parse(
                                      value.discount_prercent[index].text),
                                  double.parse(
                                      value.discount_amount[index].text),
                                  double.parse(item.gst!),
                                  double.parse(item.cess_per!),
                                  "0",
                                  int.parse(widget.gtype!),
                                  index,
                                  false,
                                  "");

                          saleDetais.showSheet(
                              context,
                              index,
                              item.itemId!,
                              item.catId!,
                              item.batchCode!,
                              item.itemName!,
                              item.itemImg!,
                              double.parse(item.sRate1!),
                              double.parse(item.stock!),
                              value.qty[index].text,
                              widget.formType,
                              double.parse(item.gst!),
                              value.tax,
                              double.parse(item.cess_per!),
                              value.cess,
                              value.disc_per,
                              value.disc_amt,
                              gross,
                              double.parse(item.taxable!),
                              int.parse(widget.gtype!),
                              "0");
                        },
                        icon: Icon(
                          Icons.add,
                          size: 20,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          print("added data.");
                          print(
                              "added qty text.......${value.qty[index].text}");
                          // value.setqtyErrormsg(false);

                          value.qty[index].selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: value.qty[index].value.text.length);
                          double gross = double.parse(item.sRate1!) *
                              double.parse(value.qty[index].text);
                          // print("srate1------$srate1---$qty");
                          print(
                              "gross calc===$gross /////////////${value.qty[index].text}");
                          //  value.discount_prercent[index].text = "0.00";
                          //     value.discount_amount[index].text = "0.00";
                          print(
                              "disPerClicked-----${value.disPerClicked}----${value.disamtClicked}");
                          // if (value.disPerClicked && value.disamtClicked) {
                          // }else{
                          //   value.discount_prercent[index].text = "0.00";
                          //   value.discount_amount[index].text = "0.00";
                          // }
                          // if () {
                          // }else{
                          //   print("elseee----");

                          // }

                          Provider.of<Controller>(context, listen: false)
                              .fromDb = true;
                          value.qty[index].selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: value.qty[index].value.text.length);
                          Provider.of<Controller>(context, listen: false)
                              .rawCalculation(
                                  double.parse(item.sRate1!),
                                  double.parse(value.qty[index].text),
                                  double.parse(
                                      value.discount_prercent[index].text),
                                  double.parse(
                                      value.discount_amount[index].text),
                                  double.parse(item.gst!),
                                  double.parse(item.cess_per!),
                                  "0",
                                  int.parse(widget.gtype!),
                                  index,
                                  false,
                                  "");
                          // print("quantity in cart..........$qty");
                          // Provider.of<Controller>(context, listen: false)
                          //     .setQty(qty);
                          saleDetais.showSheet(
                              context,
                              index,
                              item.itemId!,
                              item.catId!,
                              item.batchCode!,
                              item.itemName!,
                              item.itemImg!,
                              double.parse(item.sRate1!),
                              double.parse(item.stock!),
                              value.qty[index].text,
                              widget.formType,
                              double.parse(item.gst!),
                              value.tax,
                              double.parse(item.cess_per!),
                              value.cess,
                              value.disc_per,
                              value.disc_amt,
                              gross,
                              0,
                              int.parse(widget.gtype!),
                              "0");
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                          // width: size.width * 0.2,
                          child: Text("SRate:${item.sRate1}")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Container(
                          // width: size.width * 0.2,
                          child: Text("Stock:${item.stock}")),
                    ),
                    gstvisible == false
                        ? Visibility(
                            visible: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Container(
                                  // width: size.width * 0.2,
                                  child: Text("GST:${item.gst}")),
                            ),
                          )
                        : Visibility(
                            visible: true,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Container(
                                  // width: size.width * 0.2,
                                  child: Text("GST:${item.gst}")),
                            ),
                          ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // Provider.of<Controller>(context, listen: false)
                    //     //     .getinfoList(context, item.itemId!);
                    //     // infoshowsheet.showInfoSheet(
                    //     //   context,
                    //     // );
                    //   },
                    //   child: Icon(
                    //     Icons.info,
                    //     size: 19,
                    //   ),
                    // )
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
  String? stock;
  String? gst;
  String? cess_per;
  String? taxable;

  _AZItem(
      {this.tag,
      this.itemId,
      this.catId,
      this.itemName,
      this.batchCode,
      this.itemImg,
      this.sRate1,
      this.stock,
      this.gst,
      this.cess_per,
      this.taxable});

  @override
  String getSuspensionTag() => tag!;
}
