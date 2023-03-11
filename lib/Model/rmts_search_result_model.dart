class RmtsSearchResultModel {
  final RouteID,RouteNameEnglish,BusNo;

  const RmtsSearchResultModel({
    required this.RouteID,
    required this.RouteNameEnglish,
    required this.BusNo,
  });

  factory RmtsSearchResultModel.fromJSON(Map<String, dynamic> json) {
    return RmtsSearchResultModel(
      RouteID: json['RouteID'],
      RouteNameEnglish:json['RouteNameEnglish'],
      BusNo: json['BusNo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'RouteID':RouteID,
    'RouteNameEnglish':RouteNameEnglish,
    'BusNo':BusNo,
  };
}
