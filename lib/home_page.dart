import 'dart:convert';

import 'package:appapi/model/Digimon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Digimon>> listarDigimons() async {
    var url = Uri.parse('https://digimon-api.vercel.app/api/digimon');
    http.Response response = await http.get(url);

    List<Digimon> lista = [];

    if (response.statusCode == 200) {
      var dadosJson = json.decode(response.body);

      for (var item in dadosJson) {
        Digimon obj = Digimon(
          name: item['name'],
          img: item['img'],
          level: item['level'],
        );

        lista.add(obj);
      }
      print('Status da resposta: ${response.statusCode}');
      print('reposta da API: ' + response.body.toString());

      return lista;
    } else {
      throw Exception(
          'Falha ao carregar a lista de Digimons erro: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consumir API'),
          backgroundColor: Colors.blueAccent,
        ),
        body: FutureBuilder<List<Digimon>>(
            future: listarDigimons(),
            builder: (context, snaphot) {
              if (snaphot.connectionState == ConnectionState.none ||
                  snaphot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snaphot.data?.length,
                    itemBuilder: (context, index) {
                      List<Digimon>? digimons = snaphot.data;
                      return ListTile(
                        leading: ClipOval(
                          child: Image.network(digimons?[index].img ?? ''),
                        ),
                        title: Text('${digimons?[index].name}'),
                        subtitle: Text('level: ${digimons?[index].level}'),
                      );
                    });
              }
            }));
  }
}
