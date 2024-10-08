
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());

   List<WeatherModel>? weatherModelList;
   WeatherModel ?weatherModel;
  
  getCurrentWeather({required String cityName}) async {
   try {
    emit(WeatherLoadingState());
   weatherModelList= await WeatherService(Dio()).getCurrentWeather(cityName: cityName);
   weatherModel=weatherModelList![0];
  emit(WeatherLoadedState(weatherModel: weatherModelList!));
}  catch (e) {
  emit(WeatherFailureState(
    error: e.toString(),
  ));
}

  }

}