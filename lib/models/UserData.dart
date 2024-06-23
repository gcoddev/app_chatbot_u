class UserData {
  final int id;
  final String ci;
  final String expedido;
  final String paterno;
  final String materno;
  final String nombres;
  final String nacimiento;
  final int celular;
  final String email;
  final String username;

  UserData({
    required this.id,
    required this.ci,
    required this.expedido,
    required this.paterno,
    required this.materno,
    required this.nombres,
    required this.nacimiento,
    required this.celular,
    required this.email,
    required this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      ci: json['ci'],
      expedido: json['expedido'],
      paterno: json['paterno'],
      materno: json['materno'],
      nombres: json['nombres'],
      nacimiento: json['nacimiento'],
      celular: json['celular'],
      email: json['email'],
      username: json['username'],
    );
  }
}
