class RmtsPickupPoints {
  final PickupPointID,PickupPointNameEnglish,PickupPointName;

  @override
  String toString() {
    // TODO: implement toString
    return this.PickupPointNameEnglish;
  }

  const RmtsPickupPoints({
    required this.PickupPointID,
    required this.PickupPointNameEnglish,
    required this.PickupPointName,
  });

  factory RmtsPickupPoints.fromJSON(Map<String, dynamic> json) {
    return RmtsPickupPoints(
      PickupPointID: json['PickupPointID'],
      PickupPointNameEnglish:json['PickupPointNameEnglish'],
      PickupPointName: json['PickupPointName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'PickupPointID':PickupPointID,
    'PickupPointNameEnglish':PickupPointNameEnglish,
    'PickupPointName':PickupPointName,
  };
}
