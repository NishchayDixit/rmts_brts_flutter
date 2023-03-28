class BrtsPickupPoints {
  final int BrtsPickupPointID;
  final String BrtsPickUpPointName;

  const BrtsPickupPoints({
    required this.BrtsPickupPointID,
    required this.BrtsPickUpPointName,
  });

  @override
  String toString() {
    return BrtsPickupPointID.toString();
  }

  factory BrtsPickupPoints.fromJSON(Map<String, dynamic> json) {
    return BrtsPickupPoints(
      BrtsPickupPointID: int.parse(json['BrtsPickUpPointID'].toString()),
      BrtsPickUpPointName:json['BrtsPickUpPointName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'BrtsPickUpPointID':BrtsPickupPointID,
    'BrtsPickUpPointName':BrtsPickUpPointName,
  };
}
