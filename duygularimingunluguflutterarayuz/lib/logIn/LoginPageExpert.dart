import 'dart:convert';
import 'package:duygularimingunluguflutterarayuz/profilePage/expert/ExpertProfilePage.dart';
import 'package:flutter/material.dart';
import "../model/Expert.dart";
import 'package:http/http.dart' as http;

class LoginPageExpert extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageExpert> {
  // Controller'lar
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // API URL
  final String apiUrl = "http://localhost:8080/appapi/logIn/expert";

  // Giriş işlemi
  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    // API'ye POST isteği gönderme
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      // API başarılı yanıt verdiyse
      final Map<String, dynamic> data = jsonDecode(response.body);
      Expert expert = Expert.fromJson(data);
      // Kullanıcı bilgilerini al ve yönlendir
      if (data['success']) {
        // Başarılı giriş
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpertProfilePage(userData: expert),
          ),
        );
      } else {
        // Başarısız giriş
        _showErrorDialog('Hatalı kullanıcı adı veya şifre');
      }
    } else {
      // API hata verdi
      _showErrorDialog('Sunucu hatası, lütfen tekrar deneyin');
    }
  }

  // Hata mesajı gösterme
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Girişi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Şifre',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, // Giriş yap fonksiyonunu çağırıyoruz
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
