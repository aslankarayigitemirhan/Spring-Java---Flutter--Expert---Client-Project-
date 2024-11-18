import 'package:flutter/material.dart';
import 'package:duygularimingunluguflutterarayuz/model/Client.dart';
import 'package:duygularimingunluguflutterarayuz/model/DailyNote.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpertNotesPage extends StatefulWidget {
  final Client client; // Expert kullanıcının bilgileri
  const ExpertNotesPage({required this.client});

  @override
  _ExpertNotesPageState createState() => _ExpertNotesPageState(client);
}

class _ExpertNotesPageState extends State<ExpertNotesPage> {
  late Client client;
  List<DailyNote> _notes = [];
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _aiCommentController = TextEditingController();

  _ExpertNotesPageState(Client client) {
    this.client = client;
  }

  // Notları API'den çekme
  Future<void> _fetchNotes() async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/appapi/getAllNotes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': this.client.username}),
    );
    if (response.statusCode == 200) {
      setState(() {
        _notes = (json.decode(response.body) as List)
            .map((note) => DailyNote.fromJson(note, client))
            .toList();
      });
    } else {
      print('Failed to load notes');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Notlarım'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("Tarih: ${note.timedate}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Not: ${note.text}"),
                        Text("AI Comment: ${note.aiComment}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
