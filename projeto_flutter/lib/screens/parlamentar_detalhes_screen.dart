import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/parlamentar_detalhes.dart';

class ParlamentarDetalhesScreen extends StatefulWidget {
  final int id;

  ParlamentarDetalhesScreen({required this.id});

  @override
  _ParlamentarDetalhesScreenState createState() => _ParlamentarDetalhesScreenState();
}

class _ParlamentarDetalhesScreenState extends State<ParlamentarDetalhesScreen> {
  late Future<ParlamentarDetalhes> _parlamentarDetalhes;

  @override
  void initState() {
    super.initState();
    _parlamentarDetalhes = ApiService.fetchParlamentarDetalhes(widget.id);
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Parlamentar'),
      ),
      body: FutureBuilder<ParlamentarDetalhes>(
        future: _parlamentarDetalhes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Nenhuma informação encontrada'));
          } else {
            final detalhes = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.network(
                            detalhes.fotografia,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8),
                          Text(detalhes.nomeParlamentar, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(detalhes.nome_completo, style: TextStyle(fontSize: 20)),
                          SizedBox(height: 8),
                          Text('Partido: ${detalhes.partido}', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 16),
                          Text(' ${detalhes.email}', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Text('Biografia:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(detalhes.biografia, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => _launchURL(detalhes.facebook),
                            child: Image.asset(
                              'lib/img/iconfacebook.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () => _launchURL(detalhes.instagram),
                            child: Image.asset(
                              'lib/img/iconinstagram.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Últimas Notícias:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    ...detalhes.ultimas_noticias.map((noticia) => Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              noticia.fotografia,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 8),
                            Text(
                              noticia.data,
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              noticia.descricao,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
