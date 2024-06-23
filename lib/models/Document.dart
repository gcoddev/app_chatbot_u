class Document {
  final int idDoc;
  final String titulo;
  final String descripcion;
  final String documento;
  final String estado;
  final DateTime creadoEl;
  final int idUser;

  Document({
    required this.idDoc,
    required this.titulo,
    required this.descripcion,
    required this.documento,
    required this.estado,
    required this.creadoEl,
    required this.idUser,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      idDoc: json['id_doc'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      documento: json['documento'],
      estado: json['estado'],
      creadoEl: DateTime.parse(json['creado_el']),
      idUser: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_doc': idDoc,
      'titulo': titulo,
      'descripcion': descripcion,
      'documento': documento,
      'estado': estado,
      'creado_el': creadoEl.toIso8601String(),
      'id_user': idUser,
    };
  }
}
