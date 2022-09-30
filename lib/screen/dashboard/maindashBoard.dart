import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/screen/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:colours/colours.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: P_Settings.loginPagetheme,
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        automaticallyImplyLeading: false,
        actions: [
          CircleAvatar(
            child: Image.asset("asset/login.png"),
          ),
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Refresh"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Logout"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              // Provider.of<Controller>(context, listen: false).userDetails();
              // Provider.of<Controller>(context, listen: false)
              // .getStockApprovalList(context);
            } else if (value == 1) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('st_username');
              await prefs.remove('st_pwd');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              print('Pressed');
            }
          }),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Container(
                height: size.height * 0.3,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // Text("heloooooooooo")
                        _buildParallaxBackground(context),
                        _buildTitleAndSubtitle(context),
                        // _buildGradient(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 70, top: 50),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color.fromARGB(255, 61, 61, 61),
                child: ListTile(
                  onTap: () {
                    // Provider.of<Controller>(context, listen: false)
                    //     .getTransactionList(context);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => TransactionPage()),
                    // );
                  },
                  leading: Image.asset("asset/transaction_card_payment.png",
                      color: Colors.white, height: 30),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Transaction",
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colours.gainsboro,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 70, top: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color.fromARGB(255, 61, 61, 61),
                child: ListTile(
                  onTap: () {
                    // Provider.of<Controller>(context, listen: false)
                    //     .getTransactionList(context);
                    // Provider.of<Controller>(context, listen: false)
                    //     .setIssearch(false);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           SearchScreen(type: "start")),
                    // );
                  },
                  leading: Image.asset(
                    "asset/searchwhite.png",
                    height: 30,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Search",
                    style: GoogleFonts.aBeeZee(
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colours.gainsboro,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildParallaxBackground(BuildContext context) {
  return Image.network(
    "https://st.depositphotos.com/1177973/4630/i/600/depositphotos_46301661-stock-photo-glasses-of-champagne-with-splash.jpg",
    fit: BoxFit.contain,
  );
}

// Widget _buildGradient() {
//   return Positioned.fill(
//     child: DecoratedBox(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           stops: const [0.6, 0.95],
//         ),
//       ),
//     ),
//   );
// }

Widget _buildTitleAndSubtitle(BuildContext context) {
  return Positioned(
    left: 8,
    bottom: 20,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "anu",
          // value.staff_name.toString(),
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
        Text(
          "KNR",
          // value.branch_name.toString(),
          style: GoogleFonts.aBeeZee(
            textStyle: Theme.of(context).textTheme.bodyText2,
            fontSize: 14,
            // fontWeight: FontWeight.bold,
            color: P_Settings.buttonColor,
          ),
        ),
      ],
    ),
  );
}
