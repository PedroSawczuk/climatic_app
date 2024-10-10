import 'package:climatic_app/models/weatherModel.dart';
import 'package:dio/dio.dart';

class WeatherServices {
  final Dio _dio = Dio();

  Future<WeatherModel> fetchWeatherInfo(String nameCity) async {
    try {
      final response = await _dio.get(
          'https://api.openweathermap.org/data/2.5/weather?q=$nameCity&appid=89549a0c1ef4ac878894ea64735fd60d&units=metric&lang=pt_br');
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        print('Erro ao buscar: ${response.statusCode}');
        throw Exception('Erro ao buscar: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e'); // Imprime a mensagem do erro no console
      throw Exception('Erro ao buscar informações: $e');
    }
  }
}
