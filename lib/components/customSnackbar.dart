import 'package:flutter/material.dart';
import 'package:gulferp/components/commonColor.dart';


class CustomSnackbar {
  showSnackbar(BuildContext context, String content,String type) {
    ScaffoldMessenger. of(context).showSnackBar(
      SnackBar(
        backgroundColor:Colors.red,
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
