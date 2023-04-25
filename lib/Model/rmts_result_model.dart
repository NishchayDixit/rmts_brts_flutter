class RmtsResultModel {
  final RouteID, RouteNameEnglish, BusNo;

  const RmtsResultModel({
    required this.RouteID,
    required this.RouteNameEnglish,
    required this.BusNo,
  });

  factory RmtsResultModel.fromJSON(Map<String, dynamic> json) {
    return RmtsResultModel(
      RouteID: json['RouteID'],
      RouteNameEnglish: json['RouteNameEnglish'],
      BusNo: json['BusNo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'RouteID': RouteID,
        'RouteNameEnglish': RouteNameEnglish,
        'BusNo': BusNo,
      };
}
