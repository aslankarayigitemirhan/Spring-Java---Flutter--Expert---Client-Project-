import 'package:duygularimingunluguflutterarayuz/model/Expert.dart';
import 'package:duygularimingunluguflutterarayuz/profilePage/expert/notesPart/ExpertNotesPage.dart';
import 'package:flutter/material.dart';
import 'package:duygularimingunluguflutterarayuz/model/Client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClientSelectionPage extends StatefulWidget {
  late Expert expert;
  ClientSelectionPage(Expert expert) {
    this.expert = expert;
  }

  @override
  _ClientSelectionPageState createState() => _ClientSelectionPageState(expert);
}

class _ClientSelectionPageState extends State<ClientSelectionPage> {
  late Expert expert;
  List<Client> _clients = [];
  bool _isLoading = false;
  _ClientSelectionPageState(Expert expert) {
    this.expert = expert;
  }
  // Danışanları API'den çekme
  int _currentPage = 0;
  final int _pageSize = 20;

  Future<void> _fetchClients() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
        Uri.parse('http://localhost:8080/appapi/getMyClients'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"username": this.expert.username}));

    if (response.statusCode == 200) {
      setState(() {
        _clients.addAll((json.decode(response.body) as List)
            .map((client) => Client.fromJson(client))
            .toList());
        _currentPage++; // Bir sonraki sayfa için sayfa numarasını artır
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Failed to load clients');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchClients(); // Sayfa yüklendiğinde danışanları getir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danışan Seçimi'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                final client = _clients[index];
                return Card(
                  child: ListTile(
                    title: Text(client.username), // Danışanın ismi
                    subtitle: Text(
                        'Name & Surname: ${client.firstName + " " + client.lastName}'), // Danışanın ID'si
                    onTap: () {
                      // Danışanı seçip ExpertNotesPage'e yönlendiriyoruz
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExpertNotesPage(client: client),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
