class Contatos {
  final String email;
  final String telefone;

  Contatos({
    required this.email,
    required this.telefone,
  });

  factory Contatos.fromJson(Map<String, dynamic> json) {
    return Contatos(
      email: json['email'] ?? 'Email não disponível',
      telefone: json['telefone'] ?? 'Telefone não disponível',
    );
  }
}
