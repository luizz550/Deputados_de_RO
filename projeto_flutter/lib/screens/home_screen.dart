import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/parlamentar.dart';  
import '../screens/parlamentar_detalhes_screen.dart';// Certifique-se de que o nome do arquivo e a classe estejam corretos

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Parlamentar>> _parlamentares;

  @override
  void initState() {
    super.initState();
    _parlamentares = ApiService.fetchParlamentares();  // Chama o serviço para buscar os parlamentares
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parlamentares'),
      ),
      body: FutureBuilder<List<Parlamentar>>(
        future: _parlamentares,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum parlamentar encontrado'));
          } else {
            final parlamentares = snapshot.data!;
            return ListView.builder(
              itemCount: parlamentares.length,
              itemBuilder: (context, index) {
                final parlamentar = parlamentares[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(parlamentar.fotografia),  // Imagem do parlamentar
                  ),
                  title: Text(parlamentar.nomeParlamentar ?? 'Nome não disponível'),
                  subtitle: Text(parlamentar.partido ?? 'Partido não disponível'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParlamentarDetalhesScreen(id: parlamentar.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
