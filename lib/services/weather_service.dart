import 'package:http/http.dart' as http;
import 'package:weather_app/services/api_list.dart';

class WeatherService {
  getWeather({String? endPoint, String? city}) async {
    try {
      return await http
          .get(Uri.parse("${ApiList.server!}${endPoint!}?city=${city!}"));
    } catch (e) {
      print('GET:ERROR');
      print(e);
      return null;
    }
  }

  getWeatherIcon({String? endPoint, String? icon}) async {
    try {
      return await http
          .get(Uri.parse("${ApiList.server!}${endPoint!}?icon=${icon!}"));
    } catch (e) {
      print('GET:ERROR IMAGE');
      print(e);
      return null;
    }
  }
}
