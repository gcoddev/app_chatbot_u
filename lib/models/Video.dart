class Video {
  final int idVideo;
  final String titulo;
  final String url;
  final String descripcion;
  final String estado;
  final DateTime creadoEl;
  final int idUser;

  Video({
    required this.idVideo,
    required this.titulo,
    required this.url,
    required this.descripcion,
    required this.estado,
    required this.creadoEl,
    required this.idUser,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      idVideo: json['id_video'],
      titulo: json['titulo'],
      url: json['url'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      creadoEl: DateTime.parse(json['creado_el']),
      idUser: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_video': idVideo,
      'titulo': titulo,
      'url': url,
      'descripcion': descripcion,
      'estado': estado,
      'creado_el': creadoEl.toIso8601String(),
      'id_user': idUser,
    };
  }
}
