import 'package:duygularimingunluguflutterarayuz/model/Expert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TakipKontrol extends StatefulWidget {
  final Expert expertUsername; // Expert'in username'i
  const TakipKontrol({required this.expertUsername});

  @override
  _ExpertPageState createState() => _ExpertPageState();
}

class _ExpertPageState extends State<TakipKontrol> {
  List<Map<String, dynamic>> _followRequests = [];

  // Gelen takip isteklerini çekme
  Future<void> _fetchFollowRequests() async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/appapi/getFollowRequests'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": widget.expertUsername.username}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _followRequests =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Takip isteklerini yükleme başarısız.');
    }
  }

  // Takip isteğini kabul etme
  Future<void> _acceptRequest(String clientUsername) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/appapi/acceptClient'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "expert": {"username": widget.expertUsername.username},
        "client": {"username": clientUsername}
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Takip isteği kabul edildi: $clientUsername')),
      );
      _fetchFollowRequests();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Takip isteği kabul edilemedi!')),
      );
    }
  }

  // Takip isteğini reddetme
  Future<void> _rejectRequest(String clientUsername) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/requestReject'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "expert": {"username": widget.expertUsername},
        "client": {"username": clientUsername}
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Takip isteği reddedildi: $clientUsername')),
      );
      _fetchFollowRequests();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Takip isteği reddedilemedi!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFollowRequests(); // Sayfa yüklendiğinde takip isteklerini getir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gelen Takip İstekleri'),
      ),
      body: _followRequests.isEmpty
          ? const Center(child: Text('Henüz gelen takip isteği yok.'))
          : ListView.builder(
              itemCount: _followRequests.length,
              itemBuilder: (context, index) {
                final request = _followRequests[index];
                return ListTile(
                  title: Text('Danışan: ${request['username']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => _acceptRequest(request['username']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _rejectRequest(request['username']),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
