import 'package:flutter/material.dart';
import 'package:mystock/components/commonColor.dart';


class CustomSnackbar {
  showSnackbar(BuildContext context, String content,String type) {
    ScaffoldMessenger. of(context).showSnackBar(
      SnackBar(
        backgroundColor:P_Settings.buttonColor,
        duration: const Duration(seconds: 1),
        content: Text("${content}"),
        action: SnackBarAction(
          label: '',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
