import 'package:duygularimingunluguflutterarayuz/model/Client.dart';
import 'package:duygularimingunluguflutterarayuz/logIn/UserTypeSelectionPage.dart';
import 'package:duygularimingunluguflutterarayuz/profilePage/client/SearchTakip/SearchForClient.dart';
import 'package:duygularimingunluguflutterarayuz/profilePage/client/notesPart/NotesPage.dart';
import 'package:flutter/material.dart';

class ClientProfilePage extends StatelessWidget {
  late Client client;

  ClientProfilePage({required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danışan Profili'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Hoş geldiniz, ${client.username}!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Günlüğümü Yaz butonu
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Günlük'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesPage(client: client),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Takip Et'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchForClient(key: key, client: client),
                    ));
              },
            ),
            // Çıkış Yap butonu
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Çıkış Yap'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserTypeSelectionPage())); // Ana sayfaya dönme
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Kullanıcı adı ve bilgiler
            Text(
              'Hoş geldiniz, ${client.username}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _navigateToNotesPage(BuildContext context, Client client) {
    // `NotesPage` ile kullanıcı notlarını göster
  }
}
