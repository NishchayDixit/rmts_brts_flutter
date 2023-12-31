class RmtsLiveBusModel {
  final BoxId,
      VehName,
      DriverName,
      Speed,
      Location,
      Lastdate,
      Distance,
      Latitude,
      Longitude,
      VehicleStatus,
      ACStatus,
      RouteNo,
      RouteName,
      Busno,
      Vstatus,
      ResponseStatus,
      A_BusNo;

  const RmtsLiveBusModel({
    required this.BoxId,
    required this.VehName,
    required this.DriverName,
    required this.Speed,
    required this.Location,
    required this.Lastdate,
    required this.Distance,
    required this.Latitude,
    required this.Longitude,
    required this.VehicleStatus,
    required this.ACStatus,
    required this.RouteNo,
    required this.RouteName,
    required this.Busno,
    required this.Vstatus,
    required this.ResponseStatus,
    required this.A_BusNo,
  });

  factory RmtsLiveBusModel.fromJSON(Map<String, dynamic> json) {
    return RmtsLiveBusModel(
      BoxId: json['BoxId'],
      VehName: json['VehName'],
      DriverName: json['DriverName'],
      Speed: json['Speed'],
      Location: json['Location'],
      Lastdate: json['Lastdate'],
      Distance: json['Distance'],
      Latitude: json['Latitude'],
      Longitude: json['Longitude'],
      VehicleStatus: json['VehicleStatus'],
      ACStatus: json['ACStatus'],
      RouteNo: json['RouteNo'],
      RouteName: json['RouteName'],
      Busno: json['Busno'],
      Vstatus: json['Vstatus'],
      ResponseStatus: json['ResponseStatus'],
      A_BusNo: json['A_BusNo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'BoxId': BoxId,
        'VehName': VehName,
        'DriverName': DriverName,
        'Speed': Speed,
        'Location': Location,
        'Lastdate': Lastdate,
        'Distance': Distance,
        'Latitude': Latitude,
        'Longitude': Longitude,
        'VehicleStatus': VehicleStatus,
        'ACStatus': ACStatus,
        'RouteNo': RouteNo,
        'RouteName': RouteName,
        'Busno': Busno,
        'Vstatus': Vstatus,
        'ResponseStatus': ResponseStatus,
        'A_BusNo': A_BusNo,
      };
}
