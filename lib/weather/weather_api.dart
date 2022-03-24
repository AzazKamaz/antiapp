import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'weather_model.dart';

class WeatherApi {
  final Dio dio = Dio();
  final logger = Logger(printer: PrettyPrinter());

  final _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final _apiKey = '8d7a65eac66f2ca7327a5499f3734fb9'; // top secret key

  Future<WeatherModel?> getWeather(String city) async {
    final url = _baseUrl + '?q=' + city + '&appid=' + _apiKey;
    try {
      Response weatherData = await dio.get(url);
      return WeatherModel.fromJson(weatherData.data);
    } catch (e) {
      logger.e('Error occured while getting weather info: $e');
      return null;
    }
  }
}
