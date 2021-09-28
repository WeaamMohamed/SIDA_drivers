import 'package:flutter/cupertino.dart';
import 'package:sida_drivers_app/shared/network/local/cache_helper.dart';

class DataProvider with ChangeNotifier
{
  String earnings = '0.00';
  int tripCount = 0;
  List<String> tripHistoryKeys = [];
  //List<History> tripHistory = [];

  void updateEarnings(String updatedEarnings){
    earnings = updatedEarnings;
    notifyListeners();
  }

  void updateTripCount(int newTripCount){
    tripCount = newTripCount;
    notifyListeners();
  }

  void updateTripKeys(List<String> newKeys){
    tripHistoryKeys = newKeys;
    notifyListeners();
  }

  //void updateTripHistory(History historyItem){
    //tripHistory.add(historyItem);
    //notifyListeners();
  //}

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