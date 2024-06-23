class Blog {
  final int idBlog;
  final String titulo;
  final String descripcion;
  final String imagen;
  final String contenido;
  final String estado;
  final DateTime creadoEl;
  final int idUser;

  Blog({
    required this.idBlog,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
    required this.contenido,
    required this.estado,
    required this.creadoEl,
    required this.idUser,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      idBlog: json['id_blog'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
      contenido: json['contenido'],
      estado: json['estado'],
      creadoEl: DateTime.parse(json['creado_el']),
      idUser: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_blog': idBlog,
      'titulo': titulo,
      'descripcion': descripcion,
      'imagen': imagen,
      'contenido': contenido,
      'estado': estado,
      'creado_el': creadoEl.toIso8601String(),
      'id_user': idUser,
    };
  }
}
