import 'package:duygularimingunluguflutterarayuz/model/Client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchForClient extends StatefulWidget {
  final Client client;

  const SearchForClient({Key? key, required this.client}) : super(key: key);

  @override
  _SearchForClientState createState() => _SearchForClientState();
}

class _SearchForClientState extends State<SearchForClient> {
  late Future<List<dynamic>> allExperts;

  @override
  void initState() {
    super.initState();
    allExperts = _fetchAllExperts();
  }

  Future<List<dynamic>> _fetchAllExperts() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/appapi/getAllExperts'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Experts listesi yüklenirken bir hata oluştu!');
    }
  }

  Future<void> _sendFollowRequest(String expertUsername) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/appapi/request'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "expert": {"username": expertUsername},
        "client": {"username": widget.client.username}
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Takip isteği gönderildi: $expertUsername')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Takip isteği başarısız oldu!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tüm Expert Listesi'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: allExperts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Henüz Expert bulunmamaktadır.'));
          } else {
            final experts = snapshot.data!;
            return ListView.builder(
              itemCount: experts.length,
              itemBuilder: (context, index) {
                final expert = experts[index];
                return ListTile(
                  title: Text('${expert['firstName']} ${expert['lastName']}'),
                  subtitle: Text('Branş: ${expert['branch']}'),
                  trailing: ElevatedButton(
                    onPressed: () => _sendFollowRequest(expert['username']),
                    child: const Text('Takip Et'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
