class BrtsPickupPoints {
  final BrtsPickupPointID,BrtsPickUpPointName;

  const BrtsPickupPoints({
    required this.BrtsPickupPointID,
    required this.BrtsPickUpPointName,
  });

  factory BrtsPickupPoints.fromJSON(Map<String, dynamic> json) {
    return BrtsPickupPoints(
      BrtsPickupPointID: json['BrtsPickupPointID'],
      BrtsPickUpPointName:json['BrtsPickUpPointName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'BrtsPickupPointID':BrtsPickupPointID,
    'BrtsPickUpPointName':BrtsPickUpPointName,
  };
}
