import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_drivers_app/screens/cancel_driver_screen.dart';
import 'package:sida_drivers_app/screens/home_screen.dart';
import 'package:sida_drivers_app/shared/colors/colors.dart';
import 'package:sida_drivers_app/sign_up_in/phone_number_page.dart';
import 'globalvariables.dart';
import 'shared/providers/map_provider.dart';
import 'shared/providers/data_provider.dart';
import 'package:sida_drivers_app/shared/network/local/cache_helper.dart';
import 'shared/componenents/constants.dart';

void main() async{
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  currentUser = FirebaseAuth.instance.currentUser;

  Widget currentScreen;
  bool isSignedIn = CacheHelper.getData(key: IS_SIGNED_IN_SHARED_PREF) == null? false:CacheHelper.getData(key: IS_SIGNED_IN_SHARED_PREF);
  print("is Signed In ? "+ isSignedIn.toString());
  isSignedIn? currentScreen = HomeScreen(): currentScreen = PhoneNumberPage();




  runApp(MyApp(currentScreen));
}

class MyApp extends StatelessWidget {
  final Widget currentScreen;
  MyApp(this.currentScreen);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataProvider>(create: (_) => DataProvider()),
        Provider<MapProvider>(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: customAmberColor2,
          fontFamily: 'Spoqa Han Sans Neo',
        ),
        home: currentScreen,
      //   initialRoute: (currentUser == null) ? PhoneNumberPage.id : HomeScreen.id,
      //  routes: {
      //    PhoneNumberPage.id: (context) => PhoneNumberPage(),
      //     HomeScreen.id: (context) => HomeScreen(),
      //   },
      ),
    );
  }
}
