class WeatherDataModel {
  CurrentTemp? currentTemp;
  DailyTemp? dailyTemp;

  WeatherDataModel(this.currentTemp,this.dailyTemp);

  WeatherDataModel.fromJson(Map<String,dynamic> json){
    currentTemp = CurrentTemp.fromJson(json["current"]);
    dailyTemp = DailyTemp.fromJson(json["daily"]);
  }
}

class CurrentTemp {
  double? temp;

  CurrentTemp(this.temp);

  CurrentTemp.fromJson(Map<String,dynamic> json){
    temp = json["temperature_2m"]; 
  }
}

class DailyTemp {
  List<double>? maxTemp;
  List<double>? minTemp;
  List<String>? dates;

  DailyTemp(this.maxTemp,this.minTemp);

  DailyTemp.fromJson(Map<String,dynamic> json) {
    maxTemp = json["temperature_2m_max"].cast<double>();
    minTemp = json["temperature_2m_min"].cast<double>();
    dates = json["time"].cast<String>();
  }

}