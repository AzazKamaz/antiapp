// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) {
  return WeatherModel(
    coord: WeatherCoord.fromJson(json['coord'] as Map<String, dynamic>),
    main: WeatherMain.fromJson(json['main'] as Map<String, dynamic>),
    name: json['name'] as String,
    wind: WeatherWind.fromJson(json['wind'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'main': instance.main,
      'wind': instance.wind,
      'name': instance.name,
    };

WeatherCoord _$WeatherCoordFromJson(Map<String, dynamic> json) {
  return WeatherCoord(
    lon: (json['lon'] as num).toDouble(),
    lat: (json['lat'] as num).toDouble(),
  );
}

Map<String, dynamic> _$WeatherCoordToJson(WeatherCoord instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

WeatherMain _$WeatherMainFromJson(Map<String, dynamic> json) {
  return WeatherMain(
    temp: (json['temp'] as num).toDouble(),
    pressure: json['pressure'] as int,
    humidity: json['humidity'] as int,
    tempMin: (json['temp_min'] as num).toDouble(),
    tempMax: (json['temp_max'] as num).toDouble(),
  );
}

Map<String, dynamic> _$WeatherMainToJson(WeatherMain instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
    };

WeatherWind _$WeatherWindFromJson(Map<String, dynamic> json) {
  return WeatherWind(
    speed: (json['speed'] as num).toDouble(),
  );
}

Map<String, dynamic> _$WeatherWindToJson(WeatherWind instance) =>
    <String, dynamic>{
      'speed': instance.speed,
    };
