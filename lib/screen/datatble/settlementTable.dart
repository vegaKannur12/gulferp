// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gulferp/components/commonColor.dart';
// import 'package:provider/provider.dart';

// import '../../controller/controller.dart';

// class SettlemntTable extends StatefulWidget {
//   const SettlemntTable({super.key});

//   @override
//   State<SettlemntTable> createState() => _SettlemntTableState();
// }

// class _SettlemntTableState extends State<SettlemntTable> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Consumer<Controller>(
//         builder: (context, value, child) {
//           return DataTable(
//             columnSpacing: 7,
//             headingRowHeight: 35,
//             dataRowHeight: 35,
//             horizontalMargin: 5,
//             // decoration: BoxDecoration(color: P_Settings.l1totColor),
//             border: TableBorder.all(
//               color: P_Settings.loginPagetheme,
//             ),
//             dataRowColor: MaterialStateColor.resolveWith(
//                 (states) => Color.fromARGB(255, 179, 172, 172)),
//             columns: <DataColumn>[
//               DataColumn(
//                 label: Text(
//                   " ",
//                   style: GoogleFonts.aBeeZee(
//                     textStyle: Theme.of(context).textTheme.bodyText2,
//                     fontSize: 17,
//                     // fontWeight: FontWeight.bold,
//                     // color: P_Settings.loginPagetheme,
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Text(
//                   " ",
//                   style: GoogleFonts.aBeeZee(
//                     textStyle: Theme.of(context).textTheme.bodyText2,
//                     fontSize: 17,
//                     // fontWeight: FontWeight.bold,
//                     // color: P_Settings.loginPagetheme,
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Text(
//                   " ",
//                   style: GoogleFonts.aBeeZee(
//                     textStyle: Theme.of(context).textTheme.bodyText2,
//                     fontSize: 17,
//                     // fontWeight: FontWeight.bold,
//                     // color: P_Settings.loginPagetheme,
//                   ),
//                 ),
//               ),
//               DataColumn(
//                 label: Text(""),
//               ),
//             ],
//             rows:value.vehicleSettlemntList.map((e) {
//               return DataRow(cells: [

//               ]);
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }

//   //////////////////////////////////////////////////////////////

// }
