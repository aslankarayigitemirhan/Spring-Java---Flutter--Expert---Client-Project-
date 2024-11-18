import 'package:duygularimingunluguflutterarayuz/model/Expert.dart';
import 'package:duygularimingunluguflutterarayuz/logIn/UserTypeSelectionPage.dart';
import 'package:duygularimingunluguflutterarayuz/profilePage/expert/ClientSelectionPage.dart';
import 'package:duygularimingunluguflutterarayuz/profilePage/expert/SearchTakip/TakipKontrol.dart';
import 'package:flutter/material.dart';

class ExpertProfilePage extends StatelessWidget {
  final Expert userData;

  // Kullanıcı verisini alıyoruz
  ExpertProfilePage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uzman Profili'),
      ),
      // Drawer ile yandan açılır menü ekliyoruz
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Hoş geldiniz, ${userData.username}!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Danışan Günlük Oku butonu
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Danışan Sayfası'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientSelectionPage(userData),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Danışan Takip İstekleri'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TakipKontrol(expertUsername: this.userData),
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
              'Hoş geldiniz, ${userData.username}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Branş: ${userData.branch}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
