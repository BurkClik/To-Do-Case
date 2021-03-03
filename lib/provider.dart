import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  List<String> _searchResult;
  List<String> get searchResult => _searchResult;

  SearchProvider(this._searchResult);

  void addSearchResult(String result) {
    _searchResult.add(result);
    notifyListeners();
  }

  void clearSearchResult() {
    _searchResult.clear();
  }

  int resultLenght() {
    return _searchResult.length;
  }
}

class LocationProvider extends ChangeNotifier {
  String _loc;
  String get loc => _loc;

  LocationProvider(this._loc);

  void changeLoc(String newLoc) {
    _loc = newLoc;
    notifyListeners();
  }
}
