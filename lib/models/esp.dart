

class ESP{
  final String caseName;
  final String caseType;
  final Map<String, dynamic> sensors;

  ESP({ this.caseName, this.caseType, this.sensors });

  void setSensorsValue(String sensorName, dynamic value){
    if(sensorName != "" && value != null){
      sensors[sensorName] = value;
    }
  }
}