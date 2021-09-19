import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_drivers_app/screens/home_screen.dart';
import 'package:sida_drivers_app/shared/colors/colors.dart';
import 'package:sida_drivers_app/sign_up_in/phone_numer_page.dart';
import 'firebase_db.dart';
import 'shared/providers/map_provider.dart';
import 'shared/providers/data_provider.dart';
void main() async{
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  currentUser = await FirebaseAuth.instance.currentUser;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        home: PhoneNumberPage(),
       // initialRoute: (currentUser == null) ? PhoneNumberPage.id : HomeScreen.id,
       //routes: {
        // PhoneNumberPage.id: (context) => PhoneNumberPage(),
          //HomeScreen.id: (context) => HomeScreen(),
       // },
      ),
    );
  }
}
