import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP paketini eklemelisiniz

class RegisterScreenForClient extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreenForClient> {
  // Form alanları için TextEditingController tanımları
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // API isteği gönderme fonksiyonu
  Future<void> _registerUser() async {
    final url = Uri.parse(
        'http://localhost:8080/appapi/saveClient'); // Android emülatör için IP

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarılı: ${response.body}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata oluştu: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: "İsim"),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: "Soyisim"),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Kullanıcı Adı"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Şifre"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: Text("Kayıt Ol"),
            ),
          ],
        ),
      ),
    );
  }
}