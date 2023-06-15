class Appointment {
  final int id;
  final String appointment;
  final String sns;
  final String appointmentDate;
  final int idFacility;
  final int idTravel;
  String nameFacility;

  Appointment({
    required this.id,
    required this.appointment,
    required this.sns,
    required this.appointmentDate,
    required this.idFacility,
    required this.idTravel,
    required this.nameFacility,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id_appointment'],
      appointment: json['appointment'],
      sns: json['sns'],
      appointmentDate: json['appointment_date'],
      idFacility: json['id_facility'],
      idTravel: json['id_travel'],
      nameFacility: '', // The 'nameFacility' will be populated separately
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_appointment': id,
      'appointment': appointment,
      'sns': sns,
      'appointment_date': appointmentDate,
      'id_facility': idFacility,
      'id_travel': idTravel
      // The 'nameFacility' will not be included in the JSON output
    };
  }
}
