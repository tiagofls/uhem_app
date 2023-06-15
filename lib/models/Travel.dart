class Travel {
  final String? dateTravel;
  final String? idTravelPurpose;
  final String? idFacility;
  final String? wayTravel;
  final String? duration;

  Travel({
    this.dateTravel,
    this.idTravelPurpose,
    this.idFacility,
    this.wayTravel,
    this.duration,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      dateTravel: json['date'],
      idTravelPurpose: json['purpose'],
      idFacility: json['facility'],
      wayTravel: json['start'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': dateTravel,
        'purpose': idTravelPurpose,
        'facility': idFacility,
        'start': wayTravel,
        'duration': duration,
      };
}
