import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sida_drivers_app/demo/phone_screen.dart';
import 'package:sida_drivers_app/screens/cancel_driver_screen.dart';
import 'package:sida_drivers_app/screens/home_screen.dart';
import 'package:sida_drivers_app/shared/colors/colors.dart';
import 'package:sida_drivers_app/sign_up_in/phone_number_page.dart';
import 'globalvariables.dart';
import 'localization/app_localization.dart';
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

class MyApp extends StatefulWidget {
  final Widget currentScreen;
  MyApp(this.currentScreen);
  static void setLocale(BuildContext context, Locale locale)
  {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;
  void setLocale(Locale locale)
  {
    setState(()
    {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataProvider>(create: (_) => DataProvider()),
        Provider<MapProvider>(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SIDA Driver - Egyptian Ride Hailing App',
        theme: ThemeData(
          primaryColor: customAmberColor2,
          fontFamily: 'Spoqa Han Sans Neo',
        ),

        locale: _locale,

        supportedLocales:
        [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],

        localizationsDelegates:
        [
          AppLocalization.localizationsDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // ignore: missing_return
        localeResolutionCallback: (deviceLocale, supportedLocales)
        {
          bool isEnglish = CacheHelper.getIsEnglishData();
          print('shared pref in main is English?  ' + isEnglish.toString());

          //   Provider.of<DataProvider>(context, listen: false).setIsEnglishChosen(_isEnglish);

          //TODO: here is language problem
          if(CacheHelper.getIsEnglishData())
            return Locale('en', 'US');
          if(!CacheHelper.getIsEnglishData())
            return Locale('ar', 'EG');
          //TODO: use enum for language (AR, EN, DEFAULT)
          // else
          //   return supportedLocales.first;
        },

        home: widget.currentScreen,
      //   initialRoute: (currentUser == null) ? PhoneNumberPage.id : HomeScreen.id,
      //  routes: {
      //    PhoneNumberPage.id: (context) => PhoneNumberPage(),
      //     HomeScreen.id: (context) => HomeScreen(),
      //   },
      ),
    );
  }
}
