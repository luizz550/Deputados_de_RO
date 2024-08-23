import 'package:flutter/material.dart';

class Noticia {
  final String fotografia;
  final String data;
  final String descricao;

  Noticia({
    required this.fotografia,
    required this.data,
    required this.descricao,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      fotografia: json['fotografia'] ?? 'Não disponível',
      data: json['data'] ?? 'Não disponível',
      descricao: json['descricao'] ?? 'Não disponível',
    );
  }
}

class ParlamentarDetalhes {
  final int id;
  final String nomeParlamentar;
  final String nome_completo;
  final String fotografia;
  final String partido;
  final String biografia;
  final String email;
  final String telefone;
  final String facebook;
  final String instagram;
  final List<Noticia> ultimas_noticias;

  ParlamentarDetalhes({
    required this.id,
    required this.nomeParlamentar,
    required this.nome_completo,
    required this.fotografia,
    required this.partido,
    required this.biografia,
    required this.email,
    required this.telefone,
    required this.facebook,
    required this.instagram,
    required this.ultimas_noticias,
  });

  factory ParlamentarDetalhes.fromJson(Map<String, dynamic> json) {
    var listaNoticias = json['ultimas_noticias'] as List;
    List<Noticia> noticiasList = listaNoticias.map((i) => Noticia.fromJson(i)).toList();

    return ParlamentarDetalhes(
      id: json['id'] ?? 0,
      nomeParlamentar: json['nome_parlamentar'] ?? 'Não disponível',
      nome_completo: json['nome_completo'] ?? 'Não disponível',
      fotografia: json['fotografia'] ?? 'Não disponível',
      partido: json['partido'] ?? 'Não disponível',
      biografia: json['biografia'] ?? 'Não disponível',
      email: json['contatos']['email'] ?? 'Não disponível',
      telefone: json['contatos']['telefone'] ?? 'Não disponível',
      facebook: json['rede']['facebook'] ?? 'Não disponível',
      instagram: json['rede']['instagram'] ?? 'Não disponível',
      ultimas_noticias: noticiasList,
    );
  }
}
