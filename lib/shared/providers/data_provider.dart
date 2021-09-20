import 'package:flutter/cupertino.dart';
import 'package:sida_drivers_app/shared/network/local/cache_helper.dart';

class DataProvider with ChangeNotifier
{
  static bool _isEnglish = CacheHelper.getIsEnglishData();
  bool get isEnglish => _isEnglish;


  void setIsEnglishChosen (bool value) async {
    _isEnglish = value;
    CacheHelper.saveData(key: "isEnglish", data: value);
    print("setIsEnglishChosen: " + _isEnglish.toString());
    notifyListeners();
  }
  void toggleLanguage () async {
    _isEnglish = !_isEnglish;
    CacheHelper.saveData(key: "isEnglish",
        data: _isEnglish);
    print("toggleLanguage: " + _isEnglish.toString());
    notifyListeners();
  }

  
}