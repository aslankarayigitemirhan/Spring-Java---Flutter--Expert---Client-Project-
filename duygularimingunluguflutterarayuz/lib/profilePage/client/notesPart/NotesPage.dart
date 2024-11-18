import 'package:duygularimingunluguflutterarayuz/model/Client.dart';
import 'package:duygularimingunluguflutterarayuz/model/DailyNote.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotesPage extends StatefulWidget {
  final Client client; // Kullanıcı ID'si, notlara özel veri çekmek için
  const NotesPage({required this.client});

  @override
  _NotesPageState createState() => _NotesPageState(client);
}

class _NotesPageState extends State<NotesPage> {
  late Client client;
  List<DailyNote> _notes = [];
  _NotesPageState(Client client) {
    this.client = client;
  }

  Future<void> _saveNote(String text, String dailyNoteID) async {
    final requestBody = {
      "client": {"username": widget.client.username},
      "dailyNote": {"dailynoteID": dailyNoteID},
      "message": text,
    };

    print("Request Body: ${json.encode(requestBody)}");

    final response = await http.put(
      Uri.parse('http://localhost:8080/appapi/editNote'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );
    if (response.statusCode == 201) {
      _fetchNotes(); // Notları güncelle
    } else {
      print('Failed to save note');
    }
  }

  // Notları API'den çekme
  Future<void> _fetchNotes() async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/appapi/getAllNotes'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': this.client.username}));
    if (response.statusCode == 200) {
      setState(() {
        _notes = (json.decode(response.body) as List)
            .map((note) => DailyNote.fromJson(note, client))
            .toList();
      });
    } else {
      // Hata durumu
      print('Failed to load notes');
    }
  }

  // Notu düzenleme
  Future<void> _editNote(String newText) async {
    final response = await http.put(
      Uri.parse('http://localhost:8080/appapi/createNote'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'client': {'username': this.client.username},
        'message': newText
      }),
    );
    if (response.statusCode == 200) {
      _fetchNotes(); // Notları güncelle
    } else {
      print('Failed to edit note');
    }
  }

  // Notu silme
  Future<void> _deleteNote(String noteId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:8080/appapi/deleteDailyNote'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'client': {'username': this.client.username},
        'dailyNoteID': noteId
      }),
    );
    if (response.statusCode == 200) {
      _fetchNotes(); // Notları güncelle
    } else {
      print('Failed to delete note');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Sayfa yüklendiğinde notları getir
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notlarım'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note.timedate),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _showEditDialog(note.dailynoteID, note.text),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteNote(note.dailynoteID),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        _textController, // TextField için bir controller ekliyoruz
                    decoration: const InputDecoration(
                      hintText: 'Yeni bir not girin...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons
                      .save), // Kaydet butonu olarak bir simge kullanıyoruz
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _editNote(_textController
                          .text); // Butona tıklandığında metni kaydet
                      _textController
                          .clear(); // Kaydedildikten sonra TextField'ı temizle
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(String noteId, String currentText) {
    final controller = TextEditingController(text: currentText);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Günlüğü yazın'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _saveNote(controller.text, noteId);
                Navigator.pop(context);
              },
              child: const Text('Kaydet'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );
  }
}
