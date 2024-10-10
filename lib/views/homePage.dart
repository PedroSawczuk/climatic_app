import 'package:flutter/material.dart';
import 'package:climatic_app/services/weatherServices.dart';
import 'package:climatic_app/models/weatherModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherData;
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; 
    });

    try {
      WeatherServices weatherServices = WeatherServices();
      final weatherData = await weatherServices.fetchWeatherInfo(_controller.text);
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao buscar informações do tempo. Tente novamente.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Climatic',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFF9800),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Insira a Cidade',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            if (_isLoading)
              Center(child: CircularProgressIndicator(color: Colors.amber,))
            else if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              )
            else if (_weatherData != null)
              _buildWeatherInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cidade: ${_weatherData!.nameCity}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Temperatura: ${_weatherData!.temp}°C'),
        Text('Máxima: ${_weatherData!.temp_max}°C'),
        Text('Mínima: ${_weatherData!.temp_min}°C'),
        Text('Sensação Térmica: ${_weatherData!.tempSensation}°C'),
        Text('Umidade: ${_weatherData!.humidity}%'),
        Text('Pressão: ${_weatherData!.pressure} hPa'),
        Text('Descrição: ${_weatherData!.description}'),
      ],
    );
  }
}
