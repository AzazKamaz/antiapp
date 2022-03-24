import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  WeatherModel(
      {required this.coord,
      required this.main,
      required this.name,
      required this.wind});

  WeatherCoord coord;
  WeatherMain main;
  WeatherWind wind;
  String name;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class WeatherCoord {
  WeatherCoord({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory WeatherCoord.fromJson(Map<String, dynamic> json) =>
      _$WeatherCoordFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherCoordToJson(this);
}

@JsonSerializable()
class WeatherMain {
  WeatherMain({
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
  });

  double temp;
  int pressure;
  int humidity;
  @JsonKey(name: 'temp_min')
  double tempMin;
  @JsonKey(name: 'temp_max')
  double tempMax;

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}

@JsonSerializable()
class WeatherWind {
  WeatherWind({required this.speed});
  double speed;

  factory WeatherWind.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherWindToJson(this);
}
