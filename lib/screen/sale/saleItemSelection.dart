import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:provider/provider.dart';

import '../itemSelectionCommon.dart';

class SaleItemSelection extends StatefulWidget {
  List<Map<String, dynamic>> list;
  String? remark;
  SaleItemSelection({required this.list, this.remark});

  @override
  State<SaleItemSelection> createState() => _SaleItemSelectionState();
}

class _SaleItemSelectionState extends State<SaleItemSelection> {
  List<Map<String, dynamic>> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemList() async {
      list = await Provider.of<Controller>(context, listen: false)
          .getProductDetails();

      print("listttt----$list");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isProdLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.loginPagetheme,
            );
          } else {
            if (list.length > 0) {
              return ItemSelection(
                list: list,
                // transVal: widget.transVal,
                // transType: widget.transType,
              );
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
