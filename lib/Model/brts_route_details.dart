class BrtsRouteDetails {
  final BrtsFare;
  final BrtsDistance;
  final BrtsTravellingTime;

  const BrtsRouteDetails({
    required this.BrtsFare,
    required this.BrtsDistance,
    required this.BrtsTravellingTime,
  });

  factory BrtsRouteDetails.fromJSON(Map<String, dynamic> json) {
    return BrtsRouteDetails(
      BrtsFare: json['BrtsFare'],
      BrtsDistance: json['BrtsDistance'],
      BrtsTravellingTime: json['BrtsTravellingTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'BrtsFare': BrtsFare,
        'BrtsDistance': BrtsDistance,
        'BrtsTravellingTime': BrtsTravellingTime,
      };
}
