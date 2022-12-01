package kopo.poly.service;

import kopo.poly.dto.WeatherDTO;

public interface IWeatherService {

    String apiURL = "https://api.openweathermap.org/data/2.5/forecast";

    WeatherDTO getWeather(WeatherDTO pDTO) throws Exception;
}
