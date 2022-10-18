import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/controller.dart';

class DynamicRowAdd extends StatefulWidget {
  const DynamicRowAdd({Key? key}) : super(key: key);

  @override
  State<DynamicRowAdd> createState() => _DynamicRowAddState();
}

class _DynamicRowAddState extends State<DynamicRowAdd> {
  List<TextEditingController> _controllers = [];
  List<TextField> _fields = [];
  int value = 0;
  String? selectedname;
  List<ItemMaster> item = [];
  List<TextEditingController> qty = [];

  TextEditingController itemName = TextEditingController();

  TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingController qtyItem = TextEditingController();

  _addItem(String name, String qtys) {
    setState(() {
      value = value + 1;
      print("valueeee------$value");
      final controller = TextEditingController();
      final field = TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          // labelText: "name${_controllers.length + 1}",
        ),
      );
      controller.text = qtys;
      setState(() {
        item.add(ItemMaster(
          itemName: name,
          // sRate1: srate
        ));
        _controllers.add(controller);
        _fields.add(field);
      });
      // qty = List.generate(1, (index) => TextEditingController());

      // qty[value].text = qtys.toString();
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("MyApp"),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //         width: 200,
              //         child: TextField(
              //           controller: itemName,
              //         )),
              //     Container(
              //         width: 50,
              //         child: TextField(
              //           controller: qtyItem,
              //         )),
              //     ElevatedButton(
              //         onPressed: () {
              //           _addItem(
              //             itemName.text,
              //             qtyItem.text,
              //           );

              //           itemName.clear();
              //           qtyItem.clear();
              //         },
              //         child: Icon(Icons.add))
              //   ],
              // ),

              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 300,
                      child: Autocomplete<Map<String, dynamic>>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          print("text-------${textEditingValue.text}");
                          List<Map<String, dynamic>> list = value.productList
                              .where((Map<String, dynamic> itemMaster) =>
                                  itemMaster["item_name"].toString().startsWith(
                                      textEditingValue.text.toLowerCase()))
                              .toList();
                          print("sorted list-----$list");
                          return list;
                        },
                        displayStringForOption: (Map<String, dynamic> option) =>
                            option["item_name"].toString(),
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextField(
                            decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              hintText: 'select item',
                            ),
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                        onSelected: (Map<String, dynamic> selection) {
                          selectedname = selection["item_name"];
                          print("onselected------${selection}");
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<Map<String, dynamic>>
                                onSelected,
                            Iterable<Map<String, dynamic>> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                width: 300,
                                color: Colors.cyan,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(10.0),
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Map<String, dynamic> option =
                                        options.elementAt(index);

                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            option["item_name"].toString(),
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 50,
                        child: TextField(
                          textAlign: TextAlign.right,
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            hintText: 'qty',
                          ),
                          controller: qtyItem,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 54,
                        child: ElevatedButton(
                            onPressed: () {
                              _addItem(
                                selectedname.toString(),
                                qtyItem.text,
                              );

                              itemName.clear();
                              qtyItem.clear();
                              fieldTextEditingController.clear();
                            },
                            child: Icon(Icons.add)),
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                    itemCount: this.value,
                    itemBuilder: (context, index) => this._buildRow(
                          index,
                        )),
              ),
            ],
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addItem,
      //   child: Icon(Icons.add),
      // ),
    );
  }

  _buildRow(
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
      child: Card(
          color: Colors.grey[300],
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item[index].itemName.toString()),
                Container(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.right,
                      controller: _controllers[index],
                    )),
              ],
            ),
          )),
    );
  }
}

class ItemMaster {
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

  ItemMaster(
      {this.itemId,
      this.catId,
      this.itemName,
      this.batchCode,
      this.itemImg,
      this.sRate1,
      this.stock,
      this.gst,
      this.cess_per,
      this.taxable});
}
