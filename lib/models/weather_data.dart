class WeatherModel{
  late String location;
  late WeatherCondition condition;
  late double temp;

  WeatherModel.fromJson(Map<String, dynamic> json){
    if(json=={}) {
      this.location = "";
      this.condition = WeatherCondition.fromJson({});
      this.temp = 0;
    }
    this.location = json["location"]["name"];
    this.condition = WeatherCondition.fromJson(json["current"]["condition"]);
    this.temp = json["current"]["temp_c"];
  }

}
class WeatherCondition{
  late String type, url;
  WeatherCondition.fromJson(Map<String, dynamic> json){
    if(json=={}) {
      this.type = "";
      this.url="";
    }
    this.type = json["text"];
    this.url = json["icon"];
  }
}