import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gulferp/components/commonColor.dart';
import 'package:gulferp/controller/controller.dart';
import 'package:gulferp/controller/registrationController.dart';
import 'package:gulferp/screen/splashScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// registration id
// DZNFEJY9OTOA
void requestPermission() async {
  var status = await Permission.storage.status;
  // var statusbl= await Permission.bluetooth.status;

  var status1 = await Permission.manageExternalStorage.status;

  if (!status1.isGranted) {
    await Permission.storage.request();
  }
  if (!status1.isGranted) {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      await Permission.bluetooth.request();
    } else {
      openAppSettings();
    }
    // await Permission.app
  }
  if (!status1.isRestricted) {
    await Permission.manageExternalStorage.request();
  }
  if (!status1.isPermanentlyDenied) {
    await Permission.manageExternalStorage.request();
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  requestPermission();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(create: (_) => RegistrationController()),
    ],
    child: MyApp(),
  ));

  // configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Roboto Mono sample',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // fontFamily: 'OpenSans',
          primaryColor: P_Settings.loginPagetheme,
          // colorScheme: ColorScheme.fromSwatch(
          //   primarySwatch: Colors.indigo,
          // ),
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          // scaffoldBackgroundColor: P_Settings.bodycolor,
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //   headline6: TextStyle(
          //     fontSize: 25.0,
          //   ),
          //   bodyText2: TextStyle(
          //     fontSize: 14.0,
          //   ),
          // ),
        ),
        home: SplashScreen()
        // BagPage(type: "sales cart",branchId: "25",)
        //  AnimatedSplashScreen(
        //   backgroundColor: Colors.black,
        //   splash: Image.asset("asset/logo_black_bg.png"),
        //   nextScreen: SplashScreen(),
        //   splashTransition: SplashTransition.fadeTransition,
        //   duration: 1000,
        // ),
        );
  }
}
