class Parlamentar {
  final int id;
  final String nomeParlamentar;
  final String fotografia;
  final String partido;

  Parlamentar({
    required this.id,
    required this.nomeParlamentar,
    required this.fotografia,
    required this.partido,
  });

  factory Parlamentar.fromJson(Map<String, dynamic> json) {
    return Parlamentar(
      id: json['id'],
      nomeParlamentar: json['nome_parlamentar'],
      fotografia: json['fotografia'],
      partido: json['partido'],
    );
  }
}
