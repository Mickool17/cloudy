import 'package:cloudy/models/basemodel.dart';
import 'package:cloudy/search/weatherdata.dart';

class WeatherSearchViewModel extends BaseModel {
  final List<WeatherData> _recentSearches = [];

  List<WeatherData> get recentSearches => _recentSearches;

  void addSearchResult(WeatherData result) {
    // Only add the result if it's not already in the list
    if (!_recentSearches.any((element) => element.locationname == result.locationname)) {
      if (_recentSearches.length == 5) {
        // If we already have 5 elements, remove the oldest one
        _recentSearches.removeAt(0);
      }
      _recentSearches.add(result);
      notifyListeners();
    }
  }
}
